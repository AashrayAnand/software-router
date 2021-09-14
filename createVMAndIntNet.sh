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

# get args
vmName=$1
netName=$2

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
vboxmanage modifyvm $vmName --intnet1 $netName

#clear
echo "NIC1 info......."

vboxmanage showvminfo $vmName | grep "NIC 1"

echo "Starting up VM in headless mode......."

vboxmanage startvm $vmName --type headless
