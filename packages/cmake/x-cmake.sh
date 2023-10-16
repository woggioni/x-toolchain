#!/bin/sh
gcc_prefix=@PREFIX@/@TRIPLE@/sysroot

export PKG_CONFIG_LIBDIR="${gcc_prefix}/usr/lib/pkgconfig"

PATH=${gcc_prefix}/bin:$PATH exec cmake \
    -DPKG_CONFIG_EXECUTABLE=@PREFIX@/bin/@TRIPLE@-pkg-config \
    -DCMAKE_INSTALL_PREFIX:PATH=${gcc_prefix}/usr \
    -DCMAKE_INSTALL_BINDIR:PATH=bin \
    -DCMAKE_INSTALL_LIBDIR:PATH=lib \
    -DCMAKE_INSTALL_INCLUDEDIR:PATH=include \
    -DCMAKE_INSTALL_DATAROOTDIR:PATH=share \
    -DCMAKE_INSTALL_DATADIR:PATH=share \
    -DCMAKE_INSTALL_INFODIR:PATH=share/info \
    -DCMAKE_INSTALL_DOCDIR:PATH=share/doc \
    -DINCLUDE_INSTALL_DIR:PATH=${gcc_prefix}/usr/include \
    -DLIB_INSTALL_DIR:PATH=${gcc_prefix}/usr/lib \
    -DSYSCONF_INSTALL_DIR:PATH=${gcc_prefix}/etc \
    -DSHARE_INSTALL_DIR:PATH=${gcc_prefix}/usr/share \
    -DCMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES:PATH=@PREFIX@/lib/gcc/@TRIPLE@/13.2.0/include:@PREFIX@/lib/gcc/@TRIPLE@/13.2.0/include-fixed:@PREFIX@/@TRIPLE@/include \
    -DCMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES:PATH=@PREFIX@/lib/gcc/@TRIPLE@/13.2.0/include:@PREFIX@/lib/gcc/@TRIPLE@/13.2.0/include-fixed:@PREFIX@/@TRIPLE@/include \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DCMAKE_TOOLCHAIN_FILE=@PREFIX@/cmake/toolchain-@TRIPLE@.cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_FLAGS_RELEASE="$CFLAGS" \
    -DCMAKE_CXX_FLAGS_RELEASE="$CXXFLAGS" \
    "$@"
