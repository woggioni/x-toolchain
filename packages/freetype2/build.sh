# $Id$
# Maintainer: Jan de Groot <jgc@archlinux.org>

pkgbase=freetype2
pkgver=2.13.2
pkgrel=1
pkgdesc="Font rasterization library"
arch=(x86_64)
license=('GPL')
url="https://www.freetype.org/"
options=('staticlibs' '!buildflags')
# adding harfbuzz for improved OpenType features auto-hinting
# introduces a cycle dep to harfbuzz depending on freetype wanted by upstream
depends=("${_target}-gcc"
         "${_target}-zlib"
         "${_target}-bzip2"
         "${_target}-libpng" "sh")

makedepends=("libx11" "${_target}-configure")

source=( https://download-mirror.savannah.gnu.org/releases/freetype/freetype-$pkgver.tar.xz{,.sig}
        0001-Enable-table-validation-modules.patch
        0002-Enable-subpixel-rendering.patch
        0003-Enable-long-PCF-family-names.patch)

b2sums=(
  'cebc82180d9afaeb112a65ba78903d7bf7a9295a803166a033585ad2325add6023f05066852240c4665e56285345ba503b01ecd461d48f0478a8f3f56136988e'
  'SKIP'
  '2c148694e150b3faae9dc46ead824ae6d94cfe34f2918bc9066f45bab7e6b6f77b4d4b2fee00c3d466d866e1985132cea4a774dcf1bab95409b7cf55efff01e1'
  '9598d13eae0411878c1af8e5d875c3b1fc09f4e6649edfbbf3b0a819c4c585648521f0b30ffd1318f5106cfde9c899d3db70c8ffe36dac59f3f98b5fd7dab115'
  '66deb179d1f1f4e2e35f6d50acfbacce80595d5128f5fed8c1871838c210dbf1a7173a87dd937d64997844c8f478c8f81120f71e33b9d59d980e179d103ff31c'
)

validpgpkeys=('E30674707856409FF1948010BE6C3AAC63AD8E3F')

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
  patch -Np1 -i ../0002-Enable-subpixel-rendering.patch
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
  popd
}

strip() {
    ${_target}-strip $@
}
export -f strip