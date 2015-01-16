cd ~
wget http://mirrors.yun-idc.com/epel/5/x86_64/epel-release-5-4.noarch.rpm
rpm -ivh epel-release-5-4.noarch.rpm
yum install -y zsh
sed -i "s/bash/zsh/g" /etc/passwd
curl -L http://install.ohmyz.sh | sh
sed -i "s/^ZSH_THEME=.*$/ZSH_THEME=\"geoffgarside\"/g" ~/.zshrc
sed -i "s/^plugins=.*$/plugins=\(git-flow laravel4 composer git autojump\)/g" ~/.zshrc
echo "LS_COLORS='di=00;35;36:'" >> ~/.zshrc
echo "export LS_COLORS" >> ~/.zshrc
cd ~
zsh


