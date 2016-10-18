#!/usr/bin/python
# http://userlocal.com/2011/09/02/random-signatures-with-python/
#
# Download Quotations from Famous People
#
# # curl 'http://www.brainyquote.com/quotes/authors/a/ayrton_senna_[1-5].html?vm=l' -o '#1.html'
# # egrep -i 'content' *.html | egrep '&quot;' | sed "s/\&\#39\;/'/g;s/^.*=\"\&quot\;/\"/g;s/\&quot\;//g;s/.$//g" | tee -a ~/.sigdata && rm *.html 
# # !curl:s/a\/ayrton_senna/n\/nelson_mandela

import string, random

foo = open("/home/zapata/.sigdata").read()
foo = string.split( foo, "\n\n" )
foo = filter( None, map( string.strip, foo ))
bar = random.choice(foo)
foo2 = open('/home/zapata/.mutt/signature_random_citation','w')
foo2.write(bar)
foo2.close()
