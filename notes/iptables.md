# iptables reference

**list existing rules: `sudo iptables -L` (e.g. below)

Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain FORWARD (policy DROP)
target     prot opt source               destination         
ACCEPT     all  --  Chenyan-PC.redmond.corp.microsoft.com/24  anywhere            
ACCEPT     all  --  192.168.2.0/24       anywhere            
ACCEPT     all  --  anywhere             192.168.2.0/24      
ACCEPT     all  --  anywhere             Chenyan-PC.redmond.corp.microsoft.com/24 
ACCEPT     all  --  anywhere             192.168.0.0/24      
DROP       all  --  192.168.0.0/24       Chenyan-PC.redmond.corp.microsoft.com/24 
DROP       all  --  192.168.0.0/24       192.168.2.0/24      

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination

**list nat rules**: `sudo iptables -t nat -L`

**DROP by default for netfilter rule**: `sudo iptables -P [FORWARD|INPUT|ACCEPT|PREROUTING|POSTROUTING] DROP`

**ALLOW for source subrange**: `sudo iptables -A [FORWARD|INPUT|ACCEPT|PREROUTING|POSTROUTING] -s 192.168.0.0/16 ACCEPT`

**ALLOW for dest. subrange**: `sudo iptables -A [FORWARD|INPUT|ACCEPT|PREROUTING|POSTROUTING] -d 192.168.0.0/16 ACCEPT`

**Enable NAT**: `sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE`
