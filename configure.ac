# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([libuuid], [1.0.4], [sloowfranklin@gmail.com])
AC_CONFIG_SRCDIR([compare.c])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])
LT_INIT
AM_INIT_AUTOMAKE([foreign])


AC_ARG_VAR([SOLIB_CFLAGS],
	   [CFLAGS used for shared libraries])
AC_ARG_VAR([SOLIB_LDFLAGS],
	   [LDFLAGS used for shared libraries])

dnl
dnl libuuid is enabled at all times if possible
dnl
dnl UL_REQUIRES_BUILD([libuuid])

dnl
dnl libuuid
dnl
AC_ARG_ENABLE([libuuid],
  AS_HELP_STRING([--disable-libuuid], [do not build libuuid and uuid utilities]),
  [], [UL_DEFAULT_ENABLE([libuuid], [yes])]
)
UL_BUILD_INIT([libuuid])
AC_SUBST([LIBUUID_VERSION])
AC_SUBST([LIBUUID_VERSION_INFO])
AM_CONDITIONAL(BUILD_LIBUUID, test "x$build_libuuid" = xyes)

AS_IF([test "x$build_libuuid" = xyes], [
  AC_DEFINE(HAVE_LIBUUID, 1, [Define to 1 if you have the -luuid.])
])

UL_BUILD_INIT([uuidgen], [check])
UL_REQUIRES_BUILD([uuidgen], [libuuid])
AM_CONDITIONAL([BUILD_UUIDGEN], [test "x$build_uuidgen" = xyes])

XORG_CHECK_LINKER_FLAGS([-Wl,--version-script="$srcdir/uuid.sym"], [have_version_script=yes])
AM_CONDITIONAL([HAVE_VERSION_SCRIPT], [test "x$have_version_script" = xyes])

# Checks for programs.
AC_C_INLINE
AC_PROG_CC
AC_PROG_AWK
AC_PROG_CXX
AC_PROG_INSTALL
AM_PROG_LIBTOOL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_RANLIB
AC_TYPE_INT64_T

# Checks for libraries.
SOCKET_LIBS=
AC_SEARCH_LIBS([socket], [socket],
    [if test x"$ac_cv_search_socket" != x"none required"; then
        SOCKET_LIBS="$SOCKET_LIBS -lsocket";
    fi])
AC_SUBST([SOCKET_LIBS])

# Checks for header files.
AC_CHECK_HEADERS([fcntl.h getopt.h inttypes.h langinfo.h libintl.h limits.h locale.h netinet/in.h stddef.h stdio_ext.h stdlib.h string.h sys/file.h sys/ioctl.h sys/socket.h sys/time.h unistd.h])
AC_CHECK_DECLS([_SC_HOST_NAME_MAX])

# Checks for typedefs, structures, and compiler characteristics.
AC_TYPE_INT32_T
AC_TYPE_MODE_T
AC_TYPE_SIZE_T
AC_TYPE_SSIZE_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT64_T
AC_TYPE_UINT8_T

# Checks for library functions.
AC_CHECK_FUNCS([__fpending atexit fsync ftruncate gettimeofday memset setlocale socket strrchr strtoul usleep srandom])

dnl version details from <major>.<minor>.<release>
PACKAGE_VERSION_MAJOR=$(echo $PACKAGE_VERSION | awk -F. '{print $1}')
PACKAGE_VERSION_MINOR=$(echo $PACKAGE_VERSION | awk -F. '{print $2}')
PACKAGE_VERSION_RELEASE=$(echo $PACKAGE_VERSION | awk -F. '{print $3}')

LIBUUID_VERSION="$PACKAGE_VERSION_MAJOR.$PACKAGE_VERSION_MINOR.$PACKAGE_VERSION_RELEASE"
LIBUUID_LT_MAJOR=1
LIBUUID_LT_MINOR=0
LIBUUID_LT_MICRO=4
LIBUUID_VERSION_INFO=`expr $LIBUUID_LT_MAJOR + $LIBUUID_LT_MINOR`:$LIBUUID_LT_MICRO:$LIBUUID_LT_MINOR
AC_SUBST([LIBUUID_VERSION])
AC_SUBST([LIBUUID_VERSION_INFO])

AC_CONFIG_FILES(
  [Makefile]
  [uuid.pc]
)
AC_OUTPUT
