#!/bin/bash
HORIZ=0
DEPTH=0
AIM=0

up() { AIM=$((AIM-$1)); }
down() { AIM=$((AIM+$1)); }
forward() { HORIZ=$((HORIZ+$1)); DEPTH=$((DEPTH + (AIM * $1))); }

source $1

echo $((HORIZ * DEPTH))
