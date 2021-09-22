# vboxmanage reference

**List VMs**: `vboxmanage list vms`

**Show VM Info**: `vboxmanage showvminfo name`

**Create/Register VM**: `vboxmanage createvm --name [MACHINE_NAME] --ostype [Os type, ex: "Ubuntu_64"] --register`

**Delete/Unregister VM**: `vboxmanage unregistervm [name|uuid] --delete`

**Modify VM**: `vboxmanage modifyvm "name" --setting value`

**Change VM Memory**: `vboxmanage modifyvm "name" --memory [MEM_IN_MB]`

**Set NIC type to internal networking**: `vboxmanage modifyvm redB --nic1 intnet``

[Headless VM Setup](https://www.andreafortuna.org/2019/10/24/how-to-create-a-virtualbox-vm-from-command-line/)
