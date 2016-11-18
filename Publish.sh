#!/bin/sh

# Publish.sh is a command line script to help you publish a post to github page quickly for github page using Jekyll template.
# To start up please setup github name first

# Get user inputs
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
    publish -t TITLE -g tag1 tag2 -f /path/to/md/file.md
      OR
    publish -f /path/to/md/file.md
  "
  exit 1
}

while getopts "t:c:g:f:h" flag; do
  case $flag in
    u) user="$OPTARG" ;;
    t) title="$OPTARG" ;;
    g) tags="$OPTARG" ;;
    f) file="$OPTARG" ;;
  esac
done

if [ "$file" = "" ]; then
  Show_Help file
else
  # Read file content
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
date: `date +%Y-%m-%d:%H:%M:%S`
---
"

### Git clone and update 
# Temporary directory where repo will be downloaded
dir="./tmp/"
repoDir="{user}.github.io.git"
repo="git@github.com/${user}/{repoDir}"
cd $dir
git clone $repo
cd $repoDir
loc1=`pwd` # Current directory

echo "$header" >> $repoDir/_posts/$newpost
echo "$body" >> $repoDir/_posts/$newpost
echo "file successfully written at $newpost"

# location
git add .
git commit -m "Add a new post: $title"
git push origin master
echo "file successfully updated at $gitrepo"

cd $dir
rm -rf $repoDir

echo "Completed!!"