#!/usr/bin/env Rscript
mydata.dat="$1"

daq = read.table(file('mydata.dat'))
X11()
pairs(daq)

message("Press Return To Continue")
invisible(readLines("stdin", n=1))
