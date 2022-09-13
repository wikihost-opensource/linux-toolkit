#!/bin/bash
CN_MODE="0"
MIRROR_URL="https://mirror.gcr.io"

systemctl status docker > /dev/null
if [ $? -ne 0 ];then
    echo "[ERROR] Docker daemon is not available"
    exit
fi;
echo "[NOTICE] Checking this host is in china mainland..."

RESULT=`wget --no-check-certificate -qO - https://ifconfig.co/country-iso`
if [ "$RESULT" == "CN" ];then
    echo "[INFO] Selected CN Docker mirror server"
    CN_MODE="1"
    MIRROR_URL="https://docker.mirrors.ustc.edu.cn/"
else
    echo "[INFO] Selected Google docker mirror server"
fi;
echo "[INFO] New mirror server url: ${MIRROR_URL}"

if [ -f "/etc/docker/daemon.json" ];then
    echo "[ERROR] /etc/docker/daemon.json exists."
    exit 1
fi;

echo "[INFO] writing /etc/docker/daemon.json"

echo "{
  \"registry-mirrors\": [\"https://mirror.gcr.io\"]
}" > /etc/docker/daemon.json

echo "[INFO] restarting docker daemon"
systemctl restart docker
echo "[INFO] OK"