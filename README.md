# CentOS first script to run

# Setup Zram
```
#16G zram (Make sure you have enough 1.5/2.0x ram)
wget -O /etc/systemd/system/zram.service https://github.com/wikihost-opensource/centos-init/raw/main/zram.service && systemctl enable --now zram
```
