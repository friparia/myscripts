cd ~
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
yum install -y zsh
sed -i "s/bash/zsh/g" /etc/passwd
curl -L http://install.ohmyz.sh | sh
sed -i "s/^ZSH_THEME=.*$/ZSH_THEME=\"agnoster\"/g" ~/.zshrc
sed -i "s/^plugins=.*$/plugins=\(git-flow laravel4 composer git autojump\)/g" ~/.zshrc
cd ~
zsh


