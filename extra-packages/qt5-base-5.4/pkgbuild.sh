# $Id$
# Maintainer: Jan de Groot <jgc@archlinux.org>
# Contributor: dorphell <dorphell@archlinux.org>
# Contributor: Travis Willard <travis@archlinux.org>
# Contributor: Douglas Soares de Andrade <douglas@archlinux.org>

pkgver=5.4.2
_basename="${pkgname#${_target}-}"
pkgrel=1
pkgdesc="A collection of routines used to create PNG format graphics files"
arch=('x86_64')
url="http://www.libpng.org/pub/png/libpng.html"
license=('custom')
depends=("${_target}-gcc" 
         "${_target}-libjpeg-turbo" 
         "${_target}-libpng" 
         "${_target}-pcre2"
         "${_target}-sqlite"
         "${_target}-icu"
         "${_target}-freetype2"
         "${_target}-harfbuzz"
         "${_target}-zlib"
         'sh')
options=('staticlibs' '!strip' '!buildflags')
_pkgfqn="qtbase-opensource-src-${pkgver}"
source=("https://download.qt.io/archive/qt/${pkgver%.*}/${pkgver}/submodules/${_pkgfqn}.tar.xz"
        "qmake.conf"
        "qplatformdefs.h"
        "build.sh"
        "qt5-merge-static-and-shared-library-trees.patch"
        "qt5-add-angle-support.patch"
        "angle-fix.patch"
        "qt5-use-external-angle-library.patch"
        "qt5-workaround-pkgconfig-install-issue.patch"
        "qt5-qtbase-fix-linking-against-static-pcre.patch"
        "qt5-rename-qtmain-to-qt5main.patch"
        "qt5-dont-build-host-libs-static.patch"
        "qt5-enable-rpath-for-host-tools.patch"
        "qt5-add-compiled-shaders-remove-dxsdk.patch"
        "qt5-dont-add-resource-files-to-qmake-libs.patch"
        "qt5-prevent-debug-library-names-in-pkgconfig-files.patch"
        "qt5-qmake-implib-dll-a.patch"
        "qt5-fix-static-dbus-detection.patch"
        "qt5-fix-static-harfbuzz-detection.patch"
        "qt5-use-win32-g++-mkspecs-profile.patch"
        "qt5-use-system-zlib-in-host-libs.patch"
        "qt-5.1.x-win_flex-replace.patch"
        "fix-opengl-to-many-sections.patch"
        "fix-static-psql-mysql.patch"
)
md5sums=('SKIP' "SKIP" "SKIP" "SKIP"
        'f51eb2b176b10af943831d33925c1251'
        '8c6bda3ce8aca368b1f50f57e5f25aa7'
        'af4ac76fb9d1ea383359ea881ffcd8e3'
        '361e456685180a4004de6af76c58ddba'
        '19debeaea610e70691fae3b2a0a94eaa'
        '4fe6523dd1c34398df3aa5a8763530cc'
        'c4d4ca54a2e9096d2af13a266177f6d6'
        '3bd322551924543553a2bf81b4419a09'
        '15e8eaa4f0a9a9990277c79e243770be'
        'bd0ced78eafaf187197d64f9e381c6c5'
        '47b2aa0c6251c24c3c36c86b86a99c4c'
        '6a6bc88f35ac8080869de39bc128ce5b'
        '474de0e31122ecd140ebc19fe3960057'
        '40de3aaf7d713034e06f4eece665b1ba'
        '1a7921cadeb5c3db383dea068519e8d3'
        'f0e068b82ca41ae32c0d72587f070dd8'
        'a265dea62755caf38187114143999224'
        '852519f457e33e0d1e9d2a2df872967d'
        '612a4dfb9f1a3898a1920c28bb999159'
        'd0eb81aef1a21c65813fe4ddabbc4206'
)

patch() {
  local input_found=
  local patch_file=
  for arg in $@; do
    if [[ $input_found ]]; then
      patch_file="$arg"
      break
    fi
    [[ $arg == -i ]] && input_found=1
  done
  msg2 "Applying patch $patch_file"
  /usr/bin/patch $@
}

