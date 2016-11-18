#!/bin/sh


RED='\033[00;31m'
GREEN='\033[00;32m'
RESTORE='\033[0m'

Show_Help() {
  echo "${RESTORE}
  +------------+
  | ${GREEN}iconsCreator ${RESTORE}|
  +------------+
  iconsCreator is a helper to quickly create icons of different sizes required for iOS from an input image.

  Usage:
      ${RED}iconsCreator filename.png
  ${RESTORE}
  "
  exit 1
}

if which convert >/dev/null; then
  echo "🚀 imagemagick is found"
else
  echo "
  ${RED}ERROR${RESTORE}: imagemagic is not installed. Please run ${GREEN}brew install imagemagick${RESTORE} to install it first"
  exit 1
fi

if [ $1 = "" ]; then
  echo "Please provide an image"
  Show_Help
fi

input=$1

# Verify input is a valid image
dimension=`convert $1 -ping -format "%w x %h" info:`
if [ "$dimension" = "" ]; then
  Show_Help
else
  echo "Input image size:$dimension"
fi
FILE=$1
DIR=$(dirname "$1")
cd $DIR
folderName="AppIcon.AppIconSet"
mkdir $folderName
# Convert image
sizes=( "20x20" "29x29" "40x40" "50x50" "58x58" "60x60" "72x72" "76x76" "80x80" "87x87" "100x100" "120x120" "144x144" "152x152" "167x167" "180x180" )

for size in "${sizes[@]}"
do
  :
  convert $input -resize $size "$folderName"/iOS_"$size".png
done

open $DIR
