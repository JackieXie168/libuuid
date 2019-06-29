#!/bin/bash
#
if [ ! -d installer ]; then
	mkdir installer
fi
ZipFile="installer/libuuid-1.0.3-win64-`date +%Y%m%d`-src.zip"
rm -f ${ZipFile}
zip -q9 ${ZipFile} ./README.md ./LICENSE.txt *.bash *.bat
zip -q9 ${ZipFile} ./libuuid/*.cpp
zip -q9 ${ZipFile} ./libuuid/*.c
zip -q9 ${ZipFile} ./libuuid/*.h ./libuuid/uuid/*.h
zip -q9 ${ZipFile} `find . -name .gitignore -o -name .gitattributes`
echo "Packaged ${ZipFile}"
ls -l ${ZipFile}
