#!/bin/bash -ex

exec meson setup \
  --cross-file     @PREFIX@/meson/toolchain-@TRIPLE@.meson \
  --prefix         @PREFIX@ \
  --libdir         @PREFIX@/@TRIPLE@/sysroot/usr/lib \
  --libexecdir     @PREFIX@/@TRIPLE@/sysroot/libexec \
  --bindir         @PREFIX@/@TRIPLE@/sysroot/usr/bin \
  --sbindir        @PREFIX@/sysroot/usr/sbin \
  --includedir     @PREFIX@/@TRIPLE@/sysroot/usr/include \
  --datadir        @PREFIX@/@TRIPLE@/sysroot/usr/share \
  --mandir         @PREFIX@/@TRIPLE@/sysroot/usr/share/man \
  --infodir        @PREFIX@/@TRIPLE@/sysroot/usr/share/info \
  --localedir      @PREFIX@/@TRIPLE@/sysroot/usr/share/locale \
  --sysconfdir     @PREFIX@/@TRIPLE@/sysroot/etc \
  --buildtype      release \
  --wrap-mode      nofallback \
  "$@" \
  -D               b_lto=true
