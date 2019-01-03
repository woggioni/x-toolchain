#!/bin/bash
if command -v ccache > /dev/null
then
    export PATH="/usr/lib/ccache/bin:$PATH"
fi
/opt/xng/bin/ct-ng build

