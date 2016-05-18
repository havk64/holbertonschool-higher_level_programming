#!/usr/bin/env python
from sys import stdout
write = stdout.write
"""
    Function to print to stdout each sequence from a to b.
"""
def alphabet(a,b):
    for i in xrange(ord(a),ord(b)+1):
        write(chr(i))

#Calling the function:
alphabet('a', 'z')
