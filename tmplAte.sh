#!/bin/bash                                             {{{1

# vim:fdm=marker:set cb=unnamedplus
#/* vim: set filetype=sh : */

# Strings manipulieren                                  {{{1
# http://stackoverflow.com/a/1853984/1483760
# http://stackoverflow.com/a/9057392/1483760
# http://wiki.bash-hackers.org/scripting/posparams#mass_usage
# http://tldp.org/LDP/abs/html/string-manipulation.html

# Dateinamen abkürzen                                  {{{2

FBN=`basename "$1" .mp3`
NAME=${1%%.*}                             # Gibt nur den Songnamen der MP3 aus
EXT=${1##*.}                              # Gibt nur das Format der File aus (e.g. mp3, ogg ...)
dt=`date +%d%m%y`                         # bspw. 311215 für den 31.12.2015
echo "${dt:4:2}-${dt:2:2}-${dt:0:2}"      # wandelt string um in yyyy-mm-dd

# Addieren, Subtrahieren etc                            {{{2

# http://askubuntu com/a/385532
x=1; (( $x+1 )); echo $x #Addiert zu x=1 eine Zahl hinzu (=2)

# Bedeutung von Anführungszeichen                      {{{2

VAR="aa            bb                  cc"
echo $VAR           #aa bb cc
echo "$VAR"         #aa            bb                  cc
echo '$VAR'         #$VAR

# Dateien und Ordner umbenennen                         {{{1

# Dotfiles umbenennen                                   {{{2

# rename ~/ dotfiles
echo "Cutting leading '.' off of dotfiles"
find $dir -maxdepth 1 -name '.*' -print0 | xargs -r0 rename -v 's|/\.+([^/]+)$|/$1|'

# Rename Downloaded Facebook-Images                   # {{{2

numb=0; lst | tail -n 11 | awk '{print substr($0,52)}' | while read l; do (( numb++ )); mv $l $(printf %02d $numb)_fb.jpg; done

# Löschen leerer Ordner                                {{{2

find $PATH -depth -type d -empty -exec rmdir -v -- {} \; #Löscht auch Ordner mit Umlauten und Leerzeichen
find . -depth -type d -empty -exec rmdir -v -- {} \; #Löscht Ordner mit Umlauten und Leerzeichen in akt. Verz

# AWK-Commands                                          {{{1

awk '{print $5}'                        #gibt lediglich letzte Spalte aus
awk '{for(i=1;i<8;i++) $i="";print}'    #gibt alle Spalten bis auf die erste aus
awk '{$1=$2=$3="";print}'               #gibt alle Spalten aus bis auf die ersten drei
awk 'FNR == 1{print}'                   #output ist erste Zeile

shopt -s nocasematch #Stellt System auf Case-Insensitive
shopt -u nocasematch && shopt | grep nocasematch #Stellt System auf Case-Sensitive

# Checkt ob Skript gerade ausgeführt wird              {{{1

lf=/tmp/pidLockFile
touch $lf
read lastPID < $lf
[ ! -z "$lastPID" -a -d /proc/$lastPID ] && exit
echo not running
echo $$ > $lf

# Root-Passwort-Abfrage                                 {{{1
# check root                                            {{{2

http://www.cyberciti.biz/faq/appleosx-bsd-shell-script-get-current-user/

## get UID
uid=$(id -u)

## Check for it
if [[  $uid -ne 0  ]]; then
    exit 1
fi

## show username
echo `uid -un`

# Alternative 1                                         {{{2

gksudo "sh -c 'command1; command2; ...'"
#http://stackoverflow com/questions/10470084/shell-script-how-can-i-use-gksudo-to-perform-consecutive-sudo-operations-with-o ##

# Alternative 2                                         {{{2

TITEL="foobar"

function test_DE {
if [ x"$KDE_FULL_SESSION" = x"true" ]; then
    SUDOFRONT="kdesudo"
    DIALOG_QUESTION="kdialog --yesno"
    INFO_MESSAGE="kdialog --msgbox"
else
    SUDOFRONT="gksudo"
    DIALOG_QUESTION="zenity --question --title $TITEL --text"
    INFO_MESSAGE="zenity --info --title $TITEL --text"
fi
}

test_DE
$DIALOG_QUESTION \
    "Möchtest du ein bischen foo als root machen?"

if [ $? -eq 0 ];then
    $SUDOFRONT "NAME DER ANWENDUNG"
    $INFO_MESSAGE 'Hat funktioniert!'
else
    $INFO_MESSAGE "bye"
fi

exit 0

# Terminal Root-Abfrage                                 {{{2

read -p "Installer: Adminrechte werden benötigt. Wollen sie fortfahren (Y|n)? " answer
case "$answer" in
    Yes|yes|Y|y|"")
        sudo echo -e "Ok los geht's"
        ;;
    No|no|N|n)
        echo -e "Abbruch. Ohne Root Rechte kann das Skript\nnicht ausgeführt werden"
        exit 1
        ;;
    *)
        echo -e "Unbekannter Parameter... Operation abgebrochen!"
        exit 1
        ;;
