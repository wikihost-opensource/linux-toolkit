# CentOS first script to run

# Setup zram
## This script will setup 16G zram to use, Only for 32G+ ram system to use.
```
wget -O /etc/systemd/system/zram.service https://github.com/wikihost-opensource/centos-init/raw/main/zram.service && systemctl enable --now zram
```
