#!/bin/bash
#http://tex.stackexchange.com/questions/16367/convert-tex-to-non-tex-and-back/16406#16406
#quote-latex shell script: use Pygmentize to turn a Latex file into an
#HTML file whose text content is the original file.
pysty=colorful
die () { echo "$@"; exit 1; }
test -f "$1" || die "$1 isn't a regular file"
cat <<EOF
<HTML>
<HEAD>
<TITLE>$1 (style=$pysty)</TITLE>
<STYLE type="text/css">
EOF
pygmentize -f html -S $pysty
cat <<EOF
</STYLE>
</HEAD>
<BODY>
EOF
pygmentize -f html -O style=$pysty "$1"
echo "</BODY></HTML>"