esac

#EOF
exit 0

# Benachrichtigung ausgeben lassen                      {{{1
# Notify-Send                                           {{{2

export DISPLAY=:0  #Damit Notify-Send auch in Cron-gesteuerten Skripten arbeitet
notify-send --hint=int:transient:1 Test #Lässt die Notify-Send-Benachrichtigung nach einiger Zeit aus dem Panel verschwinden

# Zeilenumbruch für Benachrichtigung (notify-send)     {{{2

notify-send "Escape character for newline doesn't work" \
    "$(echo -e "This is the first line.\nAnd this is the second.")"

# Zenity Abfrage                                        {{{2

# Variante 1                                            {{{3

zenity --question --title="BEISPIEL" --text="AKTION 1 ausführen?"
if [ $? = 0 ];
then
    AKTION 1
else
    ABBRECHEN
fi

# Variante 2                                            {{{3

notify-send "Escape character for newline doesn't work" \
    "$(echo -e "This is the first line.\nAnd this is the second.")"

# Variante 3 - Zenity                                   {{{3

exec 3> >(zenity --notification --listen)
echo "message:Daten erfolgreich abgeglichen\n... kannst den Stick jetzt aushängen!" >&3

dlgQUEST="zenity --question --title "$titel" --text "$text" --display=:0.0" #diese Endung muss nur für Cronaufgaben eingegeben werden!
dlgMESSAGE="zenity --info --title "$titel" --text "$text" --display=:0.0"
zenity=$(which zenity --question)
zenityQuestion=$($zenity --entry --text "text" --title="TITLE")
selFile=`zenity --title="Select Desired File" --file-selection`

# If & While                                            {{{1
# If Condition                                          {{{2

#http://anwendungsentwickler ws/index php?id=483
#Hier mal ein Beispiel wie man in der Linux Bash mehrere Bedingungen in einem if-Statement abfragen kann  Das ganze sieht ein wenig anders aus als in einer "normalen" Programmiersprache

# If-Condition: Und                                     {{{3

if [ "$SHELL" == "/bin/bash" ] && [ "$USER" == "sim4000" ]; then
echo "User und Shell sind richtig";
fi

# If-Condition: Oder                                    {{{3

if [ "$SHELL" == "/bin/bash" ] || [ "$USER" == "sim4000" ]; then
echo "User oder Shell sind richtig";
fi

# If-Condition: UND / ODER                              {{{3

if ( [ "$a" == "a" ] || [ "$a" == "b" ] ) && ( [ "$b" == "c" ] ); then
echo "moo";
fi
#Ganz wichtig ist dabei kein Leerzeichen zu vergessen! Vor allem bei den Vergleichsoperatoren  Schreibt man zum Beispiel $foo=="bar" anstatt $foo == "bar", wird die Bedingung immer wahr sein  Also nix mit Fehlermeldung
#Lässt man aber das Leerzeichen zwischen if und [ weg, gibt es eine Fehlermeldung

