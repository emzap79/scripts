#!/bin/bash
#
opera http://www.imdb.com/find?q=$1&s=all #IMDataBase
opera http://movfilm.net/search/?q=$1&sfSbm=Suchen #MovFilm.net
opera http://search.ovguide.com/?ci=424&q=$1 #OVGuide
opera http://www.moviesdatacenter.com/search.php?query=$1&channel=all-channels #MoviesDataCenter
opera http://www.tv-links.eu/_search/?s=$1 #TV-Links.eu
opera http://onlinecliptv.com/list?term=$1&commit=suche #OnlineclipTV.com
#curl -F "search=$1" -A http://www.movie2k.to/movies.php?list=search=$1 #Movie2k.to
exit 0
