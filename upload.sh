cd ~/myscripts/
git pull
cp -f ~/.zshrc ~/myscripts/.zshrc
cp -f ~/.vimrc ~/myscripts/.vimrc
tar -zcvf vim.tar.gz ~/.vim/autoload ~/.vim/colors ~/.vim/UltiSnips ~/.vim/bundle/vundle
git commit -am "update rc files"
git push 
