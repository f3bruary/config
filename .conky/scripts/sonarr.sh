#!/bin/bash

# Created by f3bruary
# You need underscore-cli (https://github.com/ddopson/underscore-cli)

today=`date "+%Y-%m-%d"`
next=`date "+%Y-%m-%d" -d "+6 days"` # Increase +6 if you want to look further into the future !
apikey=''   # The API key
ip=''       # The IP Address of the Sonarr instance
port=''     # The port (duh)

# The api request
json="$(curl -s -k -X 'GET' -H 'Authorization: Basic Og==' -H 'X-Api-Key: '$apikey'' 'http://'$ip':'$port'/api/calendar?start='$today'&end='$next'')"

# No comment on the ugly code below
IFS=$'\n'
title=( $(echo $json | underscore pluck series | underscore select .title --outfmt dense | sed -e 's/\["//g' -e 's/"\]//g' -e 's/","/\n/g') )
date=( $(echo $json | underscore select .airDateUtc --outfmt dense | sed -e 's/\["//g' -e 's/"\]//g' -e 's/","/\n/g') )
date2=( $(for i in ${date[@]}; do date -d $i +%b\ %d; done) )
# I know right ?

# Putting it in arrays so we can iterate
for ((i=0;i<${#title[@]};++i)); do
    printf "%s\${alignr}%s\n" "${title[i]}" "${date2[i]}"
done
