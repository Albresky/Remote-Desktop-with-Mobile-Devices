#!/bin/sh

dir=$(cd $(dirname $0); pwd)

iptxt="$dir""/ip.txt"

ip=$(ip address | grep 'global dynamic' | head -n 1 | cut -d / -f 1 | cut -c 11-)

if  [ "${ip:-none}" == "none" ] 
then
  echo "[ddns] 获取 IP 错误！"
  exit 12
else
  echo "获取当前IPv6地址成功=>${ip}"
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

echo -p "输入你欲绑定ip的域名：" domain

url="http://ipv6.meibu.com/?name=${domain}&pwd=XXX&ipv6=${ip}"

re=`curl -s $url`

echo "[ddns] 更新动态域名成功！"