# If-Condition: Für Cronjobs
s=`date +%W`
a=`expr $s % 2`
if [ "$a" -eq 0 ]
then
    #gerade Woche
    echo "do something"
else
    #ungerade Woche
    echo "do nothing"
fi

# While-Schleifen                                       {{{2
# Internal Field Seperator (IFS)                        {{{1

read -p "Gib eine beliebige Anzahl an Worten ein: " word
var=$(printf "%s\n" $word)
sfi=$IFS
cat $1 |\
while IFS=':' read a b c d
do
    echo "a $a"
    echo "b $b"
    echo "c $c"
    echo "d $d"
done
IFS=$sfi

# Variante 1                                            {{{2

numb=0
while read -r line
do
    numb=$((numb+1))
    echo "Zaehler in der Schleife: $numb"
done < "$var"
echo "Zaehler nach der Schleife: $numb"

# Variante 2                                            {{{2

echo "Frage: Was ergibt 2 + 2"
echo ""
while true
do
    read -p "Bitte ihre Eingabe:" answer
    case "$answer" in
        4) echo Richtig
            break
            ;;
        *) echo Falsch
            ;;
    esac
done

# Skript ausführen bis beliebige Taste gedrückt wird  {{{1

if [ -t 0 ]; then stty -echo -icanon time 0 min 0; fi

count=0
keypress=''
while [ "x$keypress" = "x" ]; do
    let count+=1
    echo -ne $count'\r'
    read keypress
done

if [ -t 0 ]; then stty sane; fi

echo "You pressed '$keypress' after $count loop iterations"
echo "Thanks for using this script."

# Countdown Anzeige                                     {{{1

# Variante 1                                            {{{2

for i in {10..1};do echo $i && sleep 0.2; done

# Variante 2                                            {{{2

countdown()
{
    countdown=${1:-60}   ## 60-second default
    w=${#countdown}
    while [ $countdown -gt 0 ]
    do
        sleep 1 &
        printf "  %${w}d\r" "$countdown"
        countdown=$(( $countdown - 1 ))
        wait
    done
    printf "\a"
} 2>/dev/null
countdown

# Variante 3 - ausführlich                             {{{2

if [ "$#" -lt "2" ] ; then
    echo "Incorrect usage ! Example:"
    echo "$0 -d "Jun 10 2011 16:06""
    echo 'or'
    echo "$0 -m 90"
    exit 1
fi

now=`date +%s`

if [ "$1" = "-d" ] ; then
    until=`date -d "$2" +%s`
        sec_rem=`expr $until - $now`
        echo "-d"
        if [ $sec_rem -lt 1 ]; then
            echo "$2 is already history !"
        fi
    fi

    if [ "$1" = "-m" ] ; then
        until=`expr 60 \* $2`
            until=`expr $until + $now`
                sec_rem=`expr $until - $now`
                echo "-m"
                if [ $sec_rem -lt 1 ]; then
                    echo "$2 is already history !"
                fi
            fi

            while [ $sec_rem -gt 0 ]; do
                clear
                date
                let sec_rem=$sec_rem-1
                interval=$sec_rem
                seconds=`expr $interval % 60`
                interval=`expr $interval - $seconds`
                minutes=`expr $interval % 3600 / 60`
                interval=`expr $interval - $minutes`
                hours=`expr $interval % 86400 / 3600`
                interval=`expr $interval - $hours`
                days=`expr $interval % 604800 / 86400`
                interval=`expr $interval - $hours`
                weeks=`expr $interval / 604800`
                echo "----------------------------"
                echo "Seconds: " $seconds
                echo "Minutes: " $minutes
                echo "Hours:   " $hours
                echo "Days:    " $days
                echo "Weeks:   " $weeks
                sleep 1
            done

# Variante 4                                            {{{2

function countdown
{
    local OLD_IFS="${IFS}"
    IFS=":"
    local ARR=( $1 )
    local SECONDS=$((  (ARR[0] * 60 * 60) + (ARR[1] * 60) + ARR[2]  ))
    local START=$(date +%s)
    local END=$((START + SECONDS))
    local CUR=$START

    while [[ $CUR -lt $END ]]
    do
        CUR=$(date +%s)
        LEFT=$((END-CUR))

        printf "\r%02d:%02d:%02d" \
            $((LEFT/3600)) $(( (LEFT/60)%60)) $((LEFT%60))

        sleep 1
    done
    IFS="${OLD_IFS}"
    echo
}
countdown "00:07:55"

# Dialoge                                               {{{1
# Variante 1                                            {{{2

read -p "Are you sure? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
echo "do dangerous stuff"
fi

# Variante 2                                            {{{2

read -p "Willst du antworten (Y|n)? " answer
case "$answer" in
Yes|yes|Y|y|"")
    sudo echo -e "Ok los geht's"
    ;;
