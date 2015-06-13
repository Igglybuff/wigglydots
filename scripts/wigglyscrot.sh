#!/bin/sh

if [ -z "$1" ]; then
  scrot scrot.png
else
  scrot "$1" scrot.png
fi

rsync scrot.png fubinaca:/home/wigglytuff/wigglytuff.org/images -q
echo "https://wigglytuff.org/images/scrot.png"
rm scrot.png
