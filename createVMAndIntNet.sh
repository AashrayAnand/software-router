#!/bin/bash

# Simple script to create and register virtualbox VM, and set nic1 to internal network,
# As well as specify internal network for this NIC

# usage: ./createVMAndIntNet [VM_NAME] [INT_NET_NAME]

if [ "$#" -ne 2 ]; then
    echo "usage: ./createVMAndIntNet [VM_NAME] [INT_NET_NAME]"
    exit 1
fi

# for now, will assume using the following configuration
mem=256
vhd=10
os="Ubuntu_64"

# if needed, get Ubuntu Server ISO

if [ ! -f ./ubuntu.iso ]; then
    wget https://releases.ubuntu.com/20.04.3/ubuntu-20.04.3-live-server-amd64.iso?_ga=2.98936664.736968982.1631255602-548570921.1631255602 -O ubuntu.iso
fi

# get args
vmName=$1
netName=$2

# create VM and configure appropriate configuration
vboxmanage createvm --name $vmName --ostype $os --register
vboxmanage modifyvm $vmName --memory $mem

# replace NIC1 (NAT by default) with specified internal network
vboxmanage modifyvm $vmName --nic1 intnet
vboxmanage modifyvm $vmName --intnet1 $netName

clear
echo "NIC1 info......."

vboxmanage showvminfo $vmName | grep "NIC 1"