No|no|N|n)
    echo -e "Abbruch."
    exit 1
    ;;
*)
    echo -e "Unbekannter Parameter... Operation abgebrochen!"
    exit 1
        ;;
esac

# Variante 3 # While-Loop                               {{{2

done=0
while [ "x${done}" = x0 ];
do
    echo -n "You wanna do dangerous stuff? [y/n]: "
    read answer
    if [ "x${answer}" = xy ] || [ "x${answer}" = xY ]; then
        #doing dangerous stuff
    done=1
elif [ "x${answer}" = xn ] || [ "x${answer}" = xN ]; then
    #not doin' nothing
    done=2
else
    echo "Not a valid answer"
fi
done

# Convert Images                                        {{{1

# loops
## convert images
# alias jpg2pngconv='for i in * JPG; do echo "converting $i    "; convert $i $(basename $i  JPG) png; done'

for i in $(find . -type f -exec file {} \; | grep -o -P '^.+: \w+ image' | sed 's:.*/::g' | cut -d ':' -f 1); do display $i; done
# for i in * JPG * JPEG * jpg * jpeg; do display "$i"; done
# for i in * PNG * png; do display $i; done
# for i in * GIF * gif; do animate $i; done
# for i in * PDF * pdf; do evince $i; done

# Internet Verbindung überprüfen                      {{{1

testconnection=`wget --tries=3 --timeout=15 www.google.com -O /tmp/.testinternet &>/dev/null 2>&1`
if [[ $? != 0 ]]; then
    exec 3> >(zenity --notification --listen)
    echo "message:Dein Computer ist offline. Bitte stelle erst eine funktionierende Internetverbindung her." >&3
    exit 0
else
    echo Internetverbindung - ok
    rm /tmp/.testinternet  > /dev/null 2>&1

fi

# Auswahlmenü mit Select                               {{{1

# There are several ways to make a select-menue work  Please note the specific
# use of arrays: array[*], array[@] or "array[@]" is all different!

# Variante 1                                            {{{2

echo "Enter the number of the file you want to select:"
select FILENAME in *;
do
    echo "You picked $FILENAME ($REPLY)"
done

# Variante 2                                            {{{2

selTitle=":: Beispielauswahl ::"
selPrompt="Wähle eine der Optionen:"
selOptions=("A" "B" "C")

echo "`echo $selTitle | sed 's/./:/g'`"
echo "$selTitle"
echo "`echo $selTitle | sed 's/./:/g'`"

PS3="$selPrompt "
select opt in "${selOptions[@]}" "Quit"; do
    case "$REPLY" in
        1 ) echo "Du hast Option $REPLY gewählt: $opt"
            ;;
        2 ) echo "Du hast Option $REPLY gewählt: $opt"
            ;;
        3 ) echo "Du hast Option $REPLY gewählt: $opt"
            ;;
        $(( ${#selOptions[@]}+1 )) ) echo "Goodbye!"; break
            ;;
        *) echo "Ungültige Option. Wähle etwas anderes.";continue
            ;;
    esac; break #Ohne die Option Break wird die Abfrage wiederholt!
done
#Script will loop until the user explicitly chooses Quit  This is a good approach for interactive script menus: after a choice is selected and action performed, menu is presented again for another choice  If choice is meant to be one-time only, just use break after esac
#PS3 and REPLY vars can not be renamed  select is hardcoded to use those  All other variables in script (opt, options, prompt, title) can have any names you want, provided you do the adjustments[#

# Variante 3                                            {{{2

selTitle=":: Auswahlmenue ::"
selPrompt="Wähle eine der Optionen: "

echo "`echo $selTitle | sed 's/./:/g'`"
echo "$selTitle"
echo "`echo $selTitle | sed 's/./:/g'`"

PS3="$selPrompt"
selCommand=$(some_extraordinary_weird_command)
select OPT in ${selCommand[@]} Quit
do
	case $OPT in
		"Quit")
			echo "Goodbye!";
			exit 1
			;;
		*)
			echo "du hast die Option $OPT (# $REPLY) ausgewählt"
			;;
	esac
	break
