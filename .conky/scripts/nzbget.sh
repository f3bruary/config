#!/bin/bash

ip="192.168.1.200"
port=6789
var1=`curl -i -s -k  -X 'POST' -H 'Content-Type: text/xml' -H 'Authorization: Basic Og==' --data-binary $'<?xml version=\'1.0\' ?><methodCall><methodName>status</methodName></methodCall>' 'http://'$ip':'$port'/xmlrpc' | grep '<name>DownloadRate' | sed -e 's/<[^>]\+>//g' -e 's/DownloadRate//g'`

#Following variable must be set like so:
#Example: If your max speed is 150 mbit/s, do 100/(150/8*1000000)

max=0.00000533333

if [ -z $var1 ]
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
