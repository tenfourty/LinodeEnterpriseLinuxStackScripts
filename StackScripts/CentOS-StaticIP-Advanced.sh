#!/bin/bash
# <udf name="machinename" label="Hostname - make sure reverse DNS is setup" example="hostname"/>
# <udf name="publicip" label="Linode Public IP" example="178.79.134.167"/>
# <udf name="publicnetmask" label="Netmask" default="255.255.255.0" example="255.255.255.0"/>
# <udf name="publicgateway" label="Gateway" example="178.79.134.1"/>
# <udf name="dnsresolver1" label="DNS Resolver 1" default="109.74.192.20" example="109.74.192.20"/>
# <udf name="dnsresolver2" label="DNS Resolver 2" default="109.74.193.20" example="109.74.193.20"/>
# <udf name="dnsresolver3" label="DNS Resolver 3" default="109.74.194.20" example="109.74.194.20"/>
# <udf name="privateip" label="Linode Private IP" example="192.168.154.122"/>
# <udf name="privatenetmask" label="Private Netmask" default="255.255.128.0" example="255.255.128.0"/>

source <ssinclude StackScriptID="20">
source <ssinclude StackScriptID="3247">

###########################################################
# CentOS-StaticIP-Advanced - StackScripts id 3246
# http://www.linode.com/stackscripts/view/?StackScriptID=3246
# 
# This script does the same tasks as our Basic setup script but also sets static public and private ips.
# This script is based on the Fedora/CentOS Basics (http://www.linode.com/stackscripts/view/?StackScriptID=52) with my own extensions.
# 
###########################################################

###########################################################
# Start Script
###########################################################

# update and install our stuff
system_update
install_basics
install_private
set_hostname $MACHINENAME
set_timezone
set_public_ip $PUBLICIP $PUBLICNETMASK $PUBLICGATEWAY
set_private_ip $PRIVATEIP $PRIVATENETMASK
restart_networking
set_dns_resolver $DNSRESOLVER1 $DNSRESOLVER2 $DNSRESOLVER3
restart_networking
