#! /usr/bin/env bash
# ur1ca.sh
# Shorten a long URL from bash command line,
# using ur1.ca open source service.
# ksaver (at identi.ca), Aug 2010.
# Public Domain Code.
# No warranty at all.
#
# http://snipplr.com/view/39464/

function _curl()
{
    /usr/bin/env curl -s -A 'Mozilla' "$@"
}

function html_txt()
{
    read string
    echo "$string" |sed -e 's/<[^>]*>//g'
}

function usage()
{
    prname=$(basename $0)
    echo -e "\tUsage: $prname <long-url>"
    echo -e "\tExamp: $prname http://www.google.com/search?q=bash+scripting"
}

function _main_()
{
    if [ -z "$1" ]
    then
        usage
        exit
    else
        UR1='http://ur1.ca/'
        LONG="$1"

        _curl -s "$UR1" -d"longurl=$LONG" |grep -i 'Your ur1 is' |html_txt
        echo
    fi
}

## Run script...
_main_ "$@"
