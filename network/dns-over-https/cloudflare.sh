#!/bin/bash
echo "Begin" >> ~/wikihost_cloudflare_doh_install.log
download_tool_path=''
donwload_tool_args=''
cloudflared_version='2020.9.3'
arch='amd64'

find_download_tool(){
    type wget &> /dev/null
    if [ $? -eq 0 ];then
        download_tool_path=$(which wget --skip-alias)
        donwload_tool_args=' --retry-connrefused --tries=0 -O '
        return
    fi;

    type curl &> /dev/null
    if [ $? -eq 0 ];then
        download_tool_path=$(which curl --skip-alias)
        donwload_tool_args=' --retry-connrefused --retry 0 -o '
        return
    fi;

    __log "ERROR: download tool not found"
    exit
}

download_cloudflared(){
    __run $download_tool_path $donwload_tool_args /tmp/cloudflared https://github.com/cloudflare/cloudflared/releases/download/$cloudflared_version/cloudflared-linux-$arch
    mv -f /tmp/cloudflared /usr/local/bin/cloudflared
    chmod +x /usr/local/bin/cloudflared
}

install_systemd_service(){
   echo "[Unit]
Description=Cloudflare DNS Service
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
ExecStart=/usr/local/bin/cloudflared proxy-dns

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/cloudflare-doh.service
    __run systemctl enable cloudflare-doh
}

change_resolv_conf(){
    echo "nameserver 127.0.0.1" > /etc/resolv.conf
}

__run(){
    echo ' + "'"$@"'"'
    echo ' + "'"$@"'"' >> ~/wikihost_cloudflare_doh_install.log
    $@
}

__log(){
    echo '['`date '+%Y-%m-%d %H:%M:%S'`']'$1
    echo '['`date '+%Y-%m-%d %H:%M:%S'`']'$1 >> ~/wikihost_cloudflare_doh_install.log
}

type which &> /dev/null
if [ $? -ne 0 ];then
    __log "ERROR: which command not found"
    exit
fi;

[ ! -d "/usr/local/bin" ] && __log  "ERROR: /usr/local/bin not exists" && exit

__log "INFO: looking download tools (like curl/wget)..."
find_download_tool
__log "INFO: Found download tools on: $download_tool_path"
__log "INFO: Try to download cloudflared to /tmp..."
download_cloudflared
__log "INFO: Installing cloudflare dns-over-https as service..."
install_systemd_service
__log "INFO: Starting service..."
__run chattr -i /etc/resolv.conf
__run systemctl start cloudflare-doh
__log "INFO: Backuping /etc/resolv.conf to /etc/resolv.conf.bak"
/usr/bin/cp -f /etc/resolv.conf /etc/resolv.conf.bak
__log "INFO: Writing nameserver 1.1.1.1 into /etc/resolv.conf"
change_resolv_conf
__log "INFO: Locking /etc/resolv.conf"
__run chattr +i /etc/resolv.conf
__log "INFO: Cloudflare dns-over-https has been installed"
ping -c 1 google.com || (__log "ERROR: Cloudflare dns-over-https not working" && exit)
__log "INFO: Cloudflare dns-over-https has been installed and it's working"
