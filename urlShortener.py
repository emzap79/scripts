#!/usr/bin/env python2

#Name          : URL Shortener | url.py
#Version       : 0.1
#Writer(s)     : Alex Long
#Description   : A simple url shortener that uses the Google API. It takes a command line argument to
# quickly shorten URLs
#Notes         : http://null-byte.wonderhowto.com/how-to/shorten-urls-from-command-line-with-python-0131889/

import json
import urllib
import urllib2
import sys

def main(url):
    gurl = 'http://goo.gl/api/url?url=%s' % urllib.quote(url)
    req = urllib2.Request(gurl, data='')
    req.add_header('User-Agent', 'toolbar')
    results = json.load(urllib2.urlopen(req))
    return results['short_url']

if __name__=='__main__':
        print main(sys.argv[1])
