#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"
cd $DIR

FILE=nyud2_data.tgz
URL=ftp://ftp.cs.berkeley.edu/pub/projects/vision/sgupta-distillation/$FILE
CHECKSUM=ce139c86cf0c2389e477786208d74b4d

if [ -f $FILE ]; then
  echo "File already exists. Checking md5..."
  os=`uname -s`
  if [ "$os" = "Linux" ]; then
    checksum=`md5sum $FILE | awk '{ print $1 }'`
  elif [ "$os" = "Darwin" ]; then
    checksum=`cat $FILE | md5`
  fi
  if [ "$checksum" = "$CHECKSUM" ]; then
    echo "Checksum is correct. No need to download."
    exit 0
  else
    echo "Checksum is incorrect. Need to download again."
  fi
fi

echo "Downloading NYUD2 images and benchmark data (1.0G)..."

wget $URL -O $FILE

echo "Unzipping..."

tar zxvf $FILE

echo "Done. Please run this command again to verify that checksum = $CHECKSUM."