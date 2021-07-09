#!/bin/bash
sudo_check
syslog_install
config
service_restart

#installs syslog-ng
syslog_install () {
	sudo apt install syslog-ng -y
done
}

#change main config file to .bak and create new config file.
config () {
	mv /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf.bak
	touch /etc/syslog-ng/syslog-ng.conf
	echo $config_txt >> /etc/syslog-ng/syslog-ng.conf
done
}

#restarts service with
service_restart () {
	service syslog-ng restart
	local results = "service syslog-ng status"
done
}

#checks to make sure that the script is being ran as root
sudo_check () {
	if [[ $(/usr/bin/id -u) -ne 0 ]]; then
	    echo "Not running as root"
	    exit
	fi	
}

config_txt = "@version: 3.16
@include "scl.conf"
source s_local {
    system(); internal();
};
destination d_local {
    file("/var/log/messages");
};
log {
    source(s_local); destination(d_local);
};"