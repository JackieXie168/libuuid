#!/bin/bash
#
if [ ! -d installer ]; then
	mkdir installer
fi
if [ -d libuuid-1.0.3-win64 ]; then
	rm -Rf libuuid-1.0.3-win64
fi
mkdir libuuid-1.0.3-win64
mkdir libuuid-1.0.3-win64/bin
mkdir libuuid-1.0.3-win64/lib
mkdir libuuid-1.0.3-win64/include
mkdir libuuid-1.0.3-win64/include/uuid
cp LICENSE.txt libuuid-1.0.3-win64
cp libuuid/*.dll libuuid-1.0.3-win64/bin
cp libuuid/*.lib libuuid-1.0.3-win64/lib
cp libuuid/uuid/uuid.h libuuid-1.0.3-win64/include/uuid
cp libuuid/uuid/uuid.h libuuid-1.0.3-win64/include
export ZipFile="installer/libuuid-1.0.3-win64-`date +%Y%m%d`-installer.zip"
rm -f ${ZipFile}
zip -q9r ${ZipFile} libuuid-1.0.3-win64
echo "Packaged ${ZipFile}"
ls -l ${ZipFile}
rm -Rf libuuid-1.0.3-win64
