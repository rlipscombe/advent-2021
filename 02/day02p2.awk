BEGIN { AIM = 0; HORIZ = 0; DEPTH = 0 }

/up/ { AIM -= $2 }
/down/ { AIM += $2 }
/forward/ { HORIZ += $2; DEPTH += AIM * $2 }

END {
    print "horizontal: " HORIZ ", depth: " DEPTH ", result: " HORIZ * DEPTH
}
