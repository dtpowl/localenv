#!/bin/sh

vmname=`basename $0 .sh`
portup=`echo $vmname | tr -d '[a-z]' | xargs -I {} expr {} \* 10000`

ssh_port=22
host_ssh_port=`expr $portup + $ssh_port`

VBoxManage setextradata "$vmname" "VBoxInternal/Devices/pcnet/0/LUN#0/Config/guestssh/Protocol" TCP
VBoxManage setextradata "$vmname" "VBoxInternal/Devices/pcnet/0/LUN#0/Config/guestssh/GuestPort" $ssh_port
VBoxManage setextradata "$vmname" "VBoxInternal/Devices/pcnet/0/LUN#0/Config/guestssh/HostPort" $host_ssh_port
# delete
#VBoxManage setextradata "$vmname" "VBoxInternal/Devices/pcnet/0/LUN#0/Config/guestssh/Protocol"
#VBoxManage setextradata "$vmname" "VBoxInternal/Devices/pcnet/0/LUN#0/Config/guestssh/GuestPort"
#VBoxManage setextradata "$vmname" "VBoxInternal/Devices/pcnet/0/LUN#0/Config/guestssh/HostPort"


#http_port=80
#host_http_port=`expr $portup + $http_port`
#VBoxManage setextradata "$vmname" "VBoxInternal/Devices/pcnet/0/LUN#0/Config/guesthttp/Protocol" TCP
#VBoxManage setextradata "$vmname" "VBoxInternal/Devices/pcnet/0/LUN#0/Config/guesthttp/GuestPort" $http_port
#VBoxManage setextradata "$vmname" "VBoxInternal/Devices/pcnet/0/LUN#0/Config/guesthttp/HostPort" $host_http_port

VBoxManage getextradata "$vmname" enumerate
