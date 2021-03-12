mosquitto_pub -h 192.168.1.248 -t cmnd/tasmota_38FFE2/POWER -m off  -u test -P test
mosquitto_sub -h localhost -p 1883 -t myTopic -u <user_name> -P <password>
mosquitto_pub -h 192.168.1.239 -p 1883 -t myTopic stat/tasmota_03CA1D/POWER -m off
