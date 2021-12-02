#!/bin/bash
HORIZ=0
DEPTH=0

forward() { HORIZ=$((HORIZ+$1)); }
up() { DEPTH=$((DEPTH-$1)); }
down() { DEPTH=$((DEPTH+$1)); }

source $1

echo $((HORIZ * DEPTH))
