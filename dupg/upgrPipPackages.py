#!/usr/bin/env python
# http://pythonadventures.wordpress.com/2013/05/22/update-all-pip-packages/

import os
import pip

dists = []
for dist in pip.get_installed_distributions():
    dists.append(dist.project_name)

for dist_name in sorted(dists, key=lambda s: s.lower()):
    cmd = "sudo pip install {0} -U".format(dist_name)
    print '#', cmd
    os.system(cmd)
