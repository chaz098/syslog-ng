#!/bin/bash

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

config_txt = "@version: 3.5
@include "scl.conf"
@include "`scl-root`/system/tty10.conf"
    options {
        time-reap(30);
        mark-freq(10);
        keep-hostname(yes);
        };
    source s_local { system(); internal(); };
    source s_network {
        syslog(transport(tcp) port(514));
        };
    destination d_local {
    file("/var/log/syslog-ng/messages_${HOST}"); };
    destination d_logs {
        file(
            "/var/log/syslog-ng/${HOST}/${YEAR}_${MONTH}_${DAY}.log"
            create-dirs(yes)
            owner("root")
            group("root")
            perm(0777)
            ); };
    log { source(s_local); source(s_network); destination(d_logs); };"


sudo_check
syslog_install
config
service_restart