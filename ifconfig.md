# ifconfig reference

**create new bridge**: `sudo ifconfig [BRIDGE_NAME] create`

**bring up bridge at IP with no net mask**: `sudo ifconfig [BRIDGE_NAME] [IP_ADDRESS] netmask 255.255.255.0 up `

**get existing bridge(s)**: `ifconfig | grep bridge`
