#!/bin/sh

WORKSPACE=/tmp/jdtls.workspace/$(pwd | md5sum | cut -d ' ' -f 1)

jdtls -Dlog.level=ALL -data "$WORKSPACE" "$@"
