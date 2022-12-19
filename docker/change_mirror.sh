#!/bin/bash
CN_MODE="0"

systemctl status docker > /dev/null
if [ $? -ne 0 ];then
    echo "[ERROR] Docker daemon is not available"
    exit
fi;
echo "[NOTICE] Checking this host is in china mainland..."

RESULT=`wget --no-check-certificate -qO - https://ipapi.co/country_code_iso3`
if [ "$RESULT" == "CHN" ];then
    echo "[INFO] Selected CN Docker mirror server"
    CN_MODE="1"
fi;

if [ -f "/etc/docker/daemon.json" ];then
    echo "[ERROR] /etc/docker/daemon.json exists."
    exit 1
fi;

echo "[INFO] writing /etc/docker/daemon.json"

if [ "$CN_MODE" -eq 0 ];then
    wget -6 --no-check-certificate -q -O /dev/null https://ipapi.co/country_code_iso3
    if [ $? -eq 0 ];then
      echo "[INFO] Server support ipv6, using registry.ipv6.docker.com"
      echo "{
  \"registry-mirrors\": [\"https://registry.ipv6.docker.com\"]
}" > /etc/docker/daemon.json
    else
      echo "[INFO] Selected Google docker mirror server"
      echo "{
  \"registry-mirrors\": [\"https://mirror.gcr.io\"]
}" > /etc/docker/daemon.json
    fi;
else
    echo "{
  \"registry-mirrors\": [
    \"https://hub-mirror.c.163.com\",
    \"https://docker.nju.edu.cn\",
    \"https://dockerproxy.com\",
    \"https://hub-mirror.c.163.com\",
    \"https://mirror.baidubce.com\"
  ]
}" > /etc/docker/daemon.json
fi;

echo "[INFO] restarting docker daemon"
systemctl restart docker
echo "[INFO] OK"
