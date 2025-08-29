#!/bin/bash
#sudo passwd root
ip=192.168.95.139
hostIp=192.168.95.1
echo "=== update sshd_config === "
sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/' /etc/ssh/sshd_config
sed -i 's/^#Port 22/Port 22/' /etc/ssh/sshd_config
echo "=== restart ssh service  ==="
service ssh restart;
echo "=== register ssh service to reboot auto start ==="
systemctl enable ssh;
echo " == mkdir .pip == "
sudo mkdir ~/.pip
echo "[global]\nindex-url = https://mirrors.aliyun.com/pypi/simple/\n[install]\ntrusted-host=mirrors.aliyun.com" > ~/.pip/pip.conf
echo " == install ansible venv == "
python3 -m venv /root/ctfPyEnv
source /root/ctfPyEnv/bin/activate
python3 -m pip install ansible
python3 -m pip install pwntools
python3 -m pip install LibcSearcher3
python3 -m pip install requests
echo " == create ansible directory == "
sudo mkdir /etc/ansible
sudo touch /etc/ansible/hosts
echo " == generate ssh == "
ssh-keygen -t RSA -N '' -f ~/.ssh/id_rsa
service ssh restart 
sudo ssh-copy-id -i /root/.ssh/id_rsa.pub ${ip}
echo -e "[local]\n${ip}" > /etc/ansible/hosts
echo "=== test-connect ==="
ansible all --list-hosts
ansible all -m ping
# echo " == init.yml === "
# ansible-playbook init.yml -C
echo " == 6 === "
ansible-playbook extends.yml
echo " == 准备挂载主机共享目录 =="
mkdir /mnt/hgfs;mount -t fuse.vmhgfs-fuse .host:/ /mnt/hgfs/ -o allow_other -o uid=1000
echo " ====== 请配置 VMware 代理 后 下载 pwndbg ======"
export https_proxy=http://${hostIp}:10809
export http_proxy=http://${hostIp}:10809
export all_proxy=socks5://${hostIp}:10809
cd /usr/local/share/application; git clone https://github.com/pwndbg/pwndbg.git;cd pwndbg/;bash ./setup.sh;





