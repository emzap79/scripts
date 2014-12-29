#! /usr/bin/env python
#for i in $(cat  "/home/zapata/.mutt/listBlackl"); 
#do
    #print "send-hook ~t$i unset signature"
#done

for s in open('/home/zapata/.mutt/listBlackl'):
    print 'send-hook ~t "' + s.lower() + '" unset signature'
