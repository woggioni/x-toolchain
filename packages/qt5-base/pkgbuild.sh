# $Id$
# Maintainer: Jan de Groot <jgc@archlinux.org>
# Contributor: dorphell <dorphell@archlinux.org>
# Contributor: Travis Willard <travis@archlinux.org>
# Contributor: Douglas Soares de Andrade <douglas@archlinux.org>

pkgver=5.10.0
_basename="${pkgname#${_target}-}"
pkgrel=1
pkgdesc="A collection of routines used to create PNG format graphics files"
arch=('x86_64')
url="http://www.libpng.org/pub/png/libpng.html"
license=('custom')
depends=("${_target}-gcc" 
         "${_target}-libjpeg-turbo" 
         "${_target}-libpng" 
         "${_target}-libxcb"
         "${_target}-libxext"
         "${_target}-libx11"
         "${_target}-xcb-util-keysyms"
         "${_target}-xcb-util-renderutil"
         "${_target}-xcb-util-wm"
         "${_target}-xcb-util-image"
         "${_target}-pcre2"
         "${_target}-sqlite"
         "${_target}-icu"
         #"${_target}-libiconv"
         "${_target}-freetype2"
         "${_target}-harfbuzz"
         "${_target}-zlib"
         'sh' 'ccache')
options=('staticlibs' '!strip' '!buildflags')
_pkgfqn="qtbase-everywhere-src-${pkgver}"
source=("https://download.qt.io/official_releases/qt/${pkgver%.*}/${pkgver}/submodules/${_pkgfqn}.tar.xz"
        "qmake.conf"
        "qplatformdefs.h"
        '0001-Add-profile-for-cross-compilation-with-mingw-w64.patch'
        '0002-Ensure-GLdouble-is-defined-when-using-dynamic-OpenGL.patch'
        '0003-Use-external-ANGLE-library.patch'
        '0004-Fix-too-many-sections-assemler-error-in-OpenGL-facto.patch'
        '0005-Make-sure-.pc-files-are-installed-correctly.patch'
        '0006-Don-t-add-resource-files-to-LIBS-parameter.patch'
        '0007-Prevent-debug-library-names-in-pkg-config-files.patch'
        '0008-Fix-linking-against-shared-static-libpng.patch'
        '0009-Fix-linking-against-static-D-Bus.patch'
        '0010-Don-t-try-to-use-debug-version-of-D-Bus-library.patch'
        '0011-Fix-linking-against-static-freetype2.patch'
        '0012-Fix-linking-against-static-harfbuzz.patch'
        '0013-Fix-linking-against-static-pcre.patch'
        '0014-Fix-linking-against-shared-static-MariaDB.patch'
        '0015-Fix-linking-against-shared-static-PostgreSQL.patch'
        '0016-Rename-qtmain-to-qt5main.patch'
        '0017-Build-dynamic-host-libraries.patch'
        '0018-Enable-rpath-for-build-tools.patch'
        '0019-Use-system-zlib-for-build-tools.patch'
        '0020-Disable-determing-default-include-and-lib-dirs-at-qm.patch'
        '0021-Use-.dll.a-as-import-lib-extension.patch'
        '0022-Merge-shared-and-static-library-trees.patch'
        '0023-Pull-dependencies-of-static-libraries-in-CMake-modul.patch'
        '0024-Allow-usage-of-static-version-with-CMake.patch'
        '0025-Adjust-linker-flags-for-static-build-with-cmake-ming.patch'
        '0026-Use-correct-pkg-config-static-flag.patch'
        '0027-Fix-macro-invoking-moc-rcc-and-uic.patch'
        '0028-Ignore-errors-about-missing-feature-static.patch'
        '0029-Enable-and-fix-use-of-iconv.patch'
        '0030-Ignore-failing-pkg-config-test.patch'
        '0031-Prevent-qmake-from-messing-static-lib-dependencies.patch'
        '0032-Hardcode-linker-flags-for-platform-plugins.patch'
        '0033-Fix-linking-against-static-plugins-with-qmake.patch'
        '0034-Don-t-use-the-statx-syscall.patch'
)
sha256sums=('SKIP' "SKIP" "SKIP"
            'd10d56c65b632d881f79eda8c0caeffb1a53a4829ac886e80038cdc8929b1669'
            '524883f46945ab2ce023e9de1144a7eebafdba936ea8c61e035006deff48fa5b'
            'cea0e73f831348e50285ab87149803d4dfb5650c4c96037844b98b3dc1c65159'
            'e333d61821a42710a00f9bd4d003d376f513ba6ca41a3739bfcd414c99b8e7dd'
            'e8b0bdcc39458105dd0e5c569c98ef53a84d2fe4e9e200e1b1c1b7b749e8e758'
            'e14860d560886b600373f639e89e9a60d77de9a536587633ea71e1fd907df3fb'
            '447c27f0e87d5cdcbe9883f6d3aac0daefef28e09bd8afe8d07a650375ca8362'
            'e2f98037b93aa2970014c1d185912b49d4ab5506c24fa2410cb0e93d4e0a1f54'
            '507537c73995715fa1a4e9e0f1ecfdf4afe409b5397366f551d06c6c406e088b'
            '760093a185cd77bacec0d85c0c077370d6044b89a4d6f03944524d1aa2b82dfa'
            '7d9bb15b631ff1599dc0fdcdfa92be1aa7e0bc155399656e8d1ae5dc4391b91e' #'6052446a675be39dd663ef69ee5339ab67c2805b29ff4ef19bacf0f677a95182'
            '60a6e236334d3950b40dbb0501cc733bc7a672b0c7fbf6e4792c0058bf20a859'
            'f58391f9407742a1543702fe0234a134883046ff99584c1cfa468893264bf5e9'
            '9e406b466c2b447da5d44ea37cafe2b3c3caebfa54936eb71e816e60b186c47d'
            '870ed7adb78d4f5b396fa9106777aaeefc2a8af406e1aa1655dfe3405974a1ce'
            'b51a2d707a09cce340ca10e4a93c18a0872881889a97dc3ea2aafe73d80dfd46'
            'ed206eef70d57cd1aeb31c9e65ceb46fe926bee462c9b6507d22b6daf9b03aff'
            '00ea2ef2f2d8868351d857716e60e8e78ed90a294132cd1fbd8039aae50e7344'
            'f80e166e5a358cc3d0dca5f0a543b30271a1c536ff9ef73105f1e432b10d3afe'
            '12c4ce015c5641376dea7a232f0fc9f8feb10ddee06c65f87e0f00ea2574ab15'
            'a3a6a12f94ed4a79b3910623e3a8a11859d7a6a72b4634ff8bd6d1269af615bd'
            '6f1f96ec05f049a107f4b5b3fba05e088d47f1c4751fd21851ed48d5f1b5a274'
            '2926f77fbab219cb2fe9bb630274b06594a72c9047d374209d96591e481015fd'
            'b36b7fce8e101444d17026002f8052be41de887ccd263188a64faeae31cc1c89'
            '7bcfe130f6dc47c9fb4d3db6fe9634596ab2c01e421bfc9a0967463487b4b7f0'
            '83f6a3fc2489da2686f035563542478fd01e2849e18ea02478d7850bd68f16be'
            '7254445b4cea5e1d7efc25b923e755ab3b19856ee8bce2ebe2900b9bf4717841'
            'd03a3cc5dab9d9a843e73f241fee2778deffe9ee727e493a0052e62b2266923e'
            'd6dc468d67e782b64fbe9ba64dfc3fdf423c5d06205f4a87a0561bb53b35d7fc'
            '43c367e31c1560178a1471a80a9e90391c7c93f8dfece8c4c9dfafea4a3ce180'
            '2e89aca862a62cbf535faf4b01c00dfed40ad6ccb52ac998913e9e96801491a3'
            '8b1402c8ac78c0870af19ccdd8b2603e164cf2ef4fd4446fd03ea40b68a35643'
            '81d279b24a508656597fec9bf94bade25cf0d600607febcd35f7fd27d09970eb'
            '95a8cd9553ef18e200a85ff6dc5c718525d71be92d4fa49b8cdceae73696e037'
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
    '0005-Make-sure-.pc-files-are-installed-correctly.patch'
    # '0006-Don-t-add-resource-files-to-LIBS-parameter.patch'
    #'0007-Prevent-debug-library-names-in-pkg-config-files.patch'
    # '0008-Fix-linking-against-shared-static-libpng.patch'
    # '0009-Fix-linking-against-static-D-Bus.patch'
    # '0010-Don-t-try-to-use-debug-version-of-D-Bus-library.patch'
    '0011-Fix-linking-against-static-freetype2.patch'
    # '0012-Fix-linking-against-static-harfbuzz.patch'
    # '0013-Fix-linking-against-static-pcre.patch'
    # '0014-Fix-linking-against-shared-static-MariaDB.patch'
    # '0015-Fix-linking-against-shared-static-PostgreSQL.patch'
    # '0016-Rename-qtmain-to-qt5main.patch'
    # '0017-Build-dynamic-host-libraries.patch'
    # '0018-Enable-rpath-for-build-tools.patch'
    '0019-Use-system-zlib-for-build-tools.patch'
    # '0020-Disable-determing-default-include-and-lib-dirs-at-qm.patch'
    # '0021-Use-.dll.a-as-import-lib-extension.patch'
    # '0022-Merge-shared-and-static-library-trees.patch'
    '0023-Pull-dependencies-of-static-libraries-in-CMake-modul.patch'
    # '0024-Allow-usage-of-static-version-with-CMake.patch'
    # '0025-Adjust-linker-flags-for-static-build-with-cmake-ming.patch'
    # '0026-Use-correct-pkg-config-static-flag.patch'
    # '0027-Fix-macro-invoking-moc-rcc-and-uic.patch'
    # '0028-Ignore-errors-about-missing-feature-static.patch'
    '0029-Enable-and-fix-use-of-iconv.patch'
    '0030-Ignore-failing-pkg-config-test.patch'
    # '0031-Prevent-qmake-from-messing-static-lib-dependencies.patch'
    # '0032-Hardcode-linker-flags-for-platform-plugins.patch'
    # '0033-Fix-linking-against-static-plugins-with-qmake.patch'
    # '0034-Don-t-use-the-statx-syscall.patch'
)

