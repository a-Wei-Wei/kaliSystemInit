#!/bin/bash
#sudo passwd root
ip=192.168.95.143
hostIp=192.168.95.1
echo "=== update sshd_config === "
sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/' /etc/ssh/sshd_config
sed -i 's/^#Port 22/Port 22/' /etc/ssh/sshd_config
echo "=== restart ssh service  ==="
service ssh restart;
echo "=== register ssh service to reboot auto start ==="
systemctl enable ssh;
echo " === rewirte sources.list"
sed -i 's#deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware#deb https://mirrors.aliyun.com/kali kali-rolling main non-free contrib#' /etc/apt/sources.list
sed -i 's^# deb-src http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware^deb-src https://mirrors.aliyun.com/kali kali-rolling main non-free contrib^' /etc/apt/sources.list
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
echo "[local]\n${ip}" > /etc/ansible/hosts
echo "=== test-connect ==="
ansible all --list-hosts
ansible all -m ping
# echo " == init.yml === "
# ansible-playbook init.yml -C
echo " == 6 === "
ansible-playbook extends.yml
echo " == 7.准备挂载主机共享目录 =="
echo " === **如果挂载失败，先检查vmware中设置是否添加挂载文件夹 === "
echo " === **设置自动启动脚本 ====== "
mkdir /mnt/hgfs;
echo "#!/bin/bash\nmount -t fuse.vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other -o uid=1000\nexit 0" > /etc/rc.local
chmod +x /etc/rc.local
systemctl enable rc-local
systemctl start rc-local
echo "====== 建立软连接；"
cd /root/;ln -s /mnt/hgfs/vmware-share vmware-share;
echo " ====== 请配置 VMware 代理 后 下载 pwndbg ======"
export https_proxy=http://${hostIp}:10809
export http_proxy=http://${hostIp}:10809
export all_proxy=socks5://${hostIp}:10808
mkdir/usr/local/share/application; cd /usr/local/share/application; git clone https://github.com/pwndbg/pwndbg.git;cd pwndbg/;bash ./setup.sh;
apt update;
apt install tmux;
apt install docker.io;
apt install docker-compose;
apt install golang-go;
# 需要修改 /root/ctfPyEnv/lib/python3.13/site-packages/LibcSearcher3/main.py 中的db路径
# 安装 uv 工具，安装 weevely
pip install uv
uv tool install https://github.com/epinna/weevely3.git
ln -s /root/.local/bin/weevely /usr/bin/weevely


