# How to use
Just copy and paste to your shell, Press [enter] and the config will be automatically deploy

## Setup zram (systemd required)
### 16G zram setup
```
wget -O /etc/systemd/system/zram.service https://github.com/wikihost-opensource/centos-init/raw/main/system/zram/16g.service && systemctl enable zram && systemctl restart zram
```
### 8G zram setup
```
wget -O /etc/systemd/system/zram.service https://github.com/wikihost-opensource/centos-init/raw/main/system/zram/8g.service && systemctl enable --now zram && systemctl restart zram
```
### 4G zram setup
```
wget -O /etc/systemd/system/zram.service https://github.com/wikihost-opensource/centos-init/raw/main/system/zram/4g.service && systemctl enable zram && systemctl restart zram
```
### 2G zram setup
```
wget -O /etc/systemd/system/zram.service https://github.com/wikihost-opensource/centos-init/raw/main/system/zram/2g.service && systemctl enable zram && systemctl restart zram
```
## Using DoH Service
### Cloudflare
```
bash -c "$(wget -qO - https://github.com/wikihost-opensource/centos-init/raw/main/network/dns-over-https/cloudflare.sh)"
```
## Enable BBR
### For CentOS 7
```
bash -c "$(wget -qO - https://github.com/wikihost-opensource/centos-init/raw/main/network/bbr/centos7.sh)"
```