prepare() {
  pushd "${srcdir}/${_pkgfqn}"
  for _patch in ${_patches2apply[@]}
  do
    patch -p1 -i "${srcdir}/${_patch}"
  done
  rm -rf src/3rdparty/angle include/QtANGLE/{EGL,GLES2,GLES3,KHR}
  rm -rf src/3rdparty/{pcre,zlib}
  mkdir mkspecs/${_target}
  cp "${srcdir}/qmake.conf" mkspecs/${_target}
  cp "${srcdir}/qplatformdefs.h" mkspecs/${_target}
  popd
}

build() {
  _builddir="${srcdir}/build"
  unset CFLAGS
  unset CXXFLAGS
  unset LDFLAGS
  unset PKG_CONFIG_PATH
  mkdir -p "${_builddir}"
  pushd "${_builddir}"
  _additional_includes="-I${_prefix}/${_target}/sysroot/usr/include/freetype2 -I${_prefix}/${_target}/sysroot/usr/include/harfbuxx"
  # export PKG_CONFIG_SYSROOT_DIR="/"
  export PKG_CONFIG_LIBDIR="${_prefix}/${_target}/sysroot/lib/pkgconfig"
  "${srcdir}/${_pkgfqn}/configure" \
      -opensource \
      -${_build_type} \
      -ccache \
      -no-opengl \
      -nomake examples \
      -no-glib \
      -no-dbus \
      -icu \
      -no-iconv \
      -no-fontconfig \
      -release \
      -confirm-license \
      -force-pkg-config \
      -system-zlib \
      -system-libpng \
      -system-libjpeg \
      -system-sqlite \
      -openssl-runtime \
      -system-freetype \
      -system-harfbuzz \
      -system-pcre \
      -xcb-xlib -system-xcb -qt-xkbcommon \
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
      -device-option CROSS_COMPILE_CFLAGS=-fpch-preprocess ${_additional_includes}
  make
  popd
}

package() {
  _builddir="${srcdir}/build"
  pushd "${_builddir}"
  make install INSTALL_ROOT="${pkgdir}"
  # rm -r "${pkgdir}/${_prefix}/${_target}/share"
  # strip -s "${pkgdir}/${_prefix}/${_target}/bin"/*
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
