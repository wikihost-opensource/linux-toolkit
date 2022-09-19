#!/bin/bash
sed -i -E 's/#?ClientAliveInterval.*/ClientAliveInterval 30/g' /etc/ssh/sshd_config
sed -i -E 's/#?ClientAliveCountMax.*/ClientAliveCountMax 6/g' /etc/ssh/sshd_config
systemctl restart sshd