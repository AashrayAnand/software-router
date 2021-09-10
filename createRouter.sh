#!/bin/bash

# Simple script to create and register virtualbox VM, to use as router for existing internal networks,

# usage: ./createRouter [VM_NAME] [INT_NET_NAME_1] [INT_NET_NAME_2] .... (max 3 internal networks)
# for now, must supply 3 internal networks, TODO allow dynamic number of internal networks

if [ "$#" -lt 4 ]; then
    echo "usage: ./createRouter [VM_NAME] [INT_NET_NAME_1] [INT_NET_NAME_2] .... (max 3 internal networks)"
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
net1=$2
net2=$3
net3=$4

# create VM and configure appropriate configuration
vboxmanage createvm --name $vmName --ostype $os --register
vboxmanage modifyvm $vmName --memory $mem

# replace NICs with specified internal networks
vboxmanage modifyvm $vmName --nic1 intnet
vboxmanage modifyvm $vmName --intnet1 $net1
vboxmanage modifyvm $vmName --nic2 intnet
vboxmanage modifyvm $vmName --intnet2 $net2
vboxmanage modifyvm $vmName --nic3 intnet
vboxmanage modifyvm $vmName --intnet3 $net3

clear
echo "NIC info......."

vboxmanage showvminfo $vmName | grep "NIC 1"
vboxmanage showvminfo $vmName | grep "NIC 2"
vboxmanage showvminfo $vmName | grep "NIC 3"
