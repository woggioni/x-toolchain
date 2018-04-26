#!/bin/sh
gcc_prefix=@PREFIX@/@TRIPLE@/sysroot

export PKG_CONFIG_LIBDIR="${gcc_prefix}/lib/pkgconfig"

PATH=${gcc_prefix}/bin:$PATH cmake \
    -DCMAKE_INSTALL_PREFIX:PATH=${gcc_prefix} \
    -DCMAKE_INSTALL_LIBDIR:PATH=${gcc_prefix}/lib \
    -DINCLUDE_INSTALL_DIR:PATH=${gcc_prefix}/usr/include \
    -DLIB_INSTALL_DIR:PATH=${gcc_prefix}/lib \
    -DSYSCONF_INSTALL_DIR:PATH=${gcc_prefix}/etc \
    -DSHARE_INSTALL_DIR:PATH=${gcc_prefix}/share \
    -DCMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES:PATH=${gcc_prefix}/usr/include \
    -DCMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES:PATH=${gcc_prefix}/usr/include \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DCMAKE_TOOLCHAIN_FILE=@PREFIX@/cmake/toolchain-@TRIPLE@.cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_FLAGS_RELEASE="$CFLAGS" \
    -DCMAKE_CXX_FLAGS_RELEASE="$CXXFLAGS" \
    "$@"
