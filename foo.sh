#!/bin/sh

IFILE="./cct_20140602_report_brlusd.csv"
OFILE="${IFILE%%.*}_edited.csv"

sfi="$IFS"
while IFS=';' read date total spot index period
do
    period=$(echo $period | sed 's/,//g;s/\./,/g')
    echo "$date;$total;$spot;$index;$period"
done < $IFILE > $OFILE
IFS="$sfi"
