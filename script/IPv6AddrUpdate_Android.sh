#!/bin/sh

#获取当前文件目录

dir=$(cd $(dirname $0); pwd)

#ip.txt用来保存IP地址，如果ip地址没发生变化，则不进行地址更新，重复提交地址更新官方会封号。

iptxt="$dir""/ip.txt"

#获取ipv6地址

ip=$(ip address | grep 'global dynamic' | head -n 1 | cut -d / -f 1 | cut -c 11-)

if  [ "${ip:-none}" == "none" ] 
  
then

  echo "[ddns] 获取 IP 错误！"

  logger -t "MeiBu IPV6 DDNS" -p local3.notice "[ddns] 获取 IP 错误！"

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

#与ip.txt中的ip地址对比，如果一致，则退出；如果不一致，则将新IP写入ip.txt文件，并提交动态域名跟新。

if [ "$ip" == "$oldip" ]

then

  echo "[ddns] IP 无变化！"

  logger -t "MeiBu IPV6 DDNS" -p local3.notice "[ddns] IP 无变化！"

  exit 0

fi

#将变化的ip地址写入ip.txt。

echo $ip > $iptxt

#更新动态域名ip地址

echo -p "输入你欲绑定ip的域名：" domain

echo -p "输入你欲绑定ip的域名：" passwd

url="http://ipv6.meibu.com/?name=${domain}&pwd=${passwd}&ipv6=${ip}"

re=`curl -s $url`

logger -t "MeiBu IPV6 DDNS" -p local3.notice "[ddns] 更新动态域名成功！"

echo "[ddns] 更新动态域名成功！"