# How to use
Just copy and paste to your shell, Press [enter] and the config will be automatically deploy

## Setup zram (systemd required)
[More info](https://github.com/wikihost-opensource/linux-toolkit/system/zram)


## Using DoH Service
### Cloudflare
```
bash -c "$(wget -qO - https://github.com/wikihost-opensource/linux-toolkit/raw/main/network/dns-over-https/cloudflare.sh)"
```
## Enable BBR
### For CentOS 7
```
bash -c "$(wget -qO - https://github.com/wikihost-opensource/linux-toolkit/raw/main/network/bbr/centos7.sh)"
```
