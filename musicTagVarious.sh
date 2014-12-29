#!/bin/bash

#########################################
#########################################
#########################################

FBN=`basename "$1" .mp3`
NAME=${1%%.*}
EXT=${1##*.}
YEAR=`id3v2 -l "$1" | grep TYER | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
ARTIST=`id3v2 -l "$1" | grep TPE1 | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
ALBARTIST=`id3v2 -l "$1" | grep TPE2 | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
TRACK=`id3v2 -l "$1" | grep TRCK | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
TITLE=`id3v2 -l "$1" | grep TIT2 | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
ALBUM=`id3v2 -l "$1" | grep TALB | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
GENRE=`id3v2 -l "$1" | grep TCON | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
IDVERS=`id3v2 -l "$1" | grep TRCK | wc -l` #1 falls IDv3 Tag vorhanden, 0 falls nicht!
ALBUMv1=`id3v2 -l "$1" | grep Album | cut -d ':' -f 2 | sed '/^ /s/^ *//'`
GENREv1=`id3v2 -l "$1" | grep Genre | cut -d ':' -f 2 | sed '/^ /s/^ *//'`

#########################################
#########################################
#########################################

ARTogg=`lltag -S "$1" | grep -i artist\= | cut -d '=' -f 2 | sed '/^ /s/^ *//;s/\//\\//' | awk 'FNR == 1 {print}'`
ARTISTogg=`lltag -S "$1" | grep -i artist\= | awk 'FNR == 1 {print}' | cut -d '=' -f 2 | sed '/^ /s/^ *//;/^The/s/\([^ ]*\) *\([^ ]*.*\)/\2, \1 /g;s/[ (][Ff]eat[\. ]*.*$//;s/[ (][Ff]t[\. ]*.*$//;s/[ (]\&\ *.*$//;s/ [Vv]s\.*.*$//;s/\(\<.\)/\U\1/g;s/ *$//'`
ALBARTISTogg=`id3v2 -l "$1" | grep -i albumartist\= | cut -d '=' -f 2 | sed '/^ /s/^ *//;s/ [ (]feat*.*$//;s/ [ (]ft*.*$//;s/[ (]\&\ *.*$//;s/ [Vv]s\.*.*$//;' | awk 'FNR == 1 {print}'`
TITLEogg=`lltag -S "$1" | grep -i title\= | cut -d '=' -f 2 | sed '/^ /s/^ *//;s/ *$//g'`
ALBUMogg=`lltag -S "$1" | grep -i album\= | cut -d '=' -f 2 | awk 'FNR == 1 {print}' | sed '/^ /s/^ *//;s/ *$//g'`
GENREogg=`lltag -S "$1" | grep -i genre\= | cut -d '=' -f 2 | sed '/^ /s/^ *//;s/ *$//g'`
TRACKogg=`lltag -S "$1" | grep -i track\= | cut -d '=' -f 2 | sed '/^ /s/^ *//;s/ *$//g' | awk 'FNR == 1 {print}'`
COMPogg=`lltag -S "$1" | grep -i composer\= | cut -d '=' -f 2 | sed '/^ /s/^ *//;s/ *$//g' | awk 'FNR == 1 {print}'`
DATEogg=`lltag -S "$1" | grep -i date\= | cut -d '=' -f 2 | sed '/^ /s/^ *//;s/ *$//g' | awk 'FNR == 1 {print}'`
DISCCogg=`lltag -S "$1" | grep -i disc\= | cut -d '=' -f 2 | sed '/^ /s/^ *//;s/ *$//g' | awk 'FNR == 1 {print}'`
DISCogg=`lltag -S "$1" | grep -i discnumber\= | cut -d '=' -f 2  | sed '/^ /s/^ *//;s/ *$//g' | awk 'FNR == 1 {print}'`
DISCTOTogg=`lltag -S "$1" | grep -i disctotal\= | cut -d '=' -f 2  | sed '/^ /s/^ *//;s/ *$//g' | awk 'FNR == 1 {print}'`
TEMPOogg=`lltag -S "$1" | grep -i tempo\= | cut -d '=' -f 2  | sed '/^ /s/^ *//;s/ *$//g' | awk 'FNR == 1 {print}'`
RATINGogg=`lltag -S "$1" | grep -i rating[\:\=] | cut -d '=' -f 2  | sed '/^ /s/^ *//;s/ *$//g' | awk 'FNR == 1 {print}'`
YEARogg=`lltag -S "$1" | grep -i year\= | cut -d '=' -f 2  | sed '/^ /s/^ *//;s/ *$//g' | awk 'FNR == 1 {print}'`

#########################################
#########################################
#########################################

case $ARTIST in
    Smith\ \&\ Mighty)
        id3v2 --TPE2 Smith\ \&\ Mighty --TCON Hip\ Hop\/\ Turntablism "$1"
        ;;
esac


case $ALBARTIST in
    Various\ Artists)
        echo \.\.\.übersprungen\!
        ;;
    *Verschiedene*|*[vV]arios\ [Ii]nterpret*|*[vV]arios\ [Aa]rtistas*|VA|Unbekannter\ Künstler|Unknown\ Artist)
        id3v2 --TPE2 Various\ Artists "$1" 
        vorbiscomment -w "$1" -t "ALBUMARTIST=$ALBARTISTogg" -t "ARTIST=$ARTogg" -t                  "TITLE=$TITLEogg" -t "NUMBER=$TRACKogg" -t "ALBUM=$ALBUMogg" -t "GENRE=$GENREogg" -t "YEAR=$YEARogg" -t "DISC=$DISCogg" -t "DISCTOTAL=$DISCTOTogg" -t "DISCC=$DISCCogg" -t "TEMPO=$TEMPOogg" -t "RATING=$RATINGogg" -t "DATE=$DATEogg" -t "COMPOSER=$COMPogg"
        echo $1\ \.\.\.\ wurde\ getaggt\! ;;
esac


case $ALBUM in
    # Punk & Ska
    Tiger\ goes\ Callypso)
    id3v2 --TPE2 Various\ Artists --TCON Punk\/\ Ska "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
*RudeboyStationRadio*)
    id3v2 --TALB RudeboyStationRadio --TPE2 Various\ Artists --TCON Punk\/\ Ska "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Punk\-O\-Rama\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists --TCON Punk\/\ Ska "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Hip Hop/ Turntablism
    WEFUNK\ Radio*|Hip\ Hop\ Classics*)
    id3v2 --TPE2 Various\ Artists --TCON Hip\ Hop\/\ Turntablism "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Old\ School\ Rap\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists --TCON Hip\ Hop\/\ Turntablism "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
*BeatBasement*|*Beatbasement*)
    id3v2 --TALB BeatBasement --TPE2 Various\ Artists --TCON Hip\ Hop\/\ Turntablism "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Mix\ Tape*)
    id3v2 --TPE2 Various\ Artists --TCON Hip\ Hop\/\ Turntablism "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
*60\ Minutes\ Of\ Funk)
    id3v2 --TPE2 Various\ Artists --TCON Hip\ Hop\/\ Turntablism "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Bravo\ Hip\ Hop\ Special\ History*)
    id3v2 --TPE2 Various\ Artists --TCON Hip\ Hop\/\ Turntablism "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Big Beat & Breakbeat
    Chemical\ Reaction)
    id3v2 --TPE2 Various\ Artists --TCON Big\ Beat\/\ Breakbeat "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Drum & Bass
    *Drum\ \&\ Bass*|*Drum\ \and\ Bass*|*Drum\'n\ Bass*|*Drum\'n\'Bass*|I\ Love\ Drum\ \&\ Bass*|VA*Drum*|*Jungle\ Hits*|*Jungle\ Massive*|*Junglized*|*Ultimate\ Jungle*)
    id3v2 --TPE2 Various\ Artists --TCON Drum\ \&\ Bass\/\ Jungle "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
BC\ Presents*)
    id3v2 --TPE2 Various\ Artists --TCON Drum\ \&\ Bass\/\ Jungle "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Masters.of.Hardcore*)
    id3v2 --TPE2 Various\ Artists --TCON Drum\ \&\ Bass\/\ Jungle "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
DNBJunkies\.com)
    id3v2 --TALB I\ Love\ Drum\ \&\ Bass\:\:\ Tracks --TPE2 Various\ Artists --TCON Drum\ \&\ Bass\/\ Jungle "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
This\ [i,I]s*Jungle*)
    id3v2 --TALB This\ is\ Jungle --TPE2 Various\ Artists --TCON Drum\ \&\ Bass\/\ Jungle "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Dungeonmaster*s\ Guide*)
    id3v2 --TPE2 Various\ Artists --TCON Drum\ \&\ Bass\/\ Jungle "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Contagious\ Drum\ \&\ Bass*)
    id3v2 --TPE2 Various\ Artists --TCON Drum\ \&\ Bass\/\ Jungle "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Kosheen\ Presents\ Drum\ \'n\'\ Bass\ Reborn)
    id3v2 --TPE2 Various\ Artists --TCON Drum\ \&\ Bass\/\ Jungle "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Music\ Box\ \-\ A\ New\ Era*Drum\ and\ Bass)
    id3v2 --TPE2 Various\ Artists --TCON Drum\ \&\ Bass\/\ Jungle "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Earth*Volume\ Two)
    id3v2 --TPE2 Various\ Artists --TCON Drum\ \&\ Bass\/\ Jungle "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Overdrive*Aphrodite)
    id3v2 --TPE2 Various\ Artists --TCON Drum\ \&\ Bass\/\ Jungle "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Storm\ From\ the\ East*)
    id3v2 --TPE2 Various\ Artists --TCON Drum\ \&\ Bass\/\ Jungle "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Rumble\ In\ The\ Jungle*)
    id3v2 --TPE2 Various\ Artists --TCON Drum\ \&\ Bass\/\ Jungle "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Technical\ Freaks*)
    id3v2 --TPE2 Various\ Artists --TCON Drum\ \&\ Bass\/\ Jungle "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Total\ Science\ Presents*)
    id3v2 --TPE2 Various\ Artists --TCON Drum\ \&\ Bass\/\ Jungle "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Metalheadz\ Presents*)
    id3v2 --TPE2 Various\ Artists --TCON Drum\ \&\ Bass\/\ Jungle "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Rock & Rock'n'Roll
    The\ Rock\ \'n\'\ Roll\ Hall*|The\ Rock\ \'n\'\ Roll\ Era|Rock\'n\'Roll*)
    id3v2 --TPE2 Various\ Artists --TCON 1950s\/\ Rock\ \&\ Roll "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Rock*)
    id3v2 --TPE2 Various\ Artists --TCON 1950s\/\ Rock\ \&\ Roll "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
50\'s\ One\ Hit\ Wonders)
    id3v2 --TPE2 Various\ Artists --TCON 1950s\/\ Rock\ \&\ Roll "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Elv1s)
    id3v2 --TPE2 Various\ Artists --TCON 1950s\/\ Rock\ \&\ Roll "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Folklore & Country
    *Now\ That\'s\ What\ I\ Call\ Country*|*Country\ Gold*|*Country\ Legends*|*Country\ \&\ Western\ Ballads*|*Country\ Love*)
    id3v2 --TPE2 Various\ Artists --TCON Country\/\ Folklore "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Aternative & Instrumental
    Classic\ Rock|Reservoir\ Rock*|Rockfile\,\ Volume*|Rock\ Times*|Schoolhouse\ Rock*|School\ of\ Rock|Modern\ Rock)
    id3v2 --TPE2 Various\ Artists --TCON Alternative\/\ Instrumental "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Les\ Enfants\ du\ rock)
    id3v2 --TPE2 Various\ Artists --TCON Alternative\/\ Instrumental "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Indie\,\ Volume\ [0-9]*)
    id3v2 --TPE2 Various\ Artists --TCON Alternative\/\ Instrumental "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
BECK\'SPERIENCE\ Music\ Collection)
    id3v2 --TPE2 Various\ Artists --TCON Alternative\/\ Instrumental "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Greatest\ Hits\ of\ Modern\ Rock*)
    id3v2 --TPE2 Various\ Artists --TCON Alternative\/\ Instrumental "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Les\ Inrockuptibles\ prisentent)
    id3v2 --TPE2 Various\ Artists --TCON Alternative\/\ Instrumental "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Best\ Prog\ Rock\ Album*the\ World\.\.\.\ Ever\!)
    id3v2 --TPE2 Various\ Artists --TCON Alternative\/\ Instrumental "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Sealed\ With\ a\ Kiss\ and\ Other\ Famous\ Rock\ \'n\'\ Roll\ Love\ Songs)
    id3v2 --TPE2 Various\ Artists --TCON Alternative\/\ Instrumental "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Rock\ Boat\ VIII)
    id3v2 --TPE2 Various\ Artists --TCON Alternative\/\ Instrumental "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Rock\ the\ First*)
    id3v2 --TPE2 Various\ Artists --TCON Alternative\/\ Instrumental "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Crossover & Metal
    Ultimate\ Metal*|*Greatest\ Metal\ Songs*)
    id3v2 --TPE2 Various\ Artists --TCON Crossover\/\ Metal "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Grunge\ Rock)
    id3v2 --TPE2 Various\ Artists --TCON Crossover\/\ Metal "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;


    # 1980s/ 90s
    Was\ het\ nu\ 70\ of\ 80*)
    id3v2 --TPE2 Various\ Artists --TCON 1980s\/\ 90s "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Bel\ 80)
    id3v2 --TPE2 Various\ Artists --TCON 1980s\/\ 90s "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Simply\ the\ Best\ of\ the\ 90\'s)
    id3v2 --TPE2 Various\ Artists --TCON 1980s\/\ 90s "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Totally\ 80\'s*)
    id3v2 --TPE2 Various\ Artists --TCON 1980s\/\ 90s "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # 1960s/ 70
    Sounds\ of\ the\ Seventies*)
    id3v2 --TPE2 Various\ Artists --TCON 1960s\/\ 70s "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Wildest\ \'75)
    id3v2 --TPE2 Various\ Artists --TCON 1960s\/\ 70s "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Summer\ [o,O]f\ Love*)
    id3v2 --TPE2 Various\ Artists --TCON 1960s\/\ 70s "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Disco\ Fever)
    id3v2 --TPE2 Various\ Artists --TCON 1960s\/\ 70s "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Easy\ 70\'s*)
    id3v2 --TPE2 Various\ Artists --TCON 1960s\/\ 70s --TALB Easy\ 70\'s "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
GoodNoise\ Compilations\ Number\ One\ Hits\ \(1970\-1974\))
    id3v2 --TPE2 Various\ Artists --TCON 1960s\/\ 70s --TALB Easy\ 70\'s "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Latin Ska & Rock en Español
    Rock\ [e,E]n\ Espa[ñ,q]ol)
    id3v2 --TALB Rock\ en\ Español --TPE2 Various\ Artists --TCON Latin\ Ska\/\ Rock\ En\ Español "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Trip Hop/ Downbeat
    *Trip\ Hop*|*Downbeat*|*Pure\ Lounge*|*Erotic\ Lounge*|*Wellness\ Lounge*|Buddha*|Asian\ Lounge*|Live\ [i]n\ the\ X\ Lounge\ IV|Club\ Night\ Lounge*|Taipei\ Lounge*|Ambient\ Lounge*|Sex\ Lounge*|Bar\ Lounge*)
    id3v2 --TPE2 Various\ Artists --TCON Trip\ Hop\/\ Downbeat "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Saint\-Germain\-des\-Prés*)
    id3v2 --TPE2 Various\ Artists --TCON Trip\ Hop\/\ Downbeat "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Big\ Chill)
    id3v2 --TPE2 Various\ Artists --TCON Trip\ Hop\/\ Downbeat "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Chillout\ Room\ 2)
    id3v2 --TPE2 Various\ Artists --TCON Trip\ Hop\/\ Downbeat "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
H*tel\ Cost[e,é]s*|*Best\ of\ Costes*)
    id3v2 --TALB Hôtel\ Costes --TPE2 Various\ Artists --TCON Trip\ Hop\/\ Downbeat "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
*Caf[ieé]\ [dD]el\ Mar*)
    id3v2 --TALB Café\ del\ Mar --TPE2 Various\ Artists --TCON Trip\ Hop\/\ Downbeat "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Café\ del\ Mar)
    id3v2 --TALB Café\ del\ Mar --TPE2 Various\ Artists --TCON Trip\ Hop\/\ Downbeat "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Ambient & Acoustic
    Relaxing\ Songs)
    id3v2 --TPE2 Various\ Artists --TCON Ambient\/\ Acoustic "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
True\ Acoustic)
    id3v2 --TPE2 Various\ Artists --TCON Ambient\/\ Acoustic "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Dance/ House
    Ministry\ of\ Sound*|Mastermix\ Pro\ Dance\ 08|Dancefloor*)
    id3v2 --TPE2 Various\ Artists --TCON Dance\/\ House "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
ParisOneDance)
    id3v2 --TALB ParisOneDance --TPE2 Various\ Artists --TCON Dance\/\ House "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Caf[e,é]\ Ibiza*)
    id3v2 --TALB Café\ Ibiza --TPE2 Various\ Artists --TCON Dance\/\ House "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Ibiza\ Grooves)
    id3v2 --TPE2 Various\ Artists --TCON Dance\/\ House "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Dance\ Classic*)
    id3v2 --TPE2 Various\ Artists --TCON Dance\/\ House "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Summer\ Dance\ \'98\ Disc\ 1)
    id3v2 --TPE2 Various\ Artists --TCON Dance\/\ House "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Nothing\ But\ the\ Beat)
    id3v2 --TPE2 Various\ Artists --TCON Dance\/\ House "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Future\ Sound\ of*)
    id3v2 --TPE2 Various\ Artists --TCON Dance\/\ House "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
As\ Heard\ *n\ Radio\ Soulwax*)
    id3v2 --TALB As\ Heard\ on\ Radio\ Soulwax --TPE2 Various\ Artists --TCON Dance\/\ House "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Pop/ Charts
    Pop*)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
977Music\.com|977|977Radio|DasDing|*non\-album\ tracks*)
    id3v2 --TALB 977Radio --TRCK "" --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Hits\ 2007)
    id3v2 --TALB 977Radio --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Pop\ Princesses\ 2009)
    id3v2 --TALB 977Radio --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
RTL*)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Pop\ Giganten*)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Your\ Hit\ Parade)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Soft\ Pop\ Collection\ [1-9])
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Kuschelrock*|Bravo\ Hits*|Absolute\ Rock\ Ballads\ Classics*)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Top\ of\ the\ Pops\ 1991)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
FIFA\ Street*)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Fetenhits*)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Pop\ Miscellanous)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Pop\ Giganten*)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Now\!)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Now\ That*s\ What\ I\ Call\ Music*)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Bravo\ Hits\ [0-9]*)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Brit\ Awards\ [0-9]*)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Hit\ Club\ \-\ Very\ Best\ 2000)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Soundtracks
    Pulp\ Fiction)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Talented\ Mr\.\ Ripley)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Shrek\ 2)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Scream\ 3)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Scrubs)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Mr\.\ \&\ Mrs\.\ Smith)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
*O\.S\.\T\.*)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Sister\ Act\ 2)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Notting\ Hill)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Trainspotting)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Desperado)
    id3v2 --TPE2 Various\ Artists --TCON Pop\/\ Charts "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Chico\ \&\ Rita*)
    id3v2 --TPE2 Chico\ \&\ Rita --TCON Salsa\/\ Cubana "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Dancehall & Soca
    Soca\ Fever|*Soca\ Village*|*Best\ Soca*|*Soca\ Hits*|*Soca\ Zone*)
    id3v2 --TPE2 Various\ Artists --TCON Dancehall\/\ Soca "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Pure\ Dancehall|PureDanceahll)
    id3v2 --TALB PureDancehall --TPE2 Various\ Artists --TCON Dancehall\/\ Soca "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Ragga*the\ Jungle|Ragga\ Jungle\ Anthems\ Vol\.\ One|Ragga\ Ragga\ Ragga*)
    id3v2 --TPE2 Various\ Artists --TCON Dancehall\/\ Soca "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Reggae\ Gold\ [1-2]*)
    id3v2 --TPE2 Various\ Artists --TCON Dancehall\/\ Soca "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
What\ da\ Flavor*)
    id3v2 --TPE2 Various\ Artists --TCON Dancehall\/\ Soca --TALB What\ da\ Flavor "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Hot\,\ Hot\ Reggae\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists --TCON Dancehall\/\ Soca "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Reggae & Dub
    Best\ Reggae|Reggae\ Vibrations*|Smoke\ the\ Herb)
    id3v2 --TPE2 Various\ Artists --TCON Reggae\/\ Dub "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Various\ Artists\ -\ Ragga\ Vibes\ Volume\ Two*)
    id3v2 --TPE2 Various\ Artists --TCON Reggae\/\ Dub "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Egg\ Files)
    id3v2 --TPE2 Various\ Artists --TCON Reggae\/\ Dub "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Reggaeton & Latin Reggae
    *Reggaeton\ Hits*|*Reggaeton\ 200*|*Pepazos\ del\ Reggaeton*|*Reggaeton\ Extremo*|Corazón)
    id3v2 --TPE2 Various\ Artists --TCON Reggaeton\/\ Latin\ Reggae "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Latino\ Del\ Futuro)
    id3v2 --TPE2 Various\ Artists --TCON Reggaeton\/\ Latin\ Reggae "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Reggae\ [e,E]n\ Español)
    id3v2 --TALB Reggae\ en\ Español --TPE2 Various\ Artists --TCON Reggaeton\/\ Latin\ Reggae "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Merengue & Bachata
    *Merengueando*|*Merenguehits*)
    id3v2 --TPE2 Various\ Artists --TCON Merengue\/\ Bachata "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Www.BachataBlog.com)
    id3v2 --TPE2 Various\ Artists --TCON Merengue\/\ Bachata "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Banda & Norteña
    Pura\ Banda)
    id3v2 --TPE2 Various\ Artists --TCON Banda\/\ Ranchera "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Chilenas & Cumbia
    El\ Rey\ de\ la\ Cumbia)
    id3v2 --TPE2 Various\ Artists --TCON Cumbias\/\ Chilenas "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Las\ Mejores\ Chilenas)
    id3v2 --TPE2 Various\ Artists --TCON Cumbias\/\ Chilenas "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Los\ Clásicos\ de\ la\ Cumbia)
    id3v2 --TPE2 Various\ Artists --TCON Cumbias\/\ Chilenas "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Social\ Music\ Experience)
    id3v2 --TPE2 Various\ Artists --TCON Cumbias\/\ Chilenas "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Cumbias\ Perronas)
    id3v2 --TPE2 Various\ Artists --TCON Cumbias\/\ Chilenas "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Al\ calor\ de\ la\ Cumbia*)
    id3v2 --TPE2 Various\ Artists --TCON Cumbias\/\ Chilenas "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Cubano & Salsa
    Salsas\ Best\!)
    id3v2 --TALB Salsa\ \-\ 100\%\ de\ Acetate --TPE2 Various\ Artists --TCON Salsa\/\ Cubana "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
NRC\ \-\ Salsa\ Picante\ \-\ Original\ Cuban\ Song)
    id3v2 --TPE2 Various\ Artists --TCON Salsa\/\ Cubana "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Salsa\ \-\ 100\%\ de\ Acetate*)
    id3v2 --TPE2 Various\ Artists --TCON Salsa\/\ Cubana "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Bomba\ del\ Chota)
    id3v2 --TPE2 Various\ Artists --TCON Salsa\/\ Cubana "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Le\ Son\ Latino*)
    id3v2 --TPE2 Various\ Artists --TCON Salsa\/\ Cubana "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
La\ Salsa\ de\ Cuba*)
    id3v2 --TPE2 Various\ Artists --TCON Salsa\/\ Cubana "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Café\ Cubana*)
    id3v2 --TPE2 Various\ Artists --TCON Salsa\/\ Cubana "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Trance & Techno
    Rave|*Days\ of\ Techno*)
    id3v2 --TPE2 Various\ Artists --TCON Minimal\/\ Techno "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
*Soundz\ of\ the\ Asian\ Underground*)
    id3v2 --TPE2 Various\ Artists --TCON Minimal\/\ Techno "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ World\ of\ Progressive\ Trance)
    id3v2 --TPE2 Various\ Artists --TCON Minimal\/\ Techno "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Top\ 100\ Trance\ and\ Techno\ Party\ Songs\ of\ All\ Time*)
    id3v2 --TPE2 Various\ Artists --TCON Minimal\/\ Techno "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;


    # Northern Soul
    *Complete\ Motown\ Singles*|*Motown\ Legends*|*Motown\ Undercover*)
    id3v2 --TPE2 Various\ Artists --TCON Motown\/\ Northern\ Soul "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Best\ Northern\ Soul*)
    id3v2 --TPE2 Various\ Artists --TCON Motown\/\ Northern\ Soul "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Soul\ Survivors*)
    id3v2 --TPE2 Various\ Artists --TCON Motown\/\ Northern\ Soul "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Northern\ Soul\ Remix)
    id3v2 --TPE2 Various\ Artists --TCON Motown\/\ Northern\ Soul "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Modern\ Soul\ Connoisseurs)
    id3v2 --TPE2 Various\ Artists --TCON Motown\/\ Northern\ Soul "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # R&B
    Ultimate\ R\&B)
    id3v2 --TPE2 Various\ Artists --TCON Soul\/\ RnB "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
A\ Rhythm\ \&\ Blues\ Christmas\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists --TCON Soul\/\ RnB "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Bossanova & Electrotango
    Cidade\ de\ Deus)
    id3v2 --TPE2 Various\ Artists --TCON Bossanova\/\ Electrotango "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Caipilation)
    id3v2 --TPE2 Various\ Artists --TCON Bossanova\/\ Electrotango "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Radio\ Cidade)
    id3v2 --TALB BossaClub--TPE2 Various\ Artists --TCON Bossanova\/\ Electrotango "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Acid Jazz & Funk
    Ultimate\ Funk)
    id3v2 --TPE2 Various\ Artists --TCON Acid\ Jazz\/\ Funk "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Funk\ Yourself\ 2)
    id3v2 --TPE2 Various\ Artists --TCON Acid\ Jazz\/\ Funk "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Best\ Smooth\ Jazz\.\.\.Ever\!*)
    id3v2 --TPE2 Various\ Artists --TCON Acid\ Jazz\/\ Funk "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Mojo\ Club\ Presents\ Dancefloor\ Jazz*)
    id3v2 --TPE2 Various\ Artists --TCON Acid\ Jazz\/\ Funk "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # Jazz
    Finest\ Jazz|Smooth\ Jazz*|Jazz\ Styles|Jazz*the\ City*|Smooth\ \&\ Jazzy*|Smooth\ Jazz*)
    id3v2 --TPE2 Various\ Artists --TCON Jazz\/\ Big\ Band "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Chillout\ on\ Blue\ Note)
    id3v2 --TPE2 Various\ Artists --TCON Jazz\/\ Big\ Band "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Cameo\ Parkway\ 1957\-1967)
    id3v2 --TPE2 Various\ Artists --TCON Jazz\/\ Big\ Band "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Blue\ Note\ Trip\*)
    id3v2 --TPE2 Various\ Artists --TCON Jazz\/\ Big\ Band "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Blues\ Brother\ Soul\ Sister\ Classics)
    id3v2 --TPE2 Various\ Artists --TCON Acid\ Jazz\/\ Funk "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Best\ Jazz\ Is\ Played\ With\ Verve)
    id3v2 --TPE2 Various\ Artists --TCON Jazz\/\ Big\ Band "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ No\.\ 1\ Jazz\ Album)
    id3v2 --TPE2 Various\ Artists --TCON Jazz\/\ Big\ Band "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Smithsonian\ Collection\ of\ Classic\ Jazz\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists --TCON Jazz\/\ Big\ Band "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Jazz\ Lullabies)
    id3v2 --TPE2 Various\ Artists --TCON Jazz\/\ Big\ Band "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Jazz\ of\ the\ 1930s)
    id3v2 --TPE2 Various\ Artists --TCON Jazz\/\ Big\ Band "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Ken\ Burns\ Jazz)
    id3v2 --TPE2 Various\ Artists --TCON Jazz\/\ Big\ Band "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Jugend\ jazzt)
    id3v2 --TPE2 Various\ Artists --TCON Jazz\/\ Big\ Band "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Blue\ Note)
    id3v2 --TPE2 Various\ Artists --TCON Jazz\/\ Big\ Band "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Classic\ Jazz\-Funk\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists --TCON Jazz\/\ Big\ Band "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;


    # Artists
    The\ Very\ Best\ of\ Sting\ \&\ The\ Police)
    id3v2 --TPE2 Sting\ \&\ The\ Police "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Best\ of\ Marvin\ Gaye*)
    id3v2 --TALB The\ Best\ of\ Marvin\ Gaye --TPE2 Marvin\ Gaye  "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ inofficial\ SAMY\ DELUXE*)
    id3v2 --TPE2 Samy\ Deluxe "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # World / Sonstiges
    Aswan\ Dances)
    id3v2 --TALB Aswan\ Dances --TCON World\/\ Sonsties ;;
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;

    # NoGenre
    Unbekannt*)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
JPN\ to\ Worldwide*)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Us\ Against\ the\ World)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Ultimate*)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
De\ Afrekening*)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Fabric*)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
100\ Op\ 1)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
100\ Vlaamse\ Klassiekers)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
12\ Discipulos)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
20\ Years\ on\ MTV)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
25\ Christmas\ Favorites)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
75\ Love\ Songs)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Absolute\ Music\ 36)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Ahora\ \'02)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
All\ That\ Alternative)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Alternative\ Moments)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Another\ Steps)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
As\ 100\ Mais\ Da\ Antena\ 1\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Awesome\ Hits)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
A\ Wicked\ Good\ Sampler\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Baseball)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Bel\ 2000)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Bel\ 90)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Best\ of\ MTV\ Lounge)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Big\ Day\ Out\ 00)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Billboard\ Top\ Hits)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Body\ Talk\ \-\ Moonlit\ Nights)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Booom\ 2004)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Breakthru\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Brit\ Awards\ 97)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Burnout)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Can\'t\ Beat\ the\ Music\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Can\ You\ Dig\ It\?\ The\ \'70s\ Soul\ Experience)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Classical\ Love)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
CMJ\ New\ Music\ Monthly\,\ Volume\ [0-9]9)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Codeine\ Hitz\ 10)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Colin\ McRae\ Dirt\ 2\ OST)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Cool\ Tributes)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Cry\-Baby)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Darla\ 100)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
De\ komplete\ kleinkunstkollektie\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
De\ Pre\ Historie*)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Der\ Eisbdr)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
\'DET\ Live\!\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Disney\'s\ Hit\ Singles\ \&\ More)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
DJ\ Touchi)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Dureco\ Wolkenserie\,\ Volume\ [0-9]*)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Ein\ Abend*Wien)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
El\ Mejor\ Album\ De\ Mzsica\ De\ Anuncios\ TV\,\ Volumen\ 4)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Fame\ Academy)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Feber)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Fetenhits)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Forces\ of\ Nature)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Freezone\ 5*)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Gone\ Surfin\')
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Grammy\ Nominees\ 2001)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Grand\ Slang)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Grrrl\ Power)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Heartbeat)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Hitzone)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Hollandse\ Hittroeven)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
H*rsturz\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Independent\ Woman)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Industrial\ Madness)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
In\ Search\ of\ Angels)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Introduced\ 100)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Junior\ Boy\'s\ Own\ Collection)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Lady\ Sings\ the\ Blues\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Lazy\ Afternoon)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Les\ 1000\ Merveilles\ de\ l\'univers)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Les\ tubes\ en\ or)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Lock\,\ Stock)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Long\ Time\ Gone)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Lost*Space\ \-\ Phase\ 2\ \(CD\ 1\))
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Maynard\'s\ Rewind\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Meedeiners\ Volume\ \#07)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Mercury\ Music\ Prize\ Compilation\ 2001)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Midnight*the\ Garden\ of\ Good\ and\ Evil)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Monk\'s\ Dream)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Mooi\ Kerstfeest*)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Move\ to\ Groove)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
MTV\'s\ the\ Real\ World)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Musical\!\ \-\ Die\ Show\,\ Volume\ [0-9]1)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
My\ Blueberry\ Nights)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
OmniOmno)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Over\ the\ Rainbow)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Ovum\ Sampler)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
O\'Zone)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Paquete\ Radioactivo)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Planet\ V)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Plastic\ Compilation\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Polyvox\ Populi\ 2)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Prime)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Produced\ by\ Trevor\ Horn)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Promo\ Only)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Radio\ Disney\ Kid\ Jams)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Return\ of\ the\ Read\ Menace)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
REV\ 105\ Radio\ Archive\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
RTL\ Winter\ Dreams\ 2007)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Ruby\ Trax)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
SATURN)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
S*ddeutsche\ Zeitung\ |*Diskothek)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Sex\ and\ Soul)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Sexy\ Swing\!)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Small\ Selection\ of\ Wicked\ Wax)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Some\ Live\ Songs\ EP)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Soulful\ Christmas)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Sounds\ 27)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Space\ Night\ Vol\.\ VII\ \-\ Perry\ Rhodan\ 40th\ Anniversary\ \(the\ landing\))
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Spotlight\ Red\ Mix)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Stones\ Throw\ Records\ 2003\ Sampler)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
SVA\ Live\ 2003)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Teen\ Spirit)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Best\.\.\.\ And\ Friends\ Album*the\ World\.\.\.\ Ever\!)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Best\ Covers\ of\ All\ Time)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Braun\ MTV\ Eurochart\ \'08\,\ Volume\ [0-9]2)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Braun\ MTV\ Eurochart\ \'99\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Compact\ 2\ Tone\ Story)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Essential\ Acoustic\ Album)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Mod\ Squad)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Paul\ Gambaccini\ Collection)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Sweet\ Sounds\ of\ Superfly\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Transporter)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Wire\ Tapper\ 4)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ World\'s\ Absolute\ Best\ Ever\ Beer\ Songs)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
This\ Ain\'t\ No\ Sippin\'\ Tea)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Thrill\ Jockey\ Summer\ Rarities\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Thunderbolt)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Tijdloze\ honderd\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Too\ Rockin\'\ for\ One\ Hand)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Trackspotting)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Triple\ J)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Tuff\ Tracks)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Unheard\ Pleasures)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Urban\ Outfitters)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Versatility\ Compilation)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
VH1\ Divas\ Live)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Vlaanderen\ klinkt\ \(Radio\ 1\))
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
World\ Cup\ of\ Hockey\ 2004)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
100\%\ Belpop)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
100\%\ Bittersweet\ Melodies)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
2\ Meter\ Sessies\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
A\ Brokedown\ Melody)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Absolute)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Absolute\ Love)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Absolute\ Music\ 43)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Afrika\ Bambaataa\ Presents\ Eastside)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Alien\ Nation*)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
A\ Life\ Less\ Ordinary)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
All\ Woman\ 3)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Alternative\ Times\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Amazing\ Grace)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
American\ Graffiti)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
An\ Evening\ With\ Frank\ Zappa\ and\ Captain\ Beefheart)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
A\ Rush\ of\ B\-Sides\ to\ Your\ Head)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Bamboozled)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Beauty\ of\ the\ Blues)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Beneath\ the\ Surface\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Beneath\ the\ Surface\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Best\ of\ World\ Music\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Big\ Star\ Small\ World)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Billie\,\ Ella\,\ Lena\,\ Sarah)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Blaxploitation\,\ Volume\ [0-9]*)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Body\ Rapture)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Breakfast\ Club\ London)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Cafi\ d\'Afrique)
    id3v2 --TPE2 Various\ Artists --TALB Café\ d\'Afrique "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Chick\ Corea\,\ Herbie\ Hancock\,\ Keith\ Jarrett\,\ McCoy\ Tyner)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Chosen\ Few)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Christmas\ Classics)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Cities\ 97\ Sampler*)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
City\ Folk\ Live\ 8)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Closer)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
CMJ\ New\ Music\ Monthly\,\ Volume\ [0-9]2)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Cool\ 3)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Daytrippers)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Defected\ Presents\ Charles\ Webster*)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Der\ Fischer\ und\ seine\ Frau)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Desperate\ Housewives)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Diamonds)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Dr\.\ Demento\ 20th\ Anniversary\ Collection)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Drive\ On)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Dureco\ Wolkenserie\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Elizabethtown)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
ERG\ Nu\ Music\ Traxx\,\ Volume\ [0-9]67)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Essential\ Soundtracks)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Eternal\ Sunshine\ of\ the\ Spotless\ Mind)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Felicity)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
FM4\ Soundselection)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Formula\ 45)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Frosh\ Two)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Ghostly\ Swim)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Girls\ Night\ Out\ 2)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Gone*60\ Seconds)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Great\ Balls\ of\ Fire\!)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Greatest\ Hits\ of\ the\ Millennium)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Grolsch\ Music)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Guitar\ Legends)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Guns\ of\ Brixton\ /\ Interior\ of\ a\ Dutch\ House)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Happy\ Holidays)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Hard\ to\ Find\ Jukebox\ Classics\ 1957)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Hello\ Vinyl)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Help)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
    Henry\ Poole\ Is\ Here\ \(Original\ Motion\ Picture\ Soundtrack)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Homebake\ 06)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Humo\'s\ Top\ 2002)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Hurricane\ Relief)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
I\'m\ Not\ There)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Infinity\ \-\ Season\ One)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Into\ the\ Blue)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Irving\ Berlin\ Always)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Jumping\ at\ Shadows)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Juno\ Awards\ 2007)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Just\ Like\ Heaven)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
KISA\,\ Volume\ [0-9]*)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Kiss\ Smooth\ Grooves\ 2001)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Ladies\ \&\ Gentlemen)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Lady\ Sings\ the\ Blues)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Lazy\ Sunday\ 2)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Leave\ Them\ All\ Behind\ III)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Les\ Inrockuptibles\ prisentent)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Les\ Plus\ Beaux\ Duos)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Let\ It\ Grow)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Look\ at\ All\ the\ Love\ We\ Found)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Los\ Nzmero\ Uno\ 40)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Lost\ Highway)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Love\ Actually)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Love\ Jones)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
    Love\ Making\ Compilation\ \(disc\ 3)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
LSTN\ \#5)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Martin\ Scorsese\ Presents\ the\ Blues)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Mastercuts\ Early\ Hours)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Mastermix\ Classic\ Cuts\ 35)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Maximum\ Bass\ 2)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Mr\.\ Loverman)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Munich\ City\ Nights\,\ Volume\ [0-9]1)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Music\ Box\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Muziek\ 10\ Daagse\ De\ Platina\ Editie)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Muzik)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
My\ Guardian\ Angel)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Nationwide\ Mercury\ Prize)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
New\ Pepsi\ Chart\ Album\ 3)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
New\ Wave\ Home\ Entertainment)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Night\ and\ Day)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
NME\ Awards\ 2004)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
No\ Prima\ Donna)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Nothing\ But\ the\ Blues)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
O\ Beijo\ *\ Vampiro\ Internacional)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Old\ Daddy\ Classics)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Oldies\ but\ Goodies\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Old\ School)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Old\ School\ Love\ Songs)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
One\ Lord\,\ One\ Faith\,\ One\ Baptism)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Party\ Power\ Pack\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Paste\ Magazine\ Sampler\ \#44)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Platin)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
POP\ MIX)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Prinzip\ Freude\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Pure\ Urban\ Divas)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Q)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Radio\ 538\ Hitzone\ 42)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Radio\ June\ 2007)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Rattle\ and\ Hum)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Readers\ Digest)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Remember\ Then)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Remixes\ and\ Rarities)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Remixes\ Compilation)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Retrospective)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Richard\ Blade\'s\ Flashback\ Favorites\,\ Volume\ [0-9])
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Road\ Trip)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Rolling\ Stone)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Sea\ of\ Love)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Secretary)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Serendipity)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
She\'s\ the\ Man)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Shut\ Up\ and\ Listen)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Singing\ Songs\ of\ the\ Southlands)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Slide\ Guitar)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Sliding\ Doors)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Smallville\ Enhanced\ Soundtrack)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Songbird\ 2008)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Sonically\ Speaking\,\ Volume\ [0-9]5)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Southern\ Nights*)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Spider\-Man\ 3)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
SPIN\ Find\ \'em\ First\ Edition)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Strictly\ Bass\ Three)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Studio\ Brussel)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Sunset\ and\ Sunrise\ 6)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Surf\ Sessions)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Sweet\ \&\ Pungent\ Dreamworks\ Sampler)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Swingtime\ II)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ American\ Diner)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Anthems\ 09)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Aviator)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Best\ of\ Lou\ Reed\ \&\ The\ Velvet\ Underground)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Chronicles\ of\ Narnia)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Dome\,\ Volume\ [0-9]8)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Last\ Kiss)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Longest\ Yard)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Other\ Side)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Prisoner)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Very\ Best\ Of\.\.\.)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
The\ Vintage\ Blues\ Box)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Thicker\ Than\ Water)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
TM\ Century)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Top\ of\ the\ Spot)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Torch\ Songs)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Toxic\ Traxx)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Triple\ J\ Hottest\ 100\ Volume\ [0-9]3)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Tropicalize)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Tyler\ Perry\'s\ Diary\ of\ a\ Mad\ Black\ Woman)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Uncut)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Undercover\ I)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Unforgettable\ Love\ Songs)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Upper\ Class\ Recordings\ Sampler)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Vox)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Waiting\ for\ the\ Weekend)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Waiting\ to\ Exhale)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Wanted\ Man)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Weekend\ Sessions)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Wetten\ Dass\.\.\.\?\ It\'s\ Christmas)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
What\ a\ Wonderful\ World)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Woman\ the\ Collection)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Woman\ V)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Women\ \&\ Songs\ 5)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Wonnemeyer)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Word\ of\ Mouth\ 7)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
XFM\ The\ Debut\ Sessions)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
Love\ Making\ Compilation*)
    id3v2 --TPE2 Various\ Artists "$1"
    echo $1\ \.\.\.\ wurde\ getaggt\! ;;
    esac
