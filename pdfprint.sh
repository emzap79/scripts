#!/bin/csh
if( $# == 2 ) then
set printer=$2
else
set printer=$PRINTER
endif

if( $1 != "" ) then
cat ${1} | acroread -toPostScript | lpr -P $printer
echo ${1} sent to $printer ... OK!
else
echo PDF Print: No filename defined!
endif
