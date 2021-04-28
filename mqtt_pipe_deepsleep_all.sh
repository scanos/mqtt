#!/bin/bash
# mqtt_pipe_deepsleeptst.sh MQTT broker data is piped to this script which logs temperature and goes deepsleep
# if a topic containing the word SENSOR is detected then the topic id and data are displayed
# mosquitto_sub -h localhost -p 1883 -v -t '#' -u test -P test | ./mqtt_pipe_deepsleeptst.sh
while read data && [ "$data" != "" ]
do
#tasmotav="tasmota_"$1
#echo tasmotav $tasmotav
#echo  dollar 1 $1
#echo data $data
#if [[ $data == *"$1"* ]]; then
        IN=$data
        arrIN=(${IN//;/ })
        #echo INSIDE $IN
      
        #id=$(echo ${arrIN[0]})
        #an_data=$(echo  ${arrIN[1]} | jq --unbuffered '"\(.Time) \(.DS18B20)"')
        #an_data=$(echo  ${arrIN[1]} | jq --unbuffered '"\(.DS18B20)"')


        #if [[ $an_data == *"DS18B20"* ]]; then
        if [[ $IN == *"Temperature"* ]]; then
        date1=$(date)
       #echo $date1 $IN

# $arrIN tele/tasmota_4C7759/SENSOR


#$ data tele/tasmota_4C7759/SENSOR {"Time":"2021-04-26T10:01:34","DS18B20":{"Id":"020692454681","Temperature":16.1},"TempUnit":"C"}
data=${data/$arrIN//}
# {"Time":"2021-04-26T10:01:34","DS18B20":{"Id":"020692454681","Temperature":16.1},"TempUnit":"C"}


       #echo $data 

       IFS=':' read -r -a dataarray <<< "$data"
      echo ${dataarray[5]}
      echo  ${data} | jq -i --unbuffered '"\(.DS18B20)"'

       #echo "$date1,$IN" >>  deepsleep.log
        #echo "$id,$date1,$an_data" >>  deepsleep.log
        #echo "inside $date1 $id $an_data"
        #mosquitto_pub -t "cmnd/tasmota_4C5AA3/DeepsleepTime" -r -n  -u test -P test
        #sleep 30
       echo "going to sleep" >> deepsleep.log
        #3600 = 1 hour

        #mosquitto_pub -t "cmnd/${tasmotav}/DeepsleepTime" -r -m "3600"  -u test -P test
        #100 = 100 seconds
        #sleep  3600


        #mosquitto_pub -t "cmnd/${tasmotav}/DeepsleepTime" -r -m "0"  -u test -P test
        #sleep 60
        #mosquitto_pub -t "cmnd/${tasmotav}/DeepsleepTime" -r -n  -u test -P test
        #sleep 30
        fi
#fi
done
