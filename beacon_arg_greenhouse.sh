#!/bin/bash
#sudo systemctl daemon-reload
#sleep 3
#sudo service bluetooth restart
#sleep 3
#ipaddress=$(cat ipaddress.txt)
#echo $ipaddress
ipmac=$(cat ipaddress.txt)
IFS=' ' read -r -a ip_data_array <<< "${ipmac}"
#macaddress=${ip_data_array[0]}
ipaddress=${ip_data_array[1]}
#echo ipaddress $ipaddress


#macarray=(12:3B:6A:1B:8D:E8 12:3B:6A:1B:B8:3D 12:3B:6A:1B:86:C1 12:3B:6A:1B:8E:70)
macarray=($1)
for u in "${macarray[@]}"
do
#    echo "$u is a macaddress"





#echo $maca
coproc sudo bluetoothctl


#    echo "$u is a macaddress in coproc"

sleep 3
echo -e 'power on\n' >&${COPROC[1]}
sleep 3
echo -e 'discoverable on\n' >&${COPROC[1]}
sleep 3
echo -e 'agent on\n' >&${COPROC[1]}
sleep 3
echo -e 'default-agent\n' >&${COPROC[1]}
sleep 3

secs=5                         # Set interval (duration) in seconds.
endTime=$(( $(date +%s) + secs )) # Calculate end time.

while [ $(date +%s) -lt $endTime ]; do  # Loop until interval has elapsed.
    echo -e '' >&${COPROC[1]}
echo -e 'scan on\n' >&${COPROC[1]}
done
sleep 3

echo -e 'info '$u'\nexit' >&${COPROC[1]}
#echo 'info '$u'\nexit'


count_me=0
my_temp=0
output=$(cat <&${COPROC[0]})

for line in $output; do
count_me=$((count_me +1))
# echo "$count_me $line"
#0x004c


if [[ "$line" =~ "0x004c" ]]; then
#      echo "Not Found";
#      echo "$count_me $line"
      my_temp=$((count_me +66))
fi

if [[ "$count_me" -eq "$my_temp" ]]; then
temp_value=$((line))
#temp_value=${temp_value//[-._]/}

#      echo "line $line temp_value $temp_value "
#      echo "temp_value with dollar $((temp_value))"

temp_value=${temp_value//$'\n'/} # Remove all newlines.
temp_value=${temp_value//$'\r'/} # Remove all newlines.

if [[ ${temp_value:0:1} == "0" ]] ; then temp_value=${temp_value/0/}; fi
if [[ ${temp_value:0:1} == "0" ]] ; then temp_value=${temp_value/0/}; fi
if [[ ${temp_value:0:1} == "0" ]] ; then temp_value=${temp_value/0/}; fi

#echo $(date)  $temp_value >> delete_check_beaconarg2
echo "greenhouse,"$temp_value",C"

today="$(date '+%Y-%m-%d %T')"


#if [ "$temp_value" -ne 0 ]; then
#sshpass -p '92Dufferin######' ssh pi@51.75.161.132 "mysql -u pi -p92Dufferin###### -D assets -e \"INSERT into logs (value,macaddress,description,log_date) VALUES ('$temp_value','$u','Temperature','$today');\""
#echo "INSERT into logs (value,macaddress,description,log_date)VALUES ('$temp_value','$u','Temperature','$today'"
#sshpass -p '92Dufferin######' ssh pi@51.75.161.132 "mysql -u $m_user -p$ip_pass -D assets -e \"INSERT into logs (value,macaddress,description,log_date) VALUES ('$te$

#this works
#sshpass -p '92Dufferin######' ssh pi@51.75.161.132 "mysql -u $m_user -p$ip_pass -D assets -e\"UPDATE assets set description= 'WittyZZ' WHERE Asset_ID = 3;\""
#this works

#sshpass -p '92Dufferin######' ssh pi@51.75.161.132 "mysql -u pi -p92Dufferin###### -D assets -e \"UPDATE assets set ipaddress='$ipaddress',asset_date = '$today' WHERE macaddress = '$u';\""
#sshpass -p '92Dufferin######' ssh pi@51.75.161.132 "mysql -u $m_user -p$ip_pass -D assets -e \"UPDATE assets set ipaddress='$ipaddress',asset_date = '$today' WHERE $
#echo "UPDATE assets set ipaddress='$ipaddress',asset_date = '$today' WHERE macaddress = '$u'"

#sshpass -p '92Dufferin######' ssh pi@51.75.161.132 "mysql -u pi -p92Dufferin###### -D assets -e \"UPDATE sensors set Value='$temp_value',sensor_date = '$today'  WHERE macaddress = '$u';\""
#echo "mysql -u pi -p92Dufferin###### -D assets -e \ UPDATE sensors set Value='$temp_value' WHERE macaddress = '$u'"


#
#fi

sleep 1
#mosquitto_pub -h "192.168.1.197" -p "1883" -m "$temp_value" -t "Greenhouse1"
fi
done
sleep 5 
done

if [ "$temp_value" -gt 25 ]; then

	if [ "$1" = "12:3B:6A:1B:9D:91" ]; then
        locationz="Conservatory"
        fi
        #echo $1 $temp_value " C"| mailx  -s "High Temperature $locationz $temp_value C" seamuskane@aim.com
        #echo $1 $temp_value " C"| mailx  -s "High Temperature $locationz $temp_value C" branchaude@gmail.com

fi
