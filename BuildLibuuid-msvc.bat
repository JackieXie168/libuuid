@echo off
echo "##################################"
echo "#"
echo "#	libuuid-win64 amd64"
echo "#"
cd libuuid
	nmake clean VCE-debug install
cd ..
