# kaliSystemInit
## 通过自动化运维工具ansible，安装平时kali常用的软件
### 意味着下次kalli更新，可以直接删除虚拟机，然后不用重新配置常用的软件，将配置的动作交给ansible
### 进入新的kali，先执行 su passwd root
### su - root ，再拷贝本仓库
### 1、先执行 sh init.sh 配置 pip的源、下载ansible等基础工作
### 2、再使用ansible-playbook 执行 init.yml 安装常用软件和配置等。依次执行，也可以将extend-*.yml 手工合并在一起。
