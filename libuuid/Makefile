# This makefile is compatible with MS nmake and can be used as a
# replacement for buildlib.bat.
# 
# The variables $DLLDEST and $LIBDEST hold the destination directories for the
# dll and the lib, respectively. Probably all that needs to change is $DEVROOT.

# DLL_VER:
# See uuid/uuid.h and README - This number is computed as 'current - age'
DLL_VER	= 1
DLL_VERD= $(DLL_VER)d

DEVROOT	= C:\Progra~1\msscf

DLLDEST	= $(DEVROOT)\dll
LIBDEST	= $(DEVROOT)\lib
HDRDEST	= $(DEVROOT)\include\uuid

DLLS	= libuuidVCE$(DLL_VER).dll libuuidVSE$(DLL_VER).dll libuuidVC$(DLL_VER).dll \
		  libuuidVCE$(DLL_VERD).dll libuuidVSE$(DLL_VERD).dll libuuidVC$(DLL_VERD).dll
INLINED_STAMPS	= libuuidVCE$(DLL_VER).stamp libuuidVSE$(DLL_VER).stamp libuuidVC$(DLL_VER).stamp \
				  libuuidVCE$(DLL_VERD).stamp libuuidVSE$(DLL_VERD).stamp libuuidVC$(DLL_VERD).stamp
STATIC_STAMPS	= libuuidVCE$(DLL_VER).static libuuidVSE$(DLL_VER).static libuuidVC$(DLL_VER).static \
				  libuuidVCE$(DLL_VERD).static libuuidVSE$(DLL_VERD).static libuuidVC$(DLL_VERD).static

CC	= cl
CPPFLAGS = /I. /DLIBUUID_EXPORTS /D_CRT_SECURE_NO_WARNINGS
XCFLAGS = /W3 /MDd /nologo
CFLAGS	= /O2 /Ob2 $(XCFLAGS)
CFLAGSD	= /Z7 $(XCFLAGS)

# Uncomment this if config.h defines RETAIN_WSALASTERROR
#XLIBS = bcrypt.lib wsock32.lib
XLIBS = bcrypt.lib /nodefaultlib:libcmt

# Default cleanup style
CLEANUP	= __CLEANUP_C

# C++ Exceptions
VCEFLAGS	= /EHsc /TP $(CPPFLAGS) $(CFLAGS)
VCEFLAGSD	= /EHsc /TP $(CPPFLAGS) $(CFLAGSD)
#Structured Exceptions
VSEFLAGS	= $(CPPFLAGS) $(CFLAGS)
VSEFLAGSD	= $(CPPFLAGS) $(CFLAGSD)
#C cleanup code
VCFLAGS		= $(CPPFLAGS) $(CFLAGS)
VCFLAGSD	= $(CPPFLAGS) $(CFLAGSD)

DLL_INLINED_OBJS = \
		libuuid.obj

# Aggregate modules for inlinability
DLL_OBJS	= \
		clear.obj \
		compare.obj \
		copy.obj \
		dllmain.obj \
		gen_uuid.obj \
		isnull.obj \
		libuuid.obj \
		pack.obj \
		parse.obj \
		randutils.obj \
		stdafx.cpp \
		unpack.obj \
		unparse.obj \
		uuid_time.obj

INCL	= all-io.h c.h config.h randutils.h stdafx.h targetver.h uuidd.h uuidP.h uuid/uuid.h

LIBUUID_SRCS	= \
		clear.c \
		compare.c \
		copy.c \
		dllmain.cpp \
		gen_uuid.c \
		isnull.c \
		libuuid.cpp \
		pack.c \
		parse.c \
		randutils.c \
		stdafx.cpp \
		unpack.c \
		unparse.c \
		uuid_time.c

help:
	@ echo Run one of the following command lines:
	@ echo nmake clean VCE   (to build the MSVC dll with C++ exception handling)
	@ echo nmake clean VSE   (to build the MSVC dll with structured exception handling)
	@ echo nmake clean VC    (to build the MSVC dll with C cleanup code)
	@ echo nmake clean VC-static     (to build the MSVC static lib with C cleanup code)
	@ echo nmake clean VCE-debug   (to build the debug MSVC dll with C++ exception handling)
	@ echo nmake clean VSE-debug   (to build the debug MSVC dll with structured exception handling)
	@ echo nmake clean VC-debug    (to build the debug MSVC dll with C cleanup code)
	@ echo nmake clean VC-static-debug     (to build the debug MSVC static lib with C cleanup code)

all:

VCE:
	@ $(MAKE) /E /nologo EHFLAGS="$(VCEFLAGS)" CLEANUP=__CLEANUP_CXX libuuidVCE$(DLL_VER).dll

