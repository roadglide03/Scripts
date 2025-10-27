#!/bin/sh
#
#
#Make Diskgroups
dn=ora...dg

for i in 01 02 03 04 05 
do

vxdg init $dn $dn$i=<device>
# Make redo logs
for i in 01 02 03 04 05 06 07 08 09 10
do

/usr/sbin/vxassist -g orcp-raw01 make redo-$i-52m 52M layout=nostripe,log alloc="c2t0d0-raw01" 
/usr/sbin/vxedit  -g orcp-raw01  set user="oracle" redo-$i-52m
/usr/sbin/vxedit  -g orcp-raw01  set group="dba" redo-$i-52m
/usr/sbin/vxedit  -g orcp-raw01  set mode="0660" redo-$i-52m

done