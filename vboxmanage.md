LIST VMs: vboxmanage list vms

SHOW VM INFO: vboxmanage showvminfo name

CREATE AND REGISTER VM: vboxmanage createvm --name [MACHINE_NAME] --ostype [Os type, ex: "Ubuntu_64"] --register

MODIFY VM: vboxmanage modifyvm "name" --setting value

CHANGE VM MEMORY: vboxmanage modifyvm "name" --memory [MEM_IN_MB]

SET NIC TO INTERNAL NETWORK: vboxmanage modifyvm redB --nic1 intnet

BASIC SETUP HEADLESS VM: https://www.andreafortuna.org/2019/10/24/how-to-create-a-virtualbox-vm-from-command-line/
