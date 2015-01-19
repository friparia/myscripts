cd ~
wget http://mirrors.yun-idc.com/epel/5/x86_64/epel-release-5-4.noarch.rpm
rpm -ivh epel-release-5-4.noarch.rpm
yum install -y zsh
sed -i "s/bash/zsh/g" /etc/passwd
curl -L http://install.ohmyz.sh | sh
sed -i "s/^ZSH_THEME=.*$/ZSH_THEME=\"agnoster\"/g" ~/.zshrc
sed -i "s/^plugins=.*$/plugins=\(git-flow laravel4 composer git autojump\)/g" ~/.zshrc
cd ~
zsh


