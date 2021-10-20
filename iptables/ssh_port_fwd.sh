#!/bin/bash

# We have enabled ports 2222-2228 on router to listen for ssh traffic (in addn. to default 22).
# These DNAT rules will forward traffic on each of these ports to a particular VM SSH server, lets
# us SSH to any VM in our 3 VLANs via tunnel from router
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 2222 -j DNAT --to-destination 192.168.1.5:22
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 2223 -j DNAT --to-destination 192.168.1.10:22
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 2224 -j DNAT --to-destination 192.168.0.5:22
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 2225 -j DNAT --to-destination 192.168.0.10:22
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 2226 -j DNAT --to-destination 192.168.0.15:22
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 2227 -j DNAT --to-destination 192.168.2.5:22
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 2228 -j DNAT --to-destination 192.168.2.10:22
