# About

---
whatsmydns.net is a free online tool. <br>
that lets you quickly and easily perform a DNS lookup to check DNS.

# How To Use

---
Test DNS servers located in multiple countries.
```shell
$> Gdig.sh [A, AAAA, CNAME] grergea.github.io

## result
$❯ Gdig.sh a grergea.github.io
| Global DNS Checker - whatsmydns.net |
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| Checking grergea.github.io in [AU][Adelaide_SA,_Australia][Telstra]
{"questions":["grergea.github.io. IN A"],"rcode":"NOERROR","response":["185.199.108.153","185.199.109.153","185.199.110.153","185.199.111.153"]}

| Checking grergea.github.io in [AU][Melbourne_VIC,_Australia][Pacific]
{"questions":["grergea.github.io. IN A"],"rcode":"NOERROR","response":["185.199.108.153","185.199.109.153","185.199.110.153","185.199.111.153"]}

| Checking grergea.github.io in [AU][Melbourne_VIC,_Australia][Pacific_Internet]
{"questions":["grergea.github.io. IN A"],"rcode":"NOERROR","response":["185.199.108.153","185.199.109.153","185.199.110.153","185.199.111.153"]}

| Checking grergea.github.io in [AU][Melbourne_VIC,_Australia][Telstra]
{"questions":["grergea.github.io. IN A"],"rcode":"NOERROR","response":["185.199.108.153","185.199.109.153","185.199.110.153","185.199.111.153"]}

| Checking grergea.github.io in [BR][Santa_Cruz_do_Sul,_Brazil][Claro]
{"questions":["grergea.github.io. IN A"],"rcode":"NOERROR","response":["185.199.108.153","185.199.109.153","185.199.110.153","185.199.111.153"]}

| Checking grergea.github.io in [CA][Beaconsfield_QC,_Canada][PubNIX]
{"questions":["grergea.github.io. IN A"],"rcode":"NOERROR","response":["185.199.108.153","185.199.109.153","185.199.110.153","185.199.111.153"]}

```

Test DNS servers located in specific countries.
```shell
$> Gdig.sh [A, AAAA, CNAME] grergea.github.io kr

## result
❯ Gdig.sh a grergea.github.io kr
| Global DNS Checker - whatsmydns.net |
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| Checking grergea.github.io in [KR][Seoul,_South_Korea][KT]
{"questions":["grergea.github.io. IN A"],"rcode":"NOERROR","response":["185.199.108.153","185.199.109.153","185.199.110.153","185.199.111.153"]}

| Checking grergea.github.io in [KR][Seoul,_South_Korea][LG_Dacom]
{"questions":["grergea.github.io. IN A"],"rcode":"NOERROR","response":["185.199.108.153","185.199.109.153","185.199.110.153","185.199.111.153"]}

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| Public DNS lookup on local PC |
| Local_IP: 114.111.60.64 | Country: Korea, Republic of |
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
[1.1.1.1] [Cloudflare-1]
[{"response":["185.199.110.153","185.199.111.153","185.199.109.153","185.199.108.153"]}]
[1.0.0.1] [Cloudflare-2]
[{"response":["185.199.108.153","185.199.109.153","185.199.110.153","185.199.111.153"]}]
[208.67.222.222] [OpenDNS-1]
[{"response":["185.199.111.153","185.199.108.153","185.199.109.153","185.199.110.153"]}]
[208.67.220.220] [OpenDNS-2]
[{"response":["185.199.108.153","185.199.109.153","185.199.110.153","185.199.111.153"]}]
[8.8.8.8] [Google-1]
[{"response":["185.199.109.153","185.199.111.153","185.199.108.153","185.199.110.153"]}]
[8.8.4.4] [Google-2]
[{"response":["185.199.108.153","185.199.110.153","185.199.111.153","185.199.109.153"]}]
[219.250.36.130] [SKT-1]
[{"response":["185.199.111.153","185.199.110.153","185.199.108.153","185.199.109.153"]}]
[210.220.163.82] [SKT-2]
[{"response":["185.199.110.153","185.199.108.153","185.199.109.153","185.199.111.153"]}]
[168.126.63.1] [KT-1]
[{"response":["185.199.108.153","185.199.110.153","185.199.109.153","185.199.111.153"]}]
[168.126.63.2] [KT-2]
[{"response":["185.199.109.153","185.199.111.153","185.199.108.153","185.199.110.153"]}]
[164.124.101.2] [LG-1]
[{"response":["185.199.110.153","185.199.108.153","185.199.109.153","185.199.111.153"]}]
[203.248.252.2] [LG-2]
[{"response":["185.199.111.153","185.199.108.153","185.199.109.153","185.199.110.153"]}]
```

# Releases

---
__1.0 Changelog : first created by Leesh.