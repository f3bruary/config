#!/bin/bash

# Created by f3bruary
# You need underscore-cli (https://github.com/ddopson/underscore-cli)

apikey=''   # The API key
ip='192.168.1.X'                          # The IP Address of the Sonarr instance
port='5050'                                 # The port (duh)

# The api request
json="$(curl -k -s 'http://'$ip':'$port'/api/'$apikey'/movie.list?status=active')" 

# No comment on the ugly code below
IFS=$'\n'
title=( $(echo $json | underscore select .title --outfmt dense | sed -e 's/\["//g' -e 's/"\]//g' -e 's/","/\n/g') )
date=( $(echo $json | underscore select .release_date --outfmt text | cut -d ':' -f 2 | cut -d ',' -f 1) )
date2=( $(for i in ${date[@]}; do date -d @$i +%b\ %d\ %Y; done) )
# I know right ?

# Loop through arrays
for ((i=0;i<${#title[@]};++i)); do
    echo -e "${title[i]}" "-" "${date2[i]}" | sed -e '/Jan 01 1970$/d'
done
