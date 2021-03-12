![mqtt_2](https://user-images.githubusercontent.com/29405761/110956164-409c5700-8342-11eb-9cd3-b924f38311cb.png)
mosquitto_pub -h 192.168.1.248 -t cmnd/tasmota_38FFE2/POWER -m off  -u test -P test
mosquitto_sub -h localhost -p 1883 -t myTopic -u <user_name> -P <password>
mosquitto_pub -h 192.168.1.239 -p 1883 -t myTopic stat/tasmota_03CA1D/POWER -m off
