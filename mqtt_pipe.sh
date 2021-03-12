#!/bin/bash
# ConnectMyPlace.com 12th MArch 2021
# MQTT broker data is piped to this script.
# if a topic containing the word SENSOR is detected then the topic id and data are displayed

while read data && [ "$data" != "" ]
do

if [[ $data == *"SENSOR"* ]]; then
	IN=$data
	arrIN=(${IN//;/ })
	id=$(echo ${arrIN[0]})                 
	an_data=$(echo  ${arrIN[1]} | jq --unbuffered '"\(.Time) \(.ANALOG.A0)"')
	echo "$id $an_data"

fi


done

