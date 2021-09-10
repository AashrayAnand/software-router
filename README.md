# Software Router

## Goal: Set up virtual box network, connecting 3 internal networks of VMs to public network via router VM.

- [x] Set up 3 internal networks (red, blue, green) and two VMs (a, b) per internal network
- [x] Set up router VM, add NIC per internal network
- [ ] Set up 4th router NIC to direct ethernet access of home network, without NAT or host-only networking
- [ ] Install DHCP server on router
- [ ] Configure routing to allow VMs to access each others' networks
- [ ] Configure NAT on router (SNAT) so VMs can reach internet, using either ISP DNS or google DNS (8.8.8.8)
- [ ] Block redNet access via iptables
- [ ] Block access by default via iptables, move to explicit white-listing only for allowing network access
- [ ] install recursive DNS server on router, update DHCP to use this DNS
- [ ] move DNS and DHCP servers to blueNet
