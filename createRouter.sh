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

basePath=`pwd`/VM_FILES

echo "Creating new VM ${vmName} on INTNET ${netName} WITH OS ${os}......."

# create VM and configure appropriate configuration
vboxmanage createvm --name $vmName --ostype $os --register --basefolder $basePath
vboxmanage modifyvm $vmName --memory $mem

echo "Creating VHD and storage controller......"

# create and attach 10 gb VHD
vboxmanage createhd --filename "${basePath}/${vmName}/${vmName}_DISK.vdi" --size 10000 --format VDI

# create HDD storage controller
vboxmanage storagectl $vmName --name "IDE Controller" --add ide

# map HDD/ISO via IDE controller
vboxmanage storageattach $vmName --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium "${basePath}/${vmName}/${vmName}_DISK.vdi"
vboxmanage storageattach $vmName --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium ./ubuntu.iso

echo "Booting from ISO......"

# boot from DVD
vboxmanage modifyvm $vmName --boot1 dvd

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

# set up bridged network for 4th NIC, to connect internal networks
# to public network (via router)

# create bridge interface and bring up on host
#sudo ifconfig bridge1 create
sudo ifconfig bridge1 192.168.222.1 netmask 255.255.255.0 up

# declare bridge interface for vm
vboxmanage modifyvm $vmName --nic4 bridged --nictype 82545EM --bridgeadapter4 bridge1

echo "Starting up VM in headless mode......."

vboxmanage startvm $vmName --type headless
