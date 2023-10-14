# $Id$
# Maintainer: Jan de Groot <jgc@archlinux.org>
pkgbase="harfbuzz"
pkgname="${_target}-${pkgbase}"
_basename=${pkgbase#${_target}-}
pkgver=8.2.1
pkgrel=1
pkgdesc="OpenType text shaping engine"
url="http://www.freedesktop.org/wiki/Software/HarfBuzz"
arch=(x86_64)
license=(MIT)
options=('staticlibs' '!buildflags')
makedepends=(git python "${_target}-configure")
_commit=0967a3e24ab5d79cc55dbe224652d8aabd942def  # tags/8.2.1^0
source=("git+https://github.com/harfbuzz/harfbuzz#commit=$_commit")
b2sums=('SKIP')

pkgver() {
  cd $_basename
  git describe --tags | sed 's/[^-]*-g/r&/;s/-/+/g'
}

prepare() {
  cd $_basename
}

build() {
  cd harfbuzz
  mkdir -p build-shared && pushd build-shared
  ${_target}-meson \
    --default-library shared \
    -D b_lto=false \
    -D graphite=enabled \
    -D tests=disabled \
    -D docs=disabled \
    ..
  # fix linker selection error
  #sed -i 's|: c_LINKER|: cpp_LINKER|g' build.ninja
  meson compile
  popd
  mkdir -p build-static && pushd build-static
  ${_target}-meson \
    --default-library static \
    -D c_args=-DGRAPHITE2_STATIC \
    -D cpp_args=-DGRAPHITE2_STATIC \
    -D b_lto=false \
    -D graphite=enabled \
    -D tests=disabled \
    -D docs=disabled \
    ..
  # fix linker selection error
  #sed -i 's|: c_LINKER|: cpp_LINKER|g' build.ninja
  meson compile
  popd
}

package() {
  cd $_basename
  pushd build-static
  DESTDIR="$pkgdir" meson install
  popd
  pushd build-shared
  DESTDIR="$pkgdir" meson install
  popd
}

strip() {
    ${_target}-strip $@
}
export -f strip