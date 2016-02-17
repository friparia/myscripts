cd ~
yum --enablerepo=base install zsh -y
chsh -s /bin/zsh
curl -L http://install.ohmyz.sh | sh
sed -i "s/^ZSH_THEME=.*$/ZSH_THEME=\"agnoster\"/g" ~/.zshrc
sed -i "s/^plugins=.*$/plugins=\(git-flow laravel4 composer git autojump\)/g" ~/.zshrc
cd ~
zsh


