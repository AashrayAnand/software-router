;
; BIND data file for bluenet, name server is on eth1 (192.168.0.1)
;
$TTL	604800
@	IN	SOA	ns1.bluenet.com. router.bluenet.com. (
			      4		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
; name servers - NS records
	IN	NS	ns1.bluenet.com.
; name servers - A records
ns1.bluenet.com.	IN	A	192.168.0.1
; temp - configure static A records for nodes in subnet,
; will replace this with config via DHCP later
a.bluenet.com.		IN	A	192.168.0.5
b.bluenet.com.		IN	A	192.168.0.10
