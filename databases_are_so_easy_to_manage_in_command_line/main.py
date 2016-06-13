#!/usr/bin/env python
"""
# ===---Description------------------------------------------------------------===
#   "Databases are so easy to manage in command line" Project, by Guillaume
#
#   Solutions by Alexandro de Oliveira, for Holberton School
# ===---------------------------------------------------------------------------===
"""
import sys
# Show Python version:
# print(sys.version)

# Actions:
actions = (
"create",
"print",
"insert",
"delete"
)

if len(sys.argv) < 2:
    print "Please enter an action"
    sys.exit()

if sys.argv[1] not in actions:
    print "Undefined action " + sys.argv[1]
    sys.exit()
else:
    print sys.argv[1]
