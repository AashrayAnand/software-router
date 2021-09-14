#!/bin/bash

# Simple script to create and register virtualbox VM, to use as router for existing internal networks,

# usage: ./createRouter [vmName] [INT_NET_NAME_1] [INT_NET_NAME_2] .... (max 3 internal networks)
# for now, must supply 3 internal networks

if [ "$#" -lt 4 ]; then
    echo "usage: ./createRouter [vmName] [INT_NET_NAME_1] [INT_NET_NAME_2] .... (3 internal networks)"
    exit 1
fi


# get args
vmName=$1
net1=$2
net2=$3
net3=$4

# os parameters
os=Ubuntu_64
isoPath=~/Documents/NetworkFundamentals/ubuntu-20.04.3-desktop-amd64.iso

# go to VMs folder
cd ~/VirtualBox\ VMs

echo "Creating new VM ${vmName} on INTNET ${netName} WITH OS ${os}......."

# create VM and configure appropriate configuration
vboxmanage createvm --name $vmName --ostype $os --register

echo "Creating VDI....."

# create 32 gb VDI
vboxmanage createhd --filename "${vmName}.vdi" --size 32768

echo "Creating storage controllers...."

# Create storage controllers and attach VDI and ISO
vboxmanage storagectl $vmName --name "SATA Controller" --add sata --controller IntelAHCI
vboxmanage storageattach $vmName --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "${vmName}.vdi"
vboxmanage storagectl $vmName --name "IDE Controller" --add ide
vboxmanage storageattach $vmName --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium ${isoPath}

# misc config
vboxmanage modifyvm $vmName --ioapic on
vboxmanage modifyvm $vmName --memory 1024 --vram 128

# replace NICs with specified internal networks
vboxmanage modifyvm $vmName --nic1 intnet
vboxmanage modifyvm $vmName --intnet1 $net1
vboxmanage modifyvm $vmName --nic2 intnet
vboxmanage modifyvm $vmName --intnet2 $net2
vboxmanage modifyvm $vmName --nic3 intnet
vboxmanage modifyvm $vmName --intnet3 $net3

# set up bridged network for 4th NIC, to connect internal networks
# to public network (via router)

# declare bridge interface for vm
vboxmanage modifyvm $vmName --nic4 bridged
vboxmanage modifyvm $vmName --bridgeadapter4 en0