#!/bin/bash
# <udf name="machinename" label="Hostname - make sure reverse DNS is setup" example="hostname"/>

source <ssinclude StackScriptID="20">
source <ssinclude StackScriptID="3247">

###########################################################
# CentOS-Advanced - StackScripts id 3245
# http://www.linode.com/stackscripts/view/?StackScriptID=3245
# 
# This is my advanced stack script to setup my CentOS server as I want it. It is an evolution of my CentOS-Basic script.
# 
# This is my version of an initial setup script for CentOS.
# It updates all packages, installs some basic packages I use and then sets the hostname, updates the hosts file and sets the timezone (London).
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
