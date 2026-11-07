# kaliSystemInit
## 通过自动化运维工具ansible，安装平时kali常用的软件
### ====> 意味着下次kalli更新，可以直接删除虚拟机，然后不用重新配置常用的软件，将配置的动作交给ansible
#### 1、进入新的kali，先执行 su passwd root
#### 2、su - root ，再拷贝本仓库
#### 3、先执行 sh init.sh 配置 pip的源、下载ansible等基础工作。

注意修改init.sh中的ip地址

#### 4、需要安装其他的软件，或者配置 直接补充 extend-*.ym; 再使用ansible-playbook 执行 *.yml 安装常用软件和配置等。依次执行，也可以将extend-*.yml 手工合并在一起。

5、新版kali需要安装python 的虚拟环境，然后所有安装的包均在虚拟环境中进行安装，所以为了sh能够正常运行先进行虚拟环境的安装，然后切换至虚拟环境再sh init.sh

​	python3 -m venv /root/ctfPyEnv
​	source /root/ctfPyEnv/bin/activate

6、安装docker，直接使用阿里云的资源

​	apt install docker.io ; docker-compose

​	进入到vmware-share文件夹中，找到环境配置，直接docker load -i xxxx.tar 导入镜像
