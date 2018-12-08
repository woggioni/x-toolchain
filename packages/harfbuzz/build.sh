# $Id$
# Maintainer: Jan de Groot <jgc@archlinux.org>
pkgbase="${_target}-harfbuzz"
_basename=${pkgbase#${_target}-}

pkgver=2.2.0
pkgrel=1
pkgdesc="OpenType text shaping engine"
url="http://www.freedesktop.org/wiki/Software/HarfBuzz"
arch=(x86_64)
license=(MIT)
options=('staticlibs' '!strip' '!buildflags')
makedepends=(git python "${_target}-configure")
_commit=dc41ecef85b094b30c612113606597b91c55351c  # tags/1.7.4^0
source=("git+https://anongit.freedesktop.org/git/harfbuzz#commit=$_commit")
sha256sums=('SKIP')

pkgver() {
  cd $_basename
  git describe --tags | sed 's/-/+/g'
}

prepare() {
  cd $_basename
  sed -i '/SUBDIRS/s/test//' Makefile.am
  NOCONFIGURE=1 ./autogen.sh
}

build() {
  cd $_basename
  unset LDFLAGS
  mkdir -p build-${_target} && pushd build-${_target}
    ${_target}-configure \
      --with-icu=yes \
      --with-freetype \
      ..
  #sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool
  make
  popd
}

package() {
  cd $_basename
  pushd build-${_target}
  make DESTDIR="$pkgdir" install

  find "$pkgdir/${_prefix}/${_target}" -name '*.a' -name '*.so' -type f -exec ${_arch}-strip -g {} \;
  popd
}
