#!/bin/sh

dir=$(cd $(dirname $0); pwd)
iptxt="$dir""/ip.txt"
ip=$(ip address | grep 'global dynamic' | head -n 1 | cut -d / -f 1 | cut -c 11-)


if  [ "${ip:-none}" == "none" ] 
then
  echo "[ddns] 获取 IP 错误！"
  logger -t "IPV6 DDNS" -p local3.notice "[ddns] 获取 IP 错误！"
  exit 12
else
  echo "获取当前IPv6地址成功 => ${ip}"
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
  logger -t "IPV6 DDNS" -p local3.notice "[ddns] IP 无变化！"
  exit 0
fi


echo $ip > $iptxt


read -s -p "输入你欲绑定ip的域名：" domain
read -s -p "输入你欲绑定ip的域名：" passwd

url="http://ipv6.meibu.com/?name=${domain}&pwd=${passwd}&ipv6=${ip}"

re=`curl -s $url`

logger -t "IPV6 DDNS" -p local3.notice "[ddns] 更新动态域名成功！"

echo "[ddns] 更新动态域名成功！"