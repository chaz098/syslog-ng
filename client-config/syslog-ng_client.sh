#!/bin/bash

#changes ip from cli arg
ip_change () {
	sed -i "s/ip/$ip/g" /etc/syslog-ng/syslog-ng.conf
}

#installs syslog-ng
syslog_install () {
	sudo apt install syslog-ng -y

}

#change main config file to .bak and create new config file.
config () {
	mv /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf.bak
	mv $PWD/syslog-ng.conf /etc/syslog-ng/

}

#restarts syslog-ng server
service_restart () {
	service syslog-ng restart
	service syslog-ng status

}

#checks to make sure that the script is being ran as root
sudo_check () {
	if [[ $(/usr/bin/id -u) -ne 0 ]]; then
	    echo "Not running as root"
	    exit
	fi	
}

# checks to make sure there's an arg for the ip in cli.
if [[ $# -eq 0 ]]; then
	echo "No arguments supplied, need to run the script with an ip I.E ./syslog-ng_client.sh x.x.x.x"
	exit
fi

ip=$1

sudo_check
syslog_install
config
ip_change $ip
service_restart