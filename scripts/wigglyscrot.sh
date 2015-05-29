#!/bin/sh

if [ -z "$1" ]; then
  scrot scrot.png
else
  scrot -s scrot.png
fi

rsync scrot.png fubinaca:/home/wigglytuff/wigglytuff.org/images -q
echo "http://wigglytuff.org/images/scrot.png"
rm scrot.png
