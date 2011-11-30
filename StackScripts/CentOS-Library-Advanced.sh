#!/bin/bash

###########################################################
# CentOS-Library-Advanced - StackScripts id 3247
# http://www.linode.com/stackscripts/view/?StackScriptID=3247
#
# My library of CentOS functions, this is based on the Fedora/CentOS Bash Library (http://www.linode.com/stackscripts/view/?StackScriptID=20) but with my own extensions for further functionality.
# I've extended my original script to do more advanced setup of my linode.
#
###########################################################

function system_primary_ip {
  # returns the primary IP assigned to eth0
  echo $(ifconfig eth0 | awk -F: '/inet addr:/ {print $2}' | awk '{ print $1 }')
}

function get_rdns {
  # calls host on an IP address and returns its reverse dns

  if [ ! -e /usr/bin/host ]; then
    yum -yq install bind-utils > /dev/null
  fi
  echo $(host $1 | awk '/pointer/ {print $5}' | sed 's/\.$//')
}

function get_rdns_primary_ip {
	# returns the reverse dns of the primary IP assigned to this system
	echo $(get_rdns $(system_primary_ip))
}

function install_private {
  # install our private stuff
 
  # add the epel library repo
  rpm -Uvh http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-4.noarch.rpm

  # install some basic stuff we want on every image
  yum install -y fail2ban denyhosts htop system-config-securitylevel
}

function set_hostname {
  # set the hostname

  echo setting hostname to $1
  echo "HOSTNAME=$1" >> /etc/sysconfig/network
  hostname "$1"

  # update /etc/hosts
  echo $(system_primary_ip) $(get_rdns_primary_ip) $(hostname) >> /etc/hosts
}

function set_timezone {
  # set the timezone

  echo setting the timezone
  ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
}

# $1 - IPADDR, $2 - NETMASK, $3 - GATEWAY
function set_public_ip {
  echo -e "# Configuration for eth0\nDEVICE=eth0\nBOOTPROTO=none\n\n# This line ensures that the interface will be brought up during boot.\nONBOOT=yes\n\n# eth0 - This is the main IP address that will be used for most outbound connections.\n# The address, netmask and gateway are all necessary.\nIPADDR=${1}\nNETMASK=${2}\nGATEWAY=${3}\n" > /etc/sysconfig/network-scripts/ifcfg-eth0
}

# $1 - IPADDR, $2 - NETMASK
function set_private_ip {
  echo -e "# Configuration for eth0:1\nDEVICE=eth0:1\nBOOTPROTO=none\n\n# This line ensures that the interface will be brought up during boot.\nONBOOT=yes\n\n# eth0:1 - Private IPs have no gateway (they are not publicly routable) so all you need to\n# specify is the address and netmask.\nIPADDR=${1}\nNETMASK=${2}" > /etc/sysconfig/network-scripts/ifcfg-eth0:1
}

# $1, $2, $3 - name servers 
function set_dns_resolver {
  echo -e "domain members.linode.com\nsearch members.linode.com\nnameserver ${1}\nnameserver ${2}\nnameserver ${3}\noptions rotate" > /etc/resolv.conf
}

function restart_networking {
  service network restart
}
