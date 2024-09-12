#!/bin/sh
#sudo passwd root
ip=192.168.95.131
echo "=== update sshd_config === "
sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/' /etc/ssh/sshd_config
sed -i 's/^#Port 22/Port 22/' /etc/ssh/sshd_config
echo "=== restart ssh service  ==="
service ssh restart
echo " == mkdir .pip == "
sudo mkdir ~/.pip
echo "[global]\nindex-url = https://mirrors.aliyun.com/pypi/simple/\n[install]\ntrusted-host=mirrors.aliyun.com" > ~/.pip/pip.conf
echo " == install ansible == "
python3 -m pip install  ansible
echo " == create ansible directory == "
sudo mkdir /etc/ansible
sudo touch /etc/ansible/hosts
echo " == generate ssh == "
ssh-keygen -t RSA -N '' -f ~/.ssh/id_rsa
service ssh restart 
sudo ssh-copy-id -i /root/.ssh/id_rsa.pub ${ip}
echo "[local]\n${ip}" > /etc/ansible/hosts
echo "=== test-connect ==="
ansible all --list-hosts
ansible all -m ping
echo " == init.yml === "
ansible-playbook init.yml -C
echo " == 6 === "
ansible-playbook init.yml
