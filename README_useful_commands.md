![mqtt_2](https://user-images.githubusercontent.com/29405761/110956164-409c5700-8342-11eb-9cd3-b924f38311cb.png)

From the Raspberry Pi CLI (MQTT Broker),

1. Displays the output from a specific topic
   mosquitto_sub -h localhost -p 1883 -t myTopic -u <user_name> -P <password>

2. Displays the output from all topics 
   mosquitto_sub -h localhost -p 1883 -v -t '#' -u test -P test

3. Toggles power on remote Witty Cloud with topic tasmota_03CA1D/POWER
   mosquitto_pub -h localhost -t cmnd/tasmota_03CA1D/POWER -m toggle  -u test -P test
 
4. Pipe output from topics to a bash script for further processing (see mqtt_pipe.sh and mqtt_pipe_2.sh)
   mosquitto_sub -h localhost -p 1883 -v -t '#' -u test -P test | ./mqtt_pipe_2.sh

   YOU CAN AVOID THE NEED TO USE MQTT WITH TASMOTAS BY USING TASMOTA HTTP API
EG curl -s http://192.168.4.39/cm?cmnd=STATUS+8 | jq  '.StatusSNS.DS18B20.Temperature'
