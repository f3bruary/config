#!/bin/bash

ip="192.168.1.200"
port=9091
session=`curl -s -k  -X 'POST' -H 'Content-Type: text/plain; charset=UTF-8' -H 'User-Agent: Transdroid Torrent Connect' --data-binary \$'{\"tag\":0,\"method\":\"session-get\",\"arguments\":{}}' 'http://'$ip':'$port'/transmission/rpc' | html2text | grep '\`X-Transmission-Session-Id:' | cut -d ' ' -f 2 | sed 's/\`//g'`
var1=`curl -s -k  -X 'POST' -H 'X-Transmission-Session-Id: '$session'' -H 'Content-Type: text/plain; charset=UTF-8' -H 'User-Agent: Transdroid Torrent Connect' --data-binary $'{\"tag\":0,\"method\":\"torrent-get\",\"arguments\":{\"fields\":[\"id\",\"name\",\"error\",\"errorString\",\"status\",\"downloadDir\",\"rateDownload\",\"rateUpload\",\"peersGettingFromUs\",\"peersSendingToUs\",\"peersConnected\",\"eta\",\"haveUnchecked\",\"haveValid\",\"uploadedEver\",\"sizeWhenDone\",\"addedDate\",\"doneDate\",\"desiredAvailable\",\"comment\"]}}' 'http://'$ip':'$port'/transmission/rpc' | python -mjson.tool | grep 'rateDownload' | sed -e 's/"rateDownload": //g' -e 's/,//g' -e 's/                //g'`

#Following variable must be set like so:
#Example: If your max download speed is 150mbit/s, do 100/(150/8*1000000)

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
