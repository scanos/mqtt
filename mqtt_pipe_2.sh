#!/bin/bash
# ConnectMyPlace.com 12th March 2021
# All Witty Cloud MQTT client LDR values are monitored and if dark detected(<200) light switched on 
# MQTT broker data is piped to this script. 
# if a topic containing the word SENSOR is detected then the topic id and data are displayed
# furthermore, if LDR value, ie darkness detected(<200) then device light is switched on
broker_ip="192.168.1.248"
lower_target=200
while read data && [ "$data" != "" ]
do

if [[ $data == *"SENSOR"* ]]; then
	IN=$data
	arrIN=(${IN//;/ })
	id=$(echo ${arrIN[0]})                 
	an_data=$(echo  ${arrIN[1]} | jq --unbuffered '"\(.Time) \(.ANALOG.A0)"')
	echo "$id $an_data"

        ldr_data=$(echo  ${arrIN[1]} | jq --unbuffered '"\(.ANALOG.A0)"')
        ldr_data=(${ldr_data//\"/})
        echo "$id ldr ??${ldr_data}??"

	if [ "$ldr_data" -lt "$lower_target" ]; then
		#convert the tele topic id to a command(cmnd) topic id to permit all wittys to be switched on 
		cmnd_id=(${id//tele/cmnd})
		cmnd_id=(${cmnd_id//SENSOR/POWER})
        	#convert the tele topic id to a command(cmnd) topic id to permit all wittys to be switched on
		#use the converted topic to switch on all wittys 
		mosquitto_pub -h ${broker_ip} -t ${cmnd_id} -m on  -u test -P test
	fi
fi

done