_patches2apply=(
    # '0001-Add-profile-for-cross-compilation-with-mingw-w64.patch'
    # '0002-Ensure-GLdouble-is-defined-when-using-dynamic-OpenGL.patch'
    # '0003-Use-external-ANGLE-library.patch'
    # '0004-Fix-too-many-sections-assemler-error-in-OpenGL-facto.patch'
    "qt5-workaround-pkgconfig-install-issue.patch"
    "qt5-qtbase-fix-linking-against-static-pcre.patch"
    "qt5-fix-static-dbus-detection.patch"
    "qt5-fix-static-harfbuzz-detection.patch"
    "qt5-use-win32-g++-mkspecs-profile.patch"
    "qt5-use-system-zlib-in-host-libs.patch"
    # '0005-Make-sure-.pc-files-are-installed-correctly.patch'
    # '0006-Don-t-add-resource-files-to-LIBS-parameter.patch'
    # '0007-Prevent-debug-library-names-in-pkg-config-files.patch'
    # '0008-Fix-linking-against-shared-static-libpng.patch'
    # '0009-Fix-linking-against-static-D-Bus.patch'
    # '0010-Don-t-try-to-use-debug-version-of-D-Bus-library.patch'
    # '0011-Fix-linking-against-static-freetype2.patch'
    # '0012-Fix-linking-against-static-harfbuzz.patch'
    # '0013-Fix-linking-against-static-pcre.patch'
    # '0014-Fix-linking-against-shared-static-MariaDB.patch'
    # '0015-Fix-linking-against-shared-static-PostgreSQL.patch'
    # '0016-Rename-qtmain-to-qt5main.patch'
    # '0017-Build-dynamic-host-libraries.patch'
    # '0018-Enable-rpath-for-build-tools.patch'
    # '0019-Use-system-zlib-for-build-tools.patch'
    # '0020-Disable-determing-default-include-and-lib-dirs-at-qm.patch'
    # '0021-Use-.dll.a-as-import-lib-extension.patch'
    # '0022-Merge-shared-and-static-library-trees.patch'
    # '0023-Pull-dependencies-of-static-libraries-in-CMake-modul.patch'
    # '0024-Allow-usage-of-static-version-with-CMake.patch'
    # '0025-Adjust-linker-flags-for-static-build-with-cmake-ming.patch'
    # '0026-Use-correct-pkg-config-static-flag.patch'
    # '0027-Fix-macro-invoking-moc-rcc-and-uic.patch'
    # '0028-Ignore-errors-about-missing-feature-static.patch'
    # '0029-Enable-and-fix-use-of-iconv.patch'
    '0030-Ignore-failing-pkg-config-test.patch'
    # '0031-Prevent-qmake-from-messing-static-lib-dependencies.patch'
    # '0032-Hardcode-linker-flags-for-platform-plugins.patch'
    # '0033-Fix-linking-against-static-plugins-with-qmake.patch'
    # '0034-Don-t-use-the-statx-syscall.patch'
)

prepare() {
  pushd "${srcdir}/${_pkgfqn}"

  # Make sure the .pc files of the Qt5 modules are installed correctly
  patch -p0 -i "${srcdir}/qt5-workaround-pkgconfig-install-issue.patch"
  patch -p1 -i "${srcdir}/qt5-dont-add-resource-files-to-qmake-libs.patch"
  patch -p1 -i "${srcdir}/qt5-prevent-debug-library-names-in-pkgconfig-files.patch"
  patch -p1 -i ../qt5-fix-static-dbus-detection.patch
  # patch -p1 -i ../qt5-fix-static-harfbuzz-detection.patch
  patch -p1 -i "${srcdir}/qt5-qtbase-fix-linking-against-static-pcre.patch"
  # patch -p0 -i "${srcdir}/qt5-dont-build-host-libs-static.patch"
  # patch -p1 -i "${srcdir}/qt5-enable-rpath-for-host-tools.patch"
  patch -p1 -i "${srcdir}/qt5-use-system-zlib-in-host-libs.patch"

  rm -rf src/3rdparty/angle include/QtANGLE/{EGL,GLES2,GLES3,KHR}
  rm -rf src/3rdparty/{zlib, pcre}
  mkdir mkspecs/${_target}
  cp "${srcdir}/qmake.conf" mkspecs/${_target}
  cp "${srcdir}/qplatformdefs.h" mkspecs/${_target}
  popd
  for _link in "${srcdir}/"*
  do
    if [ -L "${_link}" ]
    then
      cp -L ${_link} _tmpfile
      rm ${_link}
      mv _tmpfile ${_link}
    fi
  done
}

