#!/usr/bin/env bash

function check_pkgs() {
  for pkg in "$@"; do
    command -v $pkg >/dev/null 2>&1 || { echo >&2 "This script requires $pkg, please install package."; }
  done
}
check_pkgs "curl" "jq" "dig"

TYPE=${1^^}
DOMAIN=${2}
COUNTRY=${3^^}

function _line() {
	printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

function _myip() {
	curl --keepalive-time 1 -s https://api.myip.com | jq -r '. | "Local_IP: \(.ip) | Country: \(.country)"'
}

function dns_check() {
    local server=$1
    IFS=':' read -r id country location provider <<< "$server"
    echo "| Checking $DOMAIN in [${country^^}][$location][$provider]"
    local result=$(curl --keepalive-time 1 -s "https://www.whatsmydns.net/api/details?server=$id&type=$TYPE&query=$DOMAIN" -H 'x-requested-with: XMLHttpRequest' | jq '.data[] | {questions: .questions, rcode: .rcode, response: .response}')
    if [ $? -eq 0 ]; then
        echo "$result" | jq -c
    else
        echo "| Error checking $DOMAIN in [${country^^}][$location][$provider]"
    fi
	echo
}

function local_lookup() {
    echo "| Public DNS lookup on local PC |"
	echo "| `_myip` |"
	_line
	for list in $LOCAL_LOOKUP
	do
		DNS=$(echo $list | awk -F':' '{print $1}')
		PROD=$(echo $list | awk -F':' '{print $2}')
		echo "[$DNS] [$PROD]"
		dig +short @$DNS $2 $DOMAIN | xargs echo | jq -Rnc '[inputs | select( . ) / " "] | reduce .[] as $x ( []; . += [{response: $x}] )'
	done
}

FIXED_DNS_SERVERS="pqjoelej:kr:Seoul,_South_Korea:LG_Dacom
oajdnalj:kr:Seoul,_South_Korea:KT
ywjqnrob:jp:Osaka,_Japan:NIFTY
dabkekqb:us:Miami_FL,_United_States:AT&T
gobwmxbm:us:Dallas_TX,_United_States:Speakeasy
gxbreqjo:us:Providence_RI,_United_States:Verizon
oabdomjp:us:Jamaica_NY,_United_States:Level_3_Communications
oajdnppj:us:Dothan_AL,_United_States:Comodo
oajdyabp:us:Reston_VA,_United_States:Sprint
plbprwbw:us:Mountain_View_CA,_United_States:Google
pqjokmjw:us:Seattle_WA,_United_States:Speakeasy
vdjvkpbp:us:Ashburn_VA,_United_States:Cloudflare
vdjvwabp:us:Atlanta_GA,_United_States:Speakeasy
ypbmgdbx:us:Mountain_View_CA,_United_States:Google
ypjmlglb:us:Holtsville_NY,_United_States:OpenDNS
zebyoarb:us:San_Jose_CA,_United_States:Corporate_West
zgjgwyjn:us:Boston_MA,_United_States:Speakeasy
ywjqnkqb:us:Ashburn_VA,_United_States:NeuStar
vxjlnwlj:ca:Burnaby,_Canada:Fortinet
gobwzdjm:ca:Beaconsfield_QC,_Canada:PubNIX
oajdkmbp:ca:London_ON,_Canada:Golden_Triangle
plbpgroj:ca:Kelowna,_Canada:Shaw
xzjegyjn:ca:Montreal_QC,_Canada:MetroOptic
qrjnpdgj:mx:Culiacan,_Mexico:Megacable
dajkegaj:mx:Mexico_City,_Mexico:Total_Play
zgjgoxlj:br:Diadema,_Brazil:Trufer_Comercio_de_Sucatas
pqboeokb:es:Paterna_de_Rivera,_Spain:ServiHosting
dxjzneaj:nl:Diemen,_Netherlands:Tele2_Nederland
vdbvemrj:nl:Amsterdam,_Netherlands:Freedom_Registry
plbpgzyj:de:Oberhausen,_Germany:Deutsche_Telekom
zgbgdkjn:de:Dortmund,_Germany:Verizon
zejyokrj:ru:Yekaterinburg,_Russia:Skydns
qvbameqb:ru:Vladivostok,_Russia:Rostelecom
qvbamzbo:ru:St._Petersburg,_Russia:Uni_of_Tech_&_Design
vzgjgyjn:pk:Peshawar,_Pakistan:PTCL
plbpgeoj:pk:Rawalpindi,_Pakistan:CMPak
vxblnmlb:in:Ariyalur,_India:Railwire
dxjzopbq:my:Kota_Kinabalu,_Malaysia:TPMNet
dzjxgrwb:my:Shah_Alam,_Malaysia:TT_Dotcom
gxbrvdob:sg:Singapore,_Singapore:Tefincom
oabdaejp:cn:Nanjing,_China:NanJing_XinFeng_IT
dajkerqj:au:Adelaide_SA,_Australia:Telstra
qrjnpgnj:au:Melbourne_VIC,_Australia:Pacific
vdbvgajp:au:Melbourne_VIC,_Australia:Telstra
zebykgbq:au:Melbourne_VIC,_Australia:Pacific_Internet"

DNS_SERVERS=$(curl -s https://www.whatsmydns.net/api/servers | jq -r '.[] | "\(.id):\(.country):\(.location):\(.provider)"' | tr ' ' _)
DNS_SERVERS="$DNS_SERVERS $FIXED_DNS_SERVERS"
SORT_UNIQ_SERVERS=$(echo $DNS_SERVERS | tr ' ' '\n' | sort -t: -k1 -u)
DNS_SERVERS=$(echo $SORT_UNIQ_SERVERS | tr ' ' '\n' | sort -t: -k2 -u)

[ $# -eq 0 ] && echo "Please enter the content. ex) $(basename $0) a www.cdnetworks.com" && exit 0

if [ -n "$COUNTRY" ]; then
	DNS_SERVERS=$(echo "$DNS_SERVERS" | grep ":${COUNTRY,,}:")
fi

echo "| Global DNS Checker - whatsmydns.net |"
_line

for server in $DNS_SERVERS; do
    dns_check $server
done
_line

LOCAL_LOOKUP="1.1.1.1:Cloudflare-1 1.0.0.1:Cloudflare-2 208.67.222.222:OpenDNS-1 208.67.220.220:OpenDNS-2 8.8.8.8:Google-1 8.8.4.4:Google-2 219.250.36.130:SKT-1 210.220.163.82:SKT-2 168.126.63.1:KT-1 168.126.63.2:KT-2 164.124.101.2:LG-1 203.248.252.2:LG-2"
if [[ ${COUNTRY,,} == "kr" ]]; then
	local_lookup
fi
