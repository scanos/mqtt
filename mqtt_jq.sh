#!/bin/bash
# ConnectMyPlace.com 12th March 2021
# All Witty Cloud MQTT client LDR values are monitored and if dark detected(<200) light switched on 
# MQTT broker data is piped to this script. 
# if a topic containing the word SENSOR is detected then the topic id and data are displayed
# furthermore, if LDR value, ie darkness detected(<200) then device light is switched on
# run using mosquitto_sub -h localhost -p 1883 -v -t '#' -u test -P test | ./mqtt_jq.sh

broker_ip="192.168.8.111"
#lower_target=200
while read data && [ "$data" != "" ]
do

#if [[ $data == *"SENSOR"* ]]; then
	IN=$data
        #echo $data
	arrIN=(${IN//;/ })
	id=$(echo ${arrIN[0]})
        if [[ $IN == *"Temperature"* ]]; then

		an_data=$(echo  ${arrIN[1]} | jq --unbuffered '"\(.Time)"')
       		DS1_data_temp=$(echo  ${arrIN[1]} | jq --unbuffered '"\(.DS18B20.Temperature)"')
                AM2301_data_temp=$(echo  ${arrIN[1]} | jq --unbuffered '"\(.AM2301.Temperature)"')
                AM2301_data_humidity=$(echo  ${arrIN[1]} | jq --unbuffered '"\(.AM2301.Humidity)"')

	echo "$id $an_data $DS1_data_temp $AM2301_data_temp $AM2301_data_humidity"
#tele/tasmota_4C7759/SENSOR "2021-04-26T10:36:34" "16.2" "null" "null"
mqtt_cmd=${id/tele/cmnd}
mqtt_cmd=${mqtt_cmd/SENSOR/DeepsleepTime}
echo $mqtt_cmd

echo "$id $an_data $DS1_data_temp $AM2301_data_temp $AM2301_data_humidity" >>  deepsleep.log
mosquitto_pub -t "${mqtt_cmd}" -r -m "3600"  -u test -P test



        #echo "$id,$date1,$an_data" >>  deepsleep.log
        #echo "inside $date1 $id $an_data"
        #mosquitto_pub -t "cmnd/tasmota_4C5AA3/DeepsleepTime" -r -n  -u test -P test
        #sleep 30
        #echo "going to sleep" >> ${1}deepsleep.log
        #3600 = 1 hour
        #mosquitto_pub -t "cmnd/${tasmotav}/DeepsleepTime" -r -m "3600"  -u test -P test
        #100 = 100 seconds
        #sleep  3600
        #mosquitto_pub -t "cmnd/${tasmotav}/DeepsleepTime" -r -m "0"  -u test -P test
        #sleep 60
        #mosquitto_pub -t "cmnd/${tasmotav}/DeepsleepTime" -r -n  -u test -P test




     fi 
        #ldr_data=$(echo  ${arrIN[1]} | jq --unbuffered '"\(.ANALOG.A0)"')
        #ldr_data=(${ldr_data//\"/})
        #echo "$id ldr ??${ldr_data}??"

	#if [ "$ldr_data" -lt "$lower_target" ]; then
		#convert the tele topic id to a command(cmnd) topic id to permit all wittys to be switched on 
		#cmnd_id=(${id//tele/cmnd})
		#cmnd_id=(${cmnd_id//SENSOR/POWER})
        	#convert the tele topic id to a command(cmnd) topic id to permit all wittys to be switched on
		#use the converted topic to switch on all wittys 
		#mosquitto_pub -h ${broker_ip} -t ${cmnd_id} -m on  -u test -P test
	#fi
#fi

done

