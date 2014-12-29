#!/bin/bash
# usage: auto-index [dir]
# copied from: http://www.alecjacobson.com/weblog/?p=192

DATE=$(ls -al $1 | awk '{print substr($0, index($0,$6)) }' | sed 's/\(.*\) .*$/\1/g')
SIZE=$(ls -hs $1 | awk '{print $1}')
INDEX=`ls -1 $1 | egrep -v '*.html' | sed 's/ß/\&szlig\;/g;s/Ü/\&Uuml\;/g;s/ü/\&uuml\;/g;s/Ö/\&Ouml\;/g;s/ö/\&ouml\;/g;s/ä/\&auml\;/g;s/Ä/\&Auml\;/g;s/ü/&uuml\;/g' | sed 's/^.*/      <li\>\<a\ href=\"&\"\>&\<\\/a\>\<\\/li\>/'`
echo "<html>
<tr><td valign=top><img src=/icons/back.gif alt=[DIR]></td><td><a href=../>Parent Directory</a></td><td>&nbsp;</td><td align=right>  - </td></tr>
<head><title>Index of $1</title></head>
<body>
<h2>Index of $1</h2>
<hr>
<ui>

$INDEX
</tr>
</ui>
</body>
</html>"
