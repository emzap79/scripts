#!/bin/bash
# A quick shell script to show new files added to the file system
# Syntax ./script /path/to/dir days 
# Defaults ./script $PWD 3 
# Author: nixCraft <webmaster@cyberciti.biz> under GPL v2.x+
# http://www.cyberciti.biz/faq/unix-linux-command-to-check-new-files-in-file-system/
# -----------------------------------------------------------------
_pwd="$(pwd)"
_now=$(date +"%Y-%m-%d" --date="${2:-3} days ago")
_d="${1:-$_pwd}"
 
# a bad idea but I'm too lazy
_f="/tmp/thisfile.$$"
 
touch --date "$_now" "$_f"
find "$_d" -type f -newer "$_f"
/bin/rm -f "$_f"
