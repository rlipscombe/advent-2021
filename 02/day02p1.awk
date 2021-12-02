BEGIN { HORIZ = 0; DEPTH = 0 }

/forward/ { HORIZ += $2 }
/up/ { DEPTH -= $2 }
/down/ { DEPTH += $2 }

END {
    print "horizontal: " HORIZ ", depth: " DEPTH ", result: " HORIZ * DEPTH
}
