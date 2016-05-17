#!/usr/bin/env python
import sys
def alphabet(a,b):
    for i in xrange(ord(a),ord(b)+1):
        sys.stdout.write(chr(i))

alphabet('a', 'z')
