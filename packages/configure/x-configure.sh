#!/bin/sh

# check if last arg is a path to configure, else use parent
for last; do true; done
if test -x "${last}/configure"
then
  config_path="$last"
else
  config_path=".."
fi

LDFLAGS=""
${config_path}/configure --build="$CHOST" --host=@TRIPLE@ --target=@TRIPLE@ \
  --includedir=@PREFIX@/@TRIPLE@/sysroot/usr/include --prefix=@PREFIX@/@TRIPLE@/sysroot \
  --enable-shared --enable-static "$@"

