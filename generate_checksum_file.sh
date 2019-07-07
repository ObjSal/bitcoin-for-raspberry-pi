#!/bin/bash

FILE="SHA256SUMS"

if [ -f "$FILE" ] ; then rm $FILE ; fi
if [ -f "$FILE.asc" ] ; then rm $FILE.asc ; fi

for f in bitcoin*; do echo $(sha256sum -b $f) >> $FILE ; done
echo $(sha256sum -b test_bitcoin) >> $FILE

# echo "One more step: gpg --clearsign $FILE && rm $FILE"
#echo Password:
gpg --clearsign $FILE
rm $FILE

