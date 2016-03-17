#!/bin/bash
#
#  Radiostationen                                       {{{1
# AUDIOSTREAM="http://yp.shoutcast.com/sbin/tunein-station.pls?id=1280356" TAG_ALBUM="977Radio" TAG_GENRE="pop" #977 Radio
# AUDIOSTREAM="http://yp.shoutcast.com/sbin/tunein-station.pls?id=450937" TAG_ALBUM="BossanovaClub" TAG_GENRE="bossa" #Bossanovaclub.com.br Radio
# AUDIOSTREAM="http://swr.ic.llnwd.net:80/stream/swr_mps_m_dasdinga" TAG_ALBUM="DasDing" TAG_GENRE="pop" #DasDing Radio
# AUDIOSTREAM="http://173.192.58.37:8162" TAG_ALBUM="ReggaetonPuro" TAG_GENRE="reggaeton" #Reggaeton Radio
# AUDIOSTREAM="http://www.shoutcast.com/sbin/tunein-station.pls?id=1367913" TAG_ALBUM="PureDancehall" TAG_GENRE="dancehall" #Dancehall Radio
# AUDIOSTREAM="http://www.shoutcast.com/sbin/tunein-station.pls?id=1275981" TAG_ALBUM="I Love Drum & Bass :: Tracks" TAG_GENRE="dnb" #DnB Radio
# AUDIOSTREAM="http://relais02.webradiofactory.com/paris-one.mp3" TAG_ALBUM="ParisOneDance" TAG_GENRE="dance" #ParisOneDance-Stream
AUDIOSTREAM="http://funkhaus-europa.akacast.akamaistream.net/7/264/119440/v1/gnl.akacast.akamaistream.net/funkhaus-europa" TAG_ALBUM="Funkhaus_Europa" TAG_GENRE="world" #Funkhaus Europa

#  Konfiguration                                        {{{1
DATE=`/bin/date +%Y%m%d`
CHECK_DATE_DIR="/home/zapata/tmp/streamripper" #Verzeichnis der Datum-Steuerdatei und temporäres Einbinden der Backup-Platte
CHECK_RIP="/home/zapata/tmp/streamripper"
CHECK_RIP_DIR="/home/zapata/tmp/streamripper/music"
DATE_FILE="$CHECK_DATE_DIR/$DATE.date" #Datum-Steuerdatei, ob Backup schon durchgeführt wurde
REC_TIME="3200" TAG_YEAR="2012" TAG_TRACK=""

# check if you already have been ripping a stream today  {{{2
function check {
if [ ! -f $DATE_FILE ]; then
    sleep 5
    rm -f $CHECK_DATE_DIR/*.date
    exec 3> >(zenity --notification --listen)
    echo message:"Internetstream wird aufgenomen" >&3
    /usr/bin/touch $DATE_FILE
    mkdir -p $CHECK_RIP $CHECK_RIP_DIR
    testConnection
else
    exec 3> >(zenity --notification --listen)
    echo message:"Es wurde bereits ein Internetstream aufgenomen" >&3
fi
}

# check if the user has an active internet connection    {{{2
function testConnection()
{
    testconnection=`wget --tries=3 --timeout=15 www.google.com -O /tmp/.testinternet &>/dev/null 2>&1`
    if [[ $? != 0 ]]; then
        exec 3> >(zenity --notification --listen)
        echo "message:You are not connected to the Internet. Please check your Internet connection and try again." >&3
        exit 0
    else
        echo Internet connection - ok
        rm /tmp/.testinternet  > /dev/null 2>&1
        stream
    fi
}

# start streaming                                       {{{2
function stream()
{
if [ ! -f $DATE_FILE ]; then
    sleep 5
    rm -f $CHECK_DATE_DIR/*.date
    /usr/bin/touch $DATE_FILE
    mkdir -p $CHECK_RIP $CHECK_RIP_DIR
    streamripper $AUDIOSTREAM -d $CHECK_RIP -l 3200
    #oder
    #streamripper AUDIOSTREAM -a ~/tmp/streamripper/$(date +%x_%X).mp3 -L ~/tmp/streamripper/$(date +%x_%X) --xs2 -l 3200
    #mp3splt -c ~/tmp/streamripper/*.cue ~/tmp/streamripper/*.mp3
    find $CHECK_RIP -name "AMTAG*" -type f -exec rm "{}" ";"
    find $CHECK_RIP -mmin -60 -exec lltag --yes -A "$TAG_ALBUM" -g "$TAG_GENRE" -n "$TAG_TRACK" -y "$TAG_YEAR" "{}" ";"
    find $CHECK_RIP -size +10000k -name "*.mp3" -exec rm "{}" ";"
    find $CHECK_RIP -size +1000k -name "*.mp3" -exec mv "{}" $CHECK_RIP_DIR ";"
    beet import -sqC $CHECK_RIP_DIR
    beet import -qC $CHECK_RIP_DIR
    beet import -A $CHECK_RIP_DIR
    exit 0
else
    exit 0
fi
}
#Start
check
exit 0
