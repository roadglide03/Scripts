#!/bin/sh
#
echo "Caution: This is recursive"
echo "Enter Filename/Directory to remove imutable flag: \c "
	read file
	chflags -Rv noschg $file

