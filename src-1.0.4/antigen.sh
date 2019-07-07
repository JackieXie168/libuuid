#!/bin/sh
#
# A utility script to remove all generated files.
#
# Running autogen.sh will be required after running this script since
# the 'configure' script will also be removed.
#
# This script is mainly useful when testing autoconf/automake changes
# and as a part of their development process.
# If there's a Makefile, then run the 'distclean' target first (which
# will also remove the Makefile).
if test -f Makefile; then
  make distclean
fi
# Remove all tar-files (assuming there are some packages).
rm -f *.tar.* *.tgz
# Also remove the autotools cache directory.
rm -rf autom4te.cache .deps
# Remove rest of the generated files.
rm -f Makefile.in aclocal.m4 compile configure config.status depcomp install-sh missing ltmain.sh libtool .built .configured configure.scan .prepared .version* *~ autoscan.log
rm -fr config.guess config.sub
find . -name Makefile.in -exec rm -f {} \;
find . -name \*~ -exec rm -f {} \;
cd m4; rm -f libtool.m4 ltoptions.m4 ltsugar.m4 ltversion.m4 lt~obsolete.m4; cd -
