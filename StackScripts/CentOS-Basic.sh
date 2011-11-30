#!/bin/bash
# <udf name="machinename" label="Hostname - make sure reverse DNS is setup" example="hostname"/>

source <ssinclude StackScriptID="20">
source <ssinclude StackScriptID="1641">

###########################################################
# CentOS-Basic - StackScripts id 1640
# http://www.linode.com/stackscripts/view/?StackScriptID=1640
# 
# This is my version of an initial setup script for CentOS.
# It updates all packages, installs some basic packages I use and then sets the hostname, updates the hosts file and sets the timezone (London).
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
