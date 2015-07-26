#!/bin/bash

ip="192.168.1.200"
port=9091

session=`curl -i -s -k -X 'POST' --data-binary $'{\"method\":\"session-stats\",\"tag\":12345}' 'http://'$ip':'$port'/transmission/rpc' | sed -n 3p | cut -d ' ' -f 2`
session_id=`tr -dc '[[:print:]]' <<< $session`
var1=`curl -s -k -X 'POST' -H 'X-Transmission-Session-Id: '$session_id --data-binary $'{\"method\":\"session-stats\",\"tag\":12345}' 'http://'$ip':'$port'/transmission/rpc' | underscore pluck downloadSpeed --outfmt text`

#Following variable must be set like so:
#Example: If your max download speed is 150mbit/s, do 100/(150/8*1000000)

max=0.00000533333

if [[ -z $var1 ]]
  then
      var1=0
fi


percentage=`echo $max' * '$var1 | bc -s`
bytes=`numfmt --to=iec --suffix=B $var1`

if [[ $1 == 'perc' ]]
  then
      echo $percentage
  else
      echo $bytes
fi
