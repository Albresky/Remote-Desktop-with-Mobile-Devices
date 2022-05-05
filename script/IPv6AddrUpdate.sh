#!/bin/sh


dir=$(cd $(dirname $0); pwd)

iptxt="$dir""/ip.txt"

ip=$(ip -6 addr list scope global $device | grep -v " fd" | sed -n 's/.*inet6 \([0-9a-f:]\+\).*/\1/p' | head -n 1)

if  [ "${ip:-none}" == "none" ] 
then
  echo "[ddns] 获取 IP 错误！"
  exit 12
fi


if [ -f $iptxt ] 
then
  oldip=$(tail -n 1 $iptxt)
else
  oldip="::"
fi

if [ "$ip" == "$oldip" ]
then
  echo "[ddns] IP 无变化！"
  exit 0
fi

echo $ip > $iptxt

# replace 'xxx' with your domain name 
url="http://ipv6.meibu.com/?name=xxx&pwd=XXX&ipv6=${ip}"

re=`curl -s $url`

echo "[ddns] 更新动态域名成功！"
