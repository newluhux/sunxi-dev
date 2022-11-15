#!/bin/sh

POS=$(dirname $(realpath $0))
guix shell -M8 -c4 -m $POS/dev-manifest.scm
