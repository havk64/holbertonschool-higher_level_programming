#!/usr/bin/env python
import sys

'''
    Function to print to stdout each sequence from a to b.
'''
def alphabet(a,b):
    for i in xrange(ord(a),ord(b)+1):
        sys.stdout.write(chr(i))

#Calling the function:
alphabet('a', 'z')
