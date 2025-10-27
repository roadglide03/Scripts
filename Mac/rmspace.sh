#! /bin/sh

for n in *
do
OldName=$n
NewName=`echo $n | tr -d " "`
#NewName=`echo $n | tr -s " " "_"`
echo $NewName
mv "$OldName" "$NewName"
done
