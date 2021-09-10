# Notes

## Networking

### Nat

**NAT**: Network address translation. Process of mapping one IP address space to another, by modifying the IP address and ports in frames being sent through a device which executes NAT. often done by a router, e.g. router has some IP address 123.8.8.4. For each device which is in this private network, any packets it passes through router to public network will cause router (NAT device) to track private device in NAT translation table, mapping its IP address and port to a "public IP address" and
port (some port on the router). Then, the router IP alone can handle all traffic from the public network to any devices on the private network, by mapping the public IP and port of an inbound request to the corresponding private IP and port [see visual here](https://en.wikipedia.org/wiki/Network_address_translation#/media/File:Network_Address_Translation_(file2).jpg)

**VirtualBox NAT**: NAT is the default mode for NIC1 of virtualbox VMs, because it allows (without configuration) for VM to access the network. NAT is handled by the virtualbox engine, which receives packets sent by the VM, and resends them using the host OS. From host OS pov, data looks like it was sent by virtualbox application on the host. virtualbox engine also listens for response packets, and sends them back to guest machine on its private network.

**NAT port forwarding**: Since VMs using NAT for public network access are on a private network (and have requests and responses to/from public network managed by virtualbox engine), VM is otherwise unreachable from internet. Port forwarding allows forwarding requests to port on host, to private network of the VM (this is how a server can be run on a VM).

## Storage

**Host Controller**: Device that connects a host machine to a network or storage device. This can be a host controller to interface with a storage controller. NIC is also a host controller

**Storage Controller**: Device that manages the physical disks of a machine, presenting them as a logical unit of storage to the computer. Interfaces with host controller via storage protocol e.g. SATA to connect to storage device.
