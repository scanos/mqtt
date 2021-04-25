#!/bin/bash
# mqtt_pipe_deepsleeptst.sh MQTT broker data is piped to this script which logs temperature and goes deepsleep
# if a topic containing the word SENSOR is detected then the topic id and data are displayed
# mosquitto_sub -h localhost -p 1883 -v -t '#' -u test -P test | ./mqtt_pipe_deepsleeptst.sh
while read data && [ "$data" != "" ]
do
tasmotav="tasmota_"$1
echo tasmotav $tasmotav
echo  dollar 1 $1
echo data $data
if [[ $data == *"$1"* ]]; then
        IN=$data
        #arrIN=(${IN//;/ })
        echo INSIDE $IN
        #id=$(echo ${arrIN[0]})
        #an_data=$(echo  ${arrIN[1]} | jq --unbuffered '"\(.Time) \(.DS18B20)"')
        #an_data=$(echo  ${arrIN[1]} | jq --unbuffered '"\(.DS18B20)"')


        #if [[ $an_data == *"DS18B20"* ]]; then
        if [[ $IN == *"Temperature"* ]]; then
        date1=$(date)
       echo $date1 $IN
       echo "$date1,$IN" >>  ${1}deepsleep.log
        #echo "$id,$date1,$an_data" >>  deepsleep.log
        #echo "inside $date1 $id $an_data"
        #mosquitto_pub -t "cmnd/tasmota_4C5AA3/DeepsleepTime" -r -n  -u test -P test
        #sleep 30
       echo "going to sleep" >> ${1}deepsleep.log
        #3600 = 1 hour

        mosquitto_pub -t "cmnd/${tasmotav}/DeepsleepTime" -r -m "3600"  -u test -P test
        #100 = 100 seconds
        sleep  3600


        mosquitto_pub -t "cmnd/${tasmotav}/DeepsleepTime" -r -m "0"  -u test -P test
        sleep 60
        mosquitto_pub -t "cmnd/${tasmotav}/DeepsleepTime" -r -n  -u test -P test
        sleep 30
        fi
fi
done
