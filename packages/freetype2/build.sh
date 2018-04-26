# $Id$
# Maintainer: Jan de Groot <jgc@archlinux.org>

pkgbase=freetype2
pkgver=2.9
pkgrel=1
pkgdesc="Font rasterization library"
arch=(x86_64)
license=('GPL')
url="https://www.freetype.org/"
options=('staticlibs' '!strip' '!buildflags')
# adding harfbuzz for improved OpenType features auto-hinting
# introduces a cycle dep to harfbuzz depending on freetype wanted by upstream
depends=("${_target}-gcc"
         "${_target}-zlib"
         "${_target}-bzip2"
         "${_target}-libpng" "sh")
makedepends=("libx11" "${_target}-configure")
source=(https://download-mirror.savannah.gnu.org/releases/freetype/freetype-${pkgver}.tar.bz2{,.sig}
        0001-Enable-table-validation-modules.patch
        0002-Enable-infinality-subpixel-hinting.patch
        0003-Enable-long-PCF-family-names.patch)

sha1sums=('94c4399b1a55c5892812e732843fcb4a7c2fe657'
          'SKIP'
          'b69531770c343d403be294b7e4d25ac45738c833'
          '3d26a569f0cb94c28a550577f5dcaadb4e193d91'
          '770f1981734a837bcf065564c91644b4cc5e256a')
validpgpkeys=('58E0C111E39F5408C5D3EC76C1A60EACE707FDA5')

if [[ $pkgname = "${_target}-freetype2-bootstrap" ]]; then
  _provides=${pkgname%-bootstrap}
else
  _provides=${pkgname}
  # adding harfbuzz for improved OpenType features auto-hinting
  # introduces a cycle dep to harfbuzz depending on freetype wanted by upstream
  depends+=("${_target}-harfbuzz")
  replaces+=(${_provides})
fi
provides+=(${_provides})
conflicts+=(${_provides})

prepare() {
  # Rename source dir to allow building the demos
  mv freetype-${pkgver} freetype2
  
  cd freetype2
  patch -Np1 -i ../0001-Enable-table-validation-modules.patch
  patch -Np1 -i ../0002-Enable-infinality-subpixel-hinting.patch
  patch -Np1 -i ../0003-Enable-long-PCF-family-names.patch
}

build() {
  cd freetype2
  mkdir -p build-${_target} && pushd build-${_target}
  ${_target}-configure
  make
  popd
}

package() {
  cd freetype2
  pushd build-${_target}
  make DESTDIR="${pkgdir}" install
  find "$pkgdir/${_prefix}/${_target}" -name '*.a' -name '*.so' -type f -exec ${_arch}-strip -g {} \;
  popd
}
# vim:set ts=2 sw=2 et:
