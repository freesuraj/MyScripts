#!/bin/sh

# Publish.sh is a command line script to help you publish a post to github page quickly for github page using Jekyll template.
# To start up please setup github name first

########################
# User Input 
########################

title=""
user=""
tags=""
file=""
path="_posts"

Show_Help() {

  if [ "$1" != "" ]; then
    echo "Error:
    Empty $1
    "
  fi

  echo "Publish is a command to publish a markdown file to github personal website.

  Usage:
            publish [options]

  The options are:
    -u : github user name
    -t : title
    -g : tags
    -f : the input md file

  example:
    publish -t TITLE -g tag1 tag2 -f /path/to/md/file.md -u githubUsername
      OR
    publish -f /path/to/md/file.md -u githubUsername
  "
  exit 1
}

while getopts "u:t:g:f:h" flag; do
  case $flag in
    u) user="$OPTARG" ;;
    t) title="$OPTARG" ;;
    g) tags="$OPTARG" ;;
    f) file="$OPTARG" ;;
  esac
done

if [ "$file" = "" ]; then
  Show_Help file
elif [ "$user" = "" ]; then
  Show_Help user
else
  body=`cat $file`
  if [ "$body" = "" ]; then
    echo "Error: The md file is empty"
    exit 1
  fi
fi

if [ "$title" = "" ]; then
  title=`head -n 1 $file | sed -E 's/([#\*_=]+)(.+)/\2/'`
fi

dateValue=`date +%Y-%m-%d`
newpost="$dateValue-${title// /_}.md"

# metadata of the post
header="---
layout: post
title: $title
tags: $tags
date: `date +"%Y-%m-%d %H:%M:%S"`
---
"

########################
# Git clone and update 
########################

# Temporary directory where repo will be downloaded
dir="$HOME/.tmp"
repoDir="${user}.github.io"
repo="git@github.com:${user}/${repoDir}.git"

mkdir $dir
cd $dir
git clone $repo
cd $repoDir

touch _posts/$newpost
echo "Created a post at temporary directory ${dir}/${repoDir}/_posts/${newpost}"

echo "$header" >> _posts/$newpost
echo "$body" >> _posts/$newpost

# location
git add .
git commit -m "Add a new post: $title"
git push origin master
echo "file successfully updated to remote from $repoDir"

cd 
rm -rf $dir
echo "Temporary directory deleted"
echo "Completed!!"