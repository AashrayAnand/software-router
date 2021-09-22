# Notes

## Networking

### General

**DHCP**: Dynamic Host Configuration Protocol. This protocol is part of the IP layer, and is an internet standard for dynamically configuring hosts with relevant information which is needed to enable IP. The most well-known feature of DHCP is the ability of a DHCP server to assign dynamic IP addresses to a set of devices, for example, a DHCP on a router which will assign IPs to devices which connect to the router's WLAN, assigning the IPs in a specific range and using NAT to handle packet forwarding to the Internet. DHCP can also configure various other configurations e.g. the DNS to use, different subnet masks for different hosts etc.

**Authoritative name server**: Name server which is authority on a subset of domain to IP mappings, referred by caching name servers for DNS resolution

**Caching name server**: Name server which references authoritative name servers for DNS resolution, caching results to reference in future for same DNS resolutions.

**Recursive vs. Iterative DNS resolution**: Getting the result, vs. getting a reference to the next name server to consult with.

### Nat

**NAT**: Network address translation. Process of mapping one IP address space to another, by modifying the IP address and ports in frames being sent through a device which executes NAT. often done by a router, e.g. router has some IP address 123.8.8.4. For each device which is in this private network, any packets it passes through router to public network will cause router (NAT device) to track private device in NAT translation table, mapping its IP address and port to a "public IP address" and
port (some port on the router). Then, the router IP alone can handle all traffic from the public network to any devices on the private network, by mapping the public IP and port of an inbound request to the corresponding private IP and port [see visual here](https://en.wikipedia.org/wiki/Network_address_translation#/media/File:Network_Address_Translation_(file2).jpg)

**VirtualBox NAT**: NAT is the default mode for NIC1 of virtualbox VMs, because it allows (without configuration) for VM to access the network. NAT is handled by the virtualbox engine, which receives packets sent by the VM, and resends them using the host OS. From host OS pov, data looks like it was sent by virtualbox application on the host. virtualbox engine also listens for response packets, and sends them back to guest machine on its private network.

**NAT port forwarding**: Since VMs using NAT for public network access are on a private network (and have requests and responses to/from public network managed by virtualbox engine), VM is otherwise unreachable from internet. Port forwarding allows forwarding requests to port on host, to private network of the VM (this is how a server can be run on a VM).

### Routing/IP

**IP Address**: Device address which addresses network adapters in IP. Compared to MAC addresses, these are not linked to physical hardware, but rather are configured by software, either statically or dynamically. IP addresses thus provide more flexibility than MAC addresses, and along with this, add many abstractions such as subnetting and NAT and packet switching etc. which enable the Internet.

**IPv4**: Addressing scheme where IP addresses are 32 bits numbers. Original creators of IPv4 had foresight to see this would eventually lead to naming shortage (only in range of billions, not scale of internet), so introduced the concept of subnetting, and address translation, so IPs can technically be reused, or only allocated when needed and shared e.g. router gets IP address, then all users of router get IP in private subnet, which router routes using NAT, thus all requests to Internet from devices on that router only use router's IP.

**IP forwarding**: Routers are the key devices in IP because they enable IP forwarding, where packets routed to the router from another device can be forwarded to their destination, or to another intermediate stop on the way to the destination. This is a step up from ethernet (L2), where communication is limited to going between devices connected via L2 switch. Now, we can have intermediate devices which bring switches together to form a larger internetworking. This is the foundation of the Internet. This is enabled in linux via `sysctl -w net.ipv4.ip_forward=1`

## Storage

**Host Controller**: Device that connects a host machine to a network or storage device. This can be a host controller to interface with a storage controller. NIC is also a host controller

**Storage Controller**: Device that manages the physical disks of a machine, presenting them as a logical unit of storage to the computer. Interfaces with host controller via storage protocol e.g. SATA to connect to storage device.
