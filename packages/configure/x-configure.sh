#!/bin/sh

# check if last arg is a path to configure, else use parent
for last; do true; done
if test -x "${last}/configure"
then
  config_path="$last"
else
  config_path=".."
fi

export LDFLAGS="-Wl,-rpath=@PREFIX@/@TRIPLE@/sysroot/lib:@PREFIX@/@TRIPLE@/sysroot/usr/lib -Wl,-dynamic-linker=@DYNAMIC_LINKER@"
${config_path}/configure --build="$CHOST" --host=@TRIPLE@ --target=@TRIPLE@ \
  --prefix=@PREFIX@/@TRIPLE@/sysroot \
  --sbindir=@PREFIX@/@TRIPLE@/sysroot/usr/sbin \
  --bindir=@PREFIX@/@TRIPLE@/sysroot/usr/bin \
  --includedir=@PREFIX@/@TRIPLE@/sysroot/usr/include \
  --libdir=@PREFIX@/@TRIPLE@/sysroot/usr/lib \
  --datarootdir=@PREFIX@/@TRIPLE@/sysroot/usr/share \
  --enable-shared --enable-static "$@"