done

# Hardwareinformationen                                 {{{1
# Programme nachinstallieren                            {{{2

if [ $(dpkg-query --show | grep "NAME" | wc -l) = 0 ];
then yes y | sudo apt-get install NAME;
fi

# Externe Festplatten überprüfen                      {{{2

case "0" in
    $chkDiscWD|$chkDiscVOL)
        if [ $chkDiscWD = 0 ];then messageWD="* Festplatte *WD*"; fi
        if [ $chkDiscVOL = 0 ];then messageVOL="* Festplatte *Volume*"; fi
        if [ $chkLoopSOFTW = 0 ];then messageSOFTW="* Image *Software*"; fi
        /usr/bin/yad --center --timeout=600 --question --title=".:: Laufwerkschk ::." --text-align=center --text "Folgende Laufwerke und Images\nmüssen erst angeschlossen werden:\n\n$messageWD\n$messageVOL\n$messageSOFTW\n\n\(erst bestätigen wenn alle Festplatten eingehängt!\)" --display=:0.0
        sleep 20 #Warte bis Festplatte erkannt
        ;;
esac

# Mounting Hard-Drives                                  {{{2

#Mountet die Festplatte WDP mit Zugriffsrechten
sudo mount -t vfat UUID=$UUID $WDP -o uid=1000,gid=100,dmask=027,fmask=137

# Check mounted Drives                                  {{{2

chkDiscWD=`ls -l /dev/disk/by-uuid | grep 5338-AB62 | wc -l` #WD-Passport
chkRSYNC=`ps -aef | grep -v grep | grep rsync | wc -l`
chkMOUNT=`df -h | awk '{print $6}' | grep $BACKUP_DIR_MEDIA | wc -l`

# Checking if Computer runs on Battery-Mode             {{{2

chkPower=$(acpi -a | awk '{print $3}' | cut -d '-' -f 1)

# Alte Kernel-Versionen Löschen                        {{{2

dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge

# Other Stuff                                           {{{1

# Playing Sounds                                        {{{2

play /usr/share/sounds/gnome/default/alerts/glass.ogg repeat 2 #Sound abspielen

# Extract JPGs from PDF                                 {{{2

egrep '\.jpg' *.html | egrep http | sed 's/^.*\(http.*\)/\1/g;s/\.jpg.*$/\.jpg/g' > urls.txt

# LibreOffice konvertierung zu Latex                    {{{2

w2l IN.odt

# LibreOffice switch off recoverage of old documents    {{{2

rm /home/zapata/.config/libreoffice/4/user/registrymodifications.xcu

# Zufallszahl ausgeben lassen                           {{{2

n=$RANDOM
# display a random integer <= 200
echo $(( r %= 200 ))
# display random number between 100 and 200
echo $((RANDOM%200+100))

# CSV dateien anpassen                                  {{{2

IFILE="./infile.csv"
OFILE="${IFILE%%.*}_edited.csv"
sfi="$IFS"
while IFS=';' read date total spot index period
do
    # hiermit werden alle punkte in spalte fünf in kommata
    # umgewandelt. der befehl lässt sich beliebig anpassen.
    period=$(echo $period | sed 's/\./,/g')
    echo "$date;$total;$spot;$index;$period"
done < $IFILE > $OFILE
IFS="$sfi"
