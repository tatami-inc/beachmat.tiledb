## Much of this stuff was copied from https://github.com/TileDB-Inc/TileDB-R/blob/master/configure.ac.

## require at least autoconf 2.69
AC_PREREQ([2.69])
AC_INIT([TileDB-R],[0.28.0])

## this has to come early to affect other queries involving R
: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
    echo "could not determine R_HOME"
    exit 1
fi

## allow linking to the pre-built libconnections.so 
installed=`"${R_HOME}/bin/Rscript" -e "cat(system.file(package='tiledb'))"`

## check if the tiledb-R package already downloaded TileDB.
vendored=`"${R_HOME}/bin/Rscript" -e "cat(system.file('tiledb', package='tiledb'))"`
AC_MSG_CHECKING([if tiledb-R downloaded its own TileDB])
if test x"${vendored}" != x""; then
    AC_MSG_RESULT([yes])
    AC_SUBST([TILEDB_INCLUDE], "-I${installed}/include -I${vendored}/include")
    AC_SUBST([TILEDB_LIBS], "-ltiledb -L${installed}/lib -L${vendored}/lib")
else
    AC_MSG_RESULT([no])

    ## otherwise we dig around for a system tiledb installation.
    ## we skip many of the checks done in the tiledb-R package itself,
    ## under the assumption that the system libraries must have been
    ## good enough if tiledb-R didn't decide to install its own copy.
    AC_PATH_PROG(have_pkg_config, pkg-config, no)
    if test x"${have_pkg_config}" != x"no"; then
        AC_MSG_CHECKING([if pkg-config knows TileDB])
        if pkg-config --exists tiledb; then
            AC_MSG_RESULT([yes])
            tiledb_include=$(pkg-config --cflags tiledb)
            tiledb_libs=$(pkg-config --libs tiledb)
            AC_SUBST([TILEDB_INCLUDE], "${tiledb_include}")
            AC_SUBST([TILEDB_LIBS],    "${tiledb_libs}")
        else
            AC_MSG_RESULT([no])
            have_pkg_config="no"
        fi
    fi

    if test x"${have_pkg_config}" = x"no"; then
        ## Default values suitable for system install, overridde as needed below
        AC_SUBST([TILEDB_INCLUDE], "")
        AC_SUBST([TILEDB_LIBS], "-ltiledb")
    fi
fi

AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT
