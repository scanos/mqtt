#!/bin/bash
source ./config_weather.sh
#pi@pi92c5:~ $ grep Tokyo worldcities.csv
#"Tokyo","Tokyo","35.6850","139.7514","Japan","JP","JPN","Tōkyō","primary","35676000","1392685764"
#$city=$(grep "$1" worldcities.csv)
#echo city $city

#latitude=$(IFS="," read -ra ADDR <<< "${city}"; echo ${ADDR[2]})
#longitude=$(IFS="," read -ra ADDR <<< "${city}"; echo ${ADDR[3]})

#latitude=${latitude//\"/}
#longitude=${longitude//\"/}




#echo lat / lon $latitude $longitude

rain=$(sudo curl "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&APPID=$ow_api" | jq '.rain')
name=$(sudo curl "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&APPID=$ow_api" | jq '.name')


#rain=$(sudo curl "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&APPID=$ow_api" | jq '.rain')
#name=$(sudo curl "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&APPID=$ow_api" | jq '.name')


rain=$(echo "${rain#*:}")
rain=${rain//\}/}
rain=${rain// /}
#rain=${rain//\/n/}
#rain=${rain//\/r/}
rain=${rain//$'\n'/} # Remove all newlines.
name=${name// /_} 
echo $rain $name test



if [ "${rain}" == "null" ]; then
    echo "VAR is unset or set to the empty string"

else
date_in_seconds=$(date "+%s")
echo "$(date)|$rain?$date_in_seconds" >> rainfall
fi



#rain_date=$(tail -1 rainfall)
#rain_date=${rain_date%?*}
#echo $rain_date

#MariaDB [projects]> describe rainfall
#    -> ;
#+----------+-----------------+------+-----+-------------------+-----------------------------+
#| Field    | Type            | Null | Key | Default           | Extra                       |
#+----------+-----------------+------+-----+-------------------+-----------------------------+
#| id       | int(6) unsigned | NO   | PRI | NULL              | auto_increment              |
#| location | varchar(100)    | NO   |     | NULL              |                             |
#| lat      | float           | NO   |     | NULL              |                             |
#| lng      | float           | NO   |     | NULL              |                             |
#| reg_date | timestamp       | NO   |     | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |
#+----------+-----------------+------+-----+-------------------+-----------------------------+

#rain=3.2
#location="portaferry"
#mycommand="insert into projects.rainfall (location,rainfall) values (\"$location\",\"$rain\")"
#echo $mycommand
#gcloud beta compute ssh --zone "us-central1-a" "instance-2" --command="sudo mysql -e '$mycommand'"








