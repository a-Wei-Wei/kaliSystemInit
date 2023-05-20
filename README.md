# kaliSystemInit
## 通过自动化运维工具ansible，安装平时kali常用的软件
### ====> 意味着下次kalli更新，可以直接删除虚拟机，然后不用重新配置常用的软件，将配置的动作交给ansible
#### 1、进入新的kali，先执行 su passwd root
#### 2、su - root ，再拷贝本仓库
#### 3、先执行 sh init.sh 配置 pip的源、下载ansible等基础工作，并且自动执行 ansible-playbook init.yml。
#### 4、需要安装其他的软件，或者配置 直接补充 extend-*.ym; 再使用ansible-playbook 执行 *.yml 安装常用软件和配置等。依次执行，也可以将extend-*.yml 手工合并在一起。
