#!/bin/bash
if [ ! -f "/etc/redhat-release" ]; then
    echo "ERROR: This script only for CentOS Linux"
    exit;
fi

if [ -z "`cat /etc/redhat-release | grep 'release 7'`" ]; then
    echo "ERROR: This script only for CentOS Linux 7 (Aka CentOS 7)"
    exit;
fi;
echo "Enable and install centos offical kernel repo"
(yum install yum-utils -y && yum-config-manager --enable centos-kernel && yum upgrade kernel -y && yum install kernel-modules-extra -y) || (echo "ERROR: Failed to install new kernel" && exit)
echo 'net.core.default_qdisc=fq' > /etc/sysctl.d/99-bbr.conf
echo 'net.ipv4.tcp_congestion_control=bbr' >> /etc/sysctl.d/99-bbr.conf
echo "Done, Please type [reboot] to reboot the system, apply new kernel and new kernel argument(enable bbr)"
