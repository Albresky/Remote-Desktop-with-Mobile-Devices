# Remote-Desktop-with-Mobile-Devices
Remote connection to PC via IPv6, automatically update IPv6 address .

---

# Introduction

This repository is built for people who need to connect remote PCs via `Remote Desktop`[an app developed bty Microsoft]. However, problems tend to happen which force us to establish a connect on public IP address. :(

Don't worry! This repository is aimed to handle this tragedy! It will automatical bind your remote-PC's address to your private domain, though the ipv6-address is dynamic!

Follow the steps bellow and enjoy yourself!


# Installation

## 1 IPv6 network transmitted by Mobile Phone (Android)

### 1.1 Install `Termux`

- Install the console -- `Termux`
- Clone this repository to your phone via the console
- execute `'cd xxx/Remote-Desktop-with-Mobile-Devices/script'`
- Change the file permission via execute `'chmod 764 IPv6AddrUpdate_Android.sh'`
- execute `'./IPv6AddrUpdate_Android.sh'`
- Follow the instruction printed in the console
  - e.g. 
    - 输入你欲绑定ip的域名：`cosyspark.space`    