build() {
  #docker run -ti --rm -v /opt/x-tools:/opt/x-tools -v ${srcdir}:/mnt/build debian:x-toolchain /bin/bash -c "cd /mnt/build && 
  #PATH=\"${_prefix}/bin:\$PATH\" _prefix=\"${_prefix}\" _build_type=\"${_build_type}\" _target=\"${_target}\" srcdir=\"/mnt/build\" _pkgfqn=\"${_pkgfqn}\" ./build.sh"
  _builddir="${srcdir}/build"
  unset CFLAGS
  unset CXXFLAGS
  unset LDFLAGS
  unset PKG_CONFIG_PATH
  mkdir -p "${_builddir}"
  pushd "${_builddir}"
  _additional_includes="-I${_prefix}/${_target}/sysroot/usr/include/freetype2 -I${_prefix}/${_target}/sysroot/usr/include/harfbuxx"
  export CXXFLAGS="${CXXFLAGS} -fpermissive"
  "${srcdir}/${_pkgfqn}/configure" \
      -opensource \
      -make tools \
      -optimized-qmake \
      -${_build_type} \
      -no-opengl \
      -nomake examples \
      -no-glib \
      -icu \
      -no-glib \
      -no-gtkstyle \
      -no-fontconfig \
      -no-iconv \
      -no-dbus \
      -force-pkg-config \
      -release \
      -confirm-license \
      -system-zlib \
      -system-libpng \
      -system-libjpeg \
      -no-sql-sqlite \
      -no-openssl \
      -system-freetype \
      -system-harfbuzz \
      -continue \
      -qt-pcre \
      -no-xcb -qt-xkbcommon \
      -xplatform ${_target} \
      -hostprefix ${_prefix}/${_target} \
      -hostdatadir ${_prefix}/${_target}/lib/qt \
      -hostbindir ${_prefix}/${_target}/bin \
      -prefix ${_prefix}/${_target}/sysroot \
      -bindir ${_prefix}/${_target}/sysroot/bin \
      -archdatadir ${_prefix}/${_target}/sysroot/lib/qt \
      -datadir ${_prefix}/${_target}/sysroot/share/qt \
      -docdir ${_prefix}/${_target}/sysroot/share/doc/qt \
      -examplesdir ${_prefix}/${_target}/sysroot/share/qt/examples \
      -headerdir ${_prefix}/${_target}/sysroot/usr/include/qt \
      -libdir ${_prefix}/${_target}/sysroot/lib \
      -plugindir ${_prefix}/${_target}/sysroot/lib/qt/plugins \
      -sysconfdir ${_prefix}/${_target}/sysroot/etc \
      -translationdir ${_prefix}/${_target}/sysroot/share/qt/translations \
      -device-option CROSS_COMPILE=${_target}- \
      -device-option CROSS_COMPILE_PREFIX="${_prefix}/${_target}/sysroot" \
      -device-option CROSS_COMPILE_CFLAGS=-fpch-preprocess ${_additional_includes} \
      -device-option CROSS_COMPILE_LDFLAGS="-lexecinfo"

  make
  popd
}

package() {
  _builddir="${srcdir}/build"
  pushd "${_builddir}"
  make install INSTALL_ROOT="${pkgdir}"
  install -d "${pkgdir}/${_prefix}/bin/"
  for tool in "${pkgdir}/${_prefix}/${_target}/bin/"* 
  do
    if  [[ ${tool} != *.pl ]]
    then
      strip -s "${tool}"
    fi
    ln -s "/${tool}" "${pkgdir}/${_prefix}/bin/${_target}-$(basename ${tool})"
  done
  find "$pkgdir/${_prefix}/${_target}/sysroot/lib" -name '*.a' -name '*.so*' -type f -exec ${_arch}-strip -g {} \;
  find "$pkgdir/${_prefix}/${_target}/sysroot/lib" -name '*.prl' -type f -exec \
          sed -i -e "s/-lharfbuzz;/-lharfbuzz;-lfreetype;-lharfbuzz;-liconv;-lbz2;/g" \
                 -e "s/-lharfbuzz /-lharfbuzz -lfreetype -lharfbuzz -liconv -lbz2 /g" {} \;
  popd
}
