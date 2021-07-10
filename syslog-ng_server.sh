#!/bin/bash

#installs syslog-ng
syslog_install () {
	sudo apt install syslog-ng -y
done
}

#change main config file to .bak and create new config file.
config () {
	mv /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf.bak
	mv $PWD/syslog-ng.conf /etc/syslog-ng/
done
}

#restarts service with
service_restart () {
	service syslog-ng restart
	service syslog-ng status
done
}

#checks to make sure that the script is being ran as root
sudo_check () {
	if [[ $(/usr/bin/id -u) -ne 0 ]]; then
	    echo "Not running as root"
	    exit
	fi	
}

sudo_check
syslog_install
config
service_restart