VCE-debug:
	@ $(MAKE) /E /nologo EHFLAGS="$(VCEFLAGSD)" CLEANUP=__CLEANUP_CXX libuuidVCE$(DLL_VERD).dll

VSE:
	@ $(MAKE) /E /nologo EHFLAGS="$(VSEFLAGS)" CLEANUP=__CLEANUP_SEH libuuidVSE$(DLL_VER).dll

VSE-debug:
	@ $(MAKE) /E /nologo EHFLAGS="$(VSEFLAGSD)" CLEANUP=__CLEANUP_SEH libuuidVSE$(DLL_VERD).dll

VC:
	@ $(MAKE) /E /nologo EHFLAGS="$(VCFLAGS)" CLEANUP=__CLEANUP_C libuuidVC$(DLL_VER).dll

VC-debug:
	@ $(MAKE) /E /nologo EHFLAGS="$(VCFLAGSD)" CLEANUP=__CLEANUP_C libuuidVC$(DLL_VERD).dll

#
VC-static:
	@ $(MAKE) /E /nologo EHFLAGS="$(VCFLAGS) /DLIBUUID_BUILD_INLINED /DLIBUUID_STATIC_LIB" CLEANUP=__CLEANUP_C libuuidVC$(DLL_VER).static

VC-static-debug:
	@ $(MAKE) /E /nologo EHFLAGS="$(VCFLAGSD) /DLIBUUID_BUILD_INLINED /DLIBUUID_STATIC_LIB" CLEANUP=__CLEANUP_C libuuidVC$(DLL_VERD).static

realclean: clean
	if exist libuuid*.dll del libuuid*.dll
	if exist libuuid*.lib del libuuid*.lib
	if exist *.manifest del *.manifest
	if exist *.stamp del *.stamp

clean:
	if exist *.obj del *.obj
	if exist *.def del *.def
	if exist *.ilk del *.ilk
	if exist *.pdb del *.pdb
	if exist *.exp del *.exp
	if exist *.map del *.map
	if exist *.o del *.o
	if exist *.i del *.i
	if exist *.res del *.res


install:
	copy libuuid*.dll $(DLLDEST)
	copy libuuid*.lib $(LIBDEST)
	if not exist $(HDRDEST) mkdir $(HDRDEST)
	copy uuid\uuid.h $(HDRDEST)

$(DLLS): $(DLL_OBJS)
	$(CC) /LD /Zi /nologo $(DLL_OBJS) /link /implib:$*.lib $(XLIBS) /out:$@

$(INLINED_STAMPS): $(DLL_INLINED_OBJS)
	$(CC) /LD /Zi /nologo $(DLL_INLINED_OBJS) /link /implib:$*.lib $(XLIBS) /out:$*.dll

$(STATIC_STAMPS): $(DLL_INLINED_OBJS)
	if exist $*.lib del $*.lib
	lib $(DLL_INLINED_OBJS) /out:$*.lib

.c.obj:
	$(CC) $(EHFLAGS) /D$(CLEANUP) -c $<

# TARGET_CPU is an environment variable set by Visual Studio Command Prompt
# as provided by the SDK
.rc.res:
	rc /dLIBUUID_ARCH$(TARGET_CPU) /dLIBUUID_RC_MSC /d$(CLEANUP) $<

.c.i:
	$(CC) /P /O2 /Ob1 $(VCFLAGS) $<

clear.obj: clear.c $(LIBUUID_SRCS) $(INCL)
compare.obj: compare.c $(LIBUUID_SRCS) $(INCL)
copy.obj: copy.c $(LIBUUID_SRCS) $(INCL)
dllmain.obj: dllmain.cpp $(LIBUUID_SRCS) $(INCL)
gen_uuid.obj: gen_uuid.c $(LIBUUID_SRCS) $(INCL)
isnull.obj: isnull.c $(LIBUUID_SRCS) $(INCL)
libuuid.obj: libuuid.cpp $(LIBUUID_SRCS) $(INCL)
pack.obj: pack.c $(LIBUUID_SRCS) $(INCL)
parse.obj: parse.c $(LIBUUID_SRCS) $(INCL)
randutils.obj: randutils.c $(LIBUUID_SRCS) $(INCL)
stdafx.obj: stdafx.cpp $(LIBUUID_SRCS) $(INCL)
unpack.obj: unpack.c $(LIBUUID_SRCS) $(INCL)
unparse.obj: unparse.c $(LIBUUID_SRCS) $(INCL)
uuid_time.obj: uuid_time.c $(LIBUUID_SRCS) $(INCL)

