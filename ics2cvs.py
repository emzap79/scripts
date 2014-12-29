#!/usr/bin/env python

import urllib2
from icalendar import Calendar#, Event

outfile = "output.xls"
theurl = 'https://...'
username = 'xxx'
password = 'xxx'

QUOTE='"'
DELIM_FIELD = ","
DELIM_ROW   = "\n"
DATE_FORMAT = "%d.%m.%Y"
# a great password

passman = urllib2.HTTPPasswordMgrWithDefaultRealm()
# this creates a password manager
passman.add_password(None, theurl, username, password)
# because we have put None at the start it will always
# use this username/password combination for  urls
# for which `theurl` is a super-url

authhandler = urllib2.HTTPBasicAuthHandler(passman)
# create the AuthHandler

opener = urllib2.build_opener(authhandler)

urllib2.install_opener(opener)
# All calls to urllib2.urlopen will now use our handler
# Make sure not to include the protocol in with the URL, or
# HTTPPasswordMgrWithDefaultRealm will be very confused.
# You must (of course) use it when fetching the page though.

pagehandle = urllib2.urlopen(theurl)
# authentication is now handled automatically for us

if pagehandle.code != 200:
 print "Something went wrong. HTTP response code: %s" % pagehandle.code

fp = open(outfile,'wb')
fp.write(QUOTE)
fp.write("Start")
fp.write(QUOTE)
fp.write(DELIM_FIELD)
fp.write(QUOTE)
fp.write("End")
fp.write(QUOTE)
fp.write(DELIM_FIELD)
fp.write(QUOTE)
fp.write("Days")
fp.write(QUOTE)
fp.write(DELIM_FIELD)
fp.write(QUOTE)
fp.write("Summary")
fp.write(QUOTE)
fp.write(DELIM_ROW)

cal = Calendar.from_string(pagehandle.read())
for component in cal.walk():
 if component.name == "VEVENT":
  fp.write(QUOTE)
  fp.write(component['dtstart'].dt.strftime(DATE_FORMAT))
  fp.write(QUOTE)
  fp.write(DELIM_FIELD)
  days = (component['dtend'].dt-component['dtstart'].dt).days
  fp.write(QUOTE)
  if (days > 1):
   fp.write(component['dtend'].dt.strftime(DATE_FORMAT))
  fp.write(QUOTE)
  fp.write(DELIM_FIELD)
  fp.write(QUOTE)
  fp.write(str(days))
  fp.write(QUOTE)
  fp.write(DELIM_FIELD)
  fp.write(QUOTE)
  fp.write(component['summary'])
  fp.write(QUOTE)
  fp.write(DELIM_ROW)

fp.close()
