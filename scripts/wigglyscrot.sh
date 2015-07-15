#!/bin/sh

if [ -z "$1" ]; then
  SCRTPTH=$(mktemp -p /run/user/$UID/ --suffix=.png)
  scrot $SCRTPTH -q 100%
else
  SCRTPTH=$(mktemp -p /run/user/$UID/ --suffix=.png)
  scrot $SCRTPTH "$1" -q 100%
fi

rsync $SCRTPTH fubinaca:/home/wigglytuff/wigglytuff.org/images -q
echo "https://wigglytuff.org/images/$SCRTPATH" | xclip -selection c
rm $SCRTPATH
