#!/bin/sh
gcc_prefix=@PREFIX@/@TRIPLE@/sysroot

export PKG_CONFIG_LIBDIR="${gcc_prefix}/lib/pkgconfig"

PATH=${gcc_prefix}/bin:$PATH cmake \
    -DPKG_CONFIG_EXECUTABLE=@PREFIX@/bin/@TRIPLE@-pkg-config \
    -DCMAKE_INSTALL_PREFIX:PATH=${gcc_prefix} \
    -DCMAKE_INSTALL_BINDIR:PATH=${gcc_prefix}/usr/bin \
    -DCMAKE_INSTALL_LIBDIR:PATH=${gcc_prefix}/usr/lib \
    -DCMAKE_INSTALL_INCLUDEDIR:PATH=${gcc_prefix}/usr/include \
    -DCMAKE_INSTALL_DATAROOTDIR:PATH=${gcc_prefix}/usr/share \
    -DINCLUDE_INSTALL_DIR:PATH=${gcc_prefix}/usr/include \
    -DLIB_INSTALL_DIR:PATH=${gcc_prefix}/usr/lib \
    -DSYSCONF_INSTALL_DIR:PATH=${gcc_prefix}/etc \
    -DSHARE_INSTALL_DIR:PATH=${gcc_prefix}/usr/share \
    -DCMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES:PATH=@PREFIX@/lib/gcc/@TRIPLE@/10.2.0/include:@PREFIX@/lib/gcc/@TRIPLE@/10.2.0/include-fixed:@PREFIX@/@TRIPLE@/include \
    -DCMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES:PATH=@PREFIX@/lib/gcc/@TRIPLE@/10.2.0/include:@PREFIX@/lib/gcc/@TRIPLE@/10.2.0/include-fixed:@PREFIX@/@TRIPLE@/include \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DCMAKE_TOOLCHAIN_FILE=@PREFIX@/cmake/toolchain-@TRIPLE@.cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_FLAGS_RELEASE="$CFLAGS" \
    -DCMAKE_CXX_FLAGS_RELEASE="$CXXFLAGS" \
    "$@"
