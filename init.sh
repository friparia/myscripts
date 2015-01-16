cd ~
wget http://mirrors.yun-idc.com/epel/5/x86_64/epel-release-5-4.noarch.rpm
rpm -ivh epel-release-5-4.noarch.rpm
yum install -y zsh
sed "s/bash/zsh/g" /etc/passwd
git clone git://github.com/joelthelion/autojump.git
cd autojump
./install.py
