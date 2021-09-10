#!/bin/bash

# set up script, provisions 3 internal networks, with 2 VMs per internal network
# and a router VM, which is connected to all 3 internal networks, and connected
# via bridged network to the public network

# create VMs


sh ./createVMAndIntNet.sh redA redNet
sh ./createVMAndIntNet.sh redB redNet
sh ./createVMAndIntNet.sh blueA blueNet
sh ./createVMAndIntNet.sh blueB blueNet
sh ./createVMAndIntNet.sh greenA greenNet
sh ./createVMAndIntNet.sh greenB greenNet

# create Router
sh ./createRouter.sh router greenNet blueNet redNet
