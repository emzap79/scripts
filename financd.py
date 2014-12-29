#!/usr/bin/env python
# encoding: utf-8
# http://stackoverflow.com/a/23099918/3569509

import urllib
import re

name = raw_input('> ')

htmlfile = urllib.urlopen("http://finance.yahoo.com/q?s=%s" % name)

htmltext = htmlfile.read()

# The problemed area 
# regex = '<span id="yfs_l84_%s">(.+?)</span>' % name
regex = '<span id="yfs_l84_goog">(.+?)<\/span>'

pattern = re.compile(regex)

price = re.findall(pattern, htmltext)

print price
