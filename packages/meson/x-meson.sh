#!/bin/bash -ex

exec meson setup \
  --cross-file     @PREFIX@/meson/toolchain-@TRIPLE@.meson \
  --prefix         @PREFIX@ \
  --libdir         @PREFIX@/@TRIPLE@/sysroot/lib \
  --libexecdir     @PREFIX@/@TRIPLE@/sysroot/lib \
  --bindir         @PREFIX@/@TRIPLE@/sysroot/bin \
  --sbindir        @PREFIX@/bin \
  --includedir     @PREFIX@/@TRIPLE@/sysroot/usr/include \
  --datadir        @PREFIX@/@TRIPLE@/sysroot/share \
  --mandir         @PREFIX@/@TRIPLE@/sysroot/share/man \
  --infodir        @PREFIX@/@TRIPLE@/sysroot/share/info \
  --localedir      @PREFIX@/@TRIPLE@/sysroot/share/locale \
  --sysconfdir     @PREFIX@/@TRIPLE@/sysroot/etc \
  --buildtype      release \
  --wrap-mode      nofallback \
  "$@" \
  -D               b_lto=true
