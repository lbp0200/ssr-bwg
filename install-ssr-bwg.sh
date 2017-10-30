#!/bin/sh

PASSWORD=$1
if [ ! $PASSWORD ]; then
	PASSWORD='pwd1'
fi

yum install git -y

cd /opt
git clone -b manyuser https://github.com/shadowsocksr-backup/shadowsocksr.git

echo '''
{
    "server": "0.0.0.0",
    "server_ipv6": "::",
    "server_port": 443,
    "local_address": "127.0.0.1",
    "local_port": 1080,

    "password": "'''$PASSWORD'''",
    "method": "none",
    "protocol": "auth_chain_b",
    "protocol_param": "",
    "obfs": "tls1.2_ticket_auth",
    "obfs_param": "",
    "speed_limit_per_con": 0,
    "speed_limit_per_user": 0,

    "additional_ports": {}, 
    "additional_ports_only": false,
    "timeout": 120,
    "udp_timeout": 60,
    "dns_ipv6": false,
    "connect_verbose_info": 0,
    "redirect": "",
    "fast_open": false
}
''' > /opt/shadowsocksr/user-config.json

wget https://raw.githubusercontent.com/lbp0200/ssr-bwg/master/shadowsocksr -O /etc/init.d/shadowsocksr
chmod 755 /etc/init.d/shadowsocksr && chkconfig --add shadowsocksr && service shadowsocksr start