cp -f ~/myscripts/.zshrc ~/.zshrc
cp -f ~/myscripts/.vimrc ~/.vimrc
d=`date +"%Y-%m-%d_%T"`
mv ~/.vim ~/.vim.bak.$d
tar -zxvf vim.tar.gz
mv ./root/.vim ~/.vim
vim +BundleInstall +qa
sh ./update_agnoster_theme.sh
