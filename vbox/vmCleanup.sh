#!/bin/bash

# set up script, provisions 3 internal networks, with 2 VMs per internal network
# and a router VM, which is connected to all 3 internal networks, and connected
# via bridged network to the public network

# power off VMs and router, if running
for machine in $( cat ./machines.txt )
do
    vboxmanage controlvm $machine poweroff
done

# delete VMs and router
for machine in $( cat ./machines.txt )
do
    vboxmanage unregistervm $machine --delete
done

# delete VM files base path
rm -rf ./VM_FILES
