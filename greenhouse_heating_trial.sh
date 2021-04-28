#!/bin/bash

#mydate=$(date "+%d-%m-%Y %H:%M")


testweather=$(sudo curl "https://api.openweathermap.org/data/2.5/weather?lat=54.38&lon=-5.54&APPID=3a295505c01f4d79f9b17c765bd0be6d")
weather_main=$(echo $testweather | jq '.weather[].main')
#echo $(date) weather_main $weather_main
timeofday="day"
testsunrise=$(echo $testweather | jq '.sys.sunrise')
testsunset=$(echo $testweather | jq '.sys.sunset')
testdate=$(date +%s)

        if (( $testsunrise > $testdate || $testdate > $testsunset)); then
        timeofday="night"
        #echo $timeofday
        fi



outside_temp=$(echo $testweather | jq '.main.temp')
outside_temp=$(echo $outside_temp - 273.15 | bc)
#echo  $(date) "$timeofday $weather_main  outside_temp" $outside_temp
greenhouse=$(./beacon_arg_greenhouse.sh 12:3B:6A:1B:86:C1)
echo  $(date)",$timeofday,$weather_main,outside_temp,$outside_temp,$greenhouse" >> greenhouse_heating_trial




#check_value "$outside_temp" "Outside" "temperature" "C"



#wind=$(echo $testweather | jq '.wind.speed')
#wind=$(echo "$wind * 2.23694" | bc)
#wind=${wind%.*} #return substring before decimal point
#echo "wind ${wind}"
#check_value "$wind" "Wind" "Speed" "mph"
#winddate=$(date "+%d-%m-%Y %H:%M")

#echo $winddate,"wind speed mph",$wind >> delete_check_beaconarg2


#temperature=$(./read_esp32_temp2.sh 192.168.1.135)
#temperature=$(sudo curl -X GET --proto-default http "http://192.168.1.64/cm?cmnd=status%208" | jq '.StatusSNS.AM2301.Temperature')
#check_value "$temperature" "upstairs" "temperature" "C"

#temperature=$(sudo curl -X GET --proto-default http "http://192.168.1.239/cm?cmnd=status%208"| jq '.StatusSNS.DHT11.Temperature')
#check_value "$temperature" "kitchen" "temperature" "C"

#temperature=$(./beacon_arg2.sh 12:3B:6A:1B:86:C1)
#check_value "$temperature" "greenhouse" "temperature" "C"

#temperature=$(./beacon_arg2.sh 12:3B:6A:1B:B7:D8)
#check_value "$temperature" "conservatory" "temperature" "C"

#temperature=$(./beacon_arg2.sh 12:3B:6A:1B:8D:E8)
#check_value "$temperature" "mini_greenhouse" "temperature" "C"


#temperature=$(sudo curl -X GET --proto-default http "http://192.168.1.64/cm?cmnd=status%208" | jq '.StatusSNS.AM2301.Temperature')

#temperature=$(sudo curl -X GET --proto-default http "http://192.168.1.246/cm?cmnd=status%208" | jq '.StatusSNS.DS18B20.Temperature')
#sudo curl -X GET --proto-default http "http://192.168.1.246/cm?cmnd=status%208"| jq '.StatusSNS.DS18B20.Temperature'
#echo "compsot heap $temperature"
#check_value "$temperature" "mini_compost_heap" "temperature" "C"
#15:03:22.947 RSL: tele/tasmota_4C7759/SENSOR = {"Time":"2021-04-21T15:03:22","DS18B20":{"Id":"020692454681","Temperature":24.0},"TempUnit":"C"}



#testweather=$(sudo curl "https://api.openweathermap.org/data/2.5/weather?lat=54.38&lon=-5.54&APPID=3a295505c01f4d79f9b17c765bd0be6d")
#weather_main=$(echo $test | jq '.weather[].main')
#outside_temp=$testweather | jq .main.temp
#outside_temp=$(echo $test2 - 273.15 | bc)
#4.34
#outside_temp=$(echo $(sudo curl "https://api.openweathermap.org/data/2.5/weather?lat=54.38&lon=-5.54&APPID=3a295505c01f4d79f9b17c765bd0be6d" | jq .main.temp) - 273.15 | bc)
#check_value "$outside_temp" "Outside" "temperature" "C"
#$wind_speed = $temp*2.23694;
#wind=$( echo $(sudo curl "https://api.openweathermap.org/data/2.5/weather?lat=54.38&lon=-5.54&APPID=be24cd1ab5d2f7fc33c7d2e43ca58cfb" | jq '.wind.speed'))
#wind=$(echo "scale=0; $wind * 2.23694" | bc )
#$ echo "scale=2; 100/3" | bc
#wind=${wind%.*} #return substring before decimal point
#check_value "$wind" "Wind" "Speed" "mph"


#alertlength=${#mailalert}
#if [ "$alertlength" -gt 0 ]; then
        #rainalert=$(cat rainfall_total)

#mailx -a 'Content-Type: text/html' -s "my subject" user@gmail.com < email.html
#mycontent="\<html\>\<a href=clear.sh\>clear\<\/a\>"

#	echo $mailalert $mycontent| mailx   -a 'Content-Type: text/html' -s "Alerts" seamuskane@aim.com
#        echo $mailalert $rainalert| mailx  -s "Alerts" branchaude@gmail.com
       #echo $mailalert $rainalert

#fi
