#!/bin/bash
# vim:fdm=syntax
# LanguageTool nightly diff tests on Wikipedia data
# https://github.com/languagetool-org/languagetool-website/blob/master/regression-test/languagetool-regression-test.sh
# dnaber, 2013-03-24

############
#  config  #
############
# today=$(date +%Y%m%d)
today=20140319
month=$(date +%Y%m)
LOG="$HOME/.logfiles"
lockfile="${month}.langtool.lock"
jarFile="languagetool.jar"
remoteJarFile="LanguageTool-${today}-snapshot.zip"
jarUrl="http://www.languagetool.org/download/snapshots/$remoteJarFile"
targetDir="$HOME/.dictionaries"


##################
#  start script  #
##################
# check if the user has an active internet connection
chk_conn () {
    testconnection=`wget --tries=3 --timeout=15 www.google.com -O /tmp/.testinternet &>/dev/null 2>&1`
    if [[ $? != 0 ]]; then
        exec 3> >(zenity --notification --listen)
        echo "message:You are not connected to the Internet. Please check your Internet connection and try again." >&3
        exit 0
    else
        echo Internet connection # ok
        rm /tmp/.testinternet  > /dev/null 2>&1
    fi
}

# ckeck for lockfile
chk_if_already_executed () {
    # Lockfile löschen falls älter als ein tag
    if [[ -f "$LOG/$lockfile" ]]; then
            # Skript beenden
            echo "Du hast das Languagetool bereits heruntergeladen!"
            exit 1
        else
            # Alte Lockfile löschen/Neue anlegen
            rm -v $LOG/*.langtool.lock
            touch "$LOG/$lockfile"
    fi
}

# download languagetool
dwl_langtool ()
{
if [[ ! -f "/tmp/$remoteJarFile" ]]; then
    wget -d /tmp/ $jarUrl
    yes y | unzip /tmp/$remoteJarFile -d $targetDir
    file=$(ls ~/.dictionaries/ | grep LanguageTool | sort | tail -n1)
    sed -i "s/let g\:languagetool_jar.*/let g\:languagetool_jar = \'\$HOME\/.dictionaries\/${file}\/languagetool-commandline.jar\'/g" ~/.vim/vimrc_plugs
else
    echo "Neueste Zip-Datei bereits installiert"
fi
}

# start functions
chk_conn
chk_if_already_executed
dwl_langtool
#  EOF  #
