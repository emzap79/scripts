# vim:fdm=marker:
#!/usr/bin/env python#{{{


# encoding: utf-8

# Print Files in specific directory#{{{

# http://stackoverflow com/a/2909998
import sys,os
# import sys,os,pathlib     # ab python 3 4

root = "/home/zapata/Unimaterialien/Winter1213/CompStat"
path = os.path.join(root, "targetdirectory")

for path, subdirs, files in os.walk(root):
    for name in files:
        print pathlib.PurePath(path, name)
        # print os.path.join(path, name)

#}}}

#!/usr/bin/env python#}}}

