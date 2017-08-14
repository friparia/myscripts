in_array() {
  local haystack=${1}[@]
  local needle=${2}
  for i in ${!haystack}; do
    if [[ ${i} == ${needle} ]]; then
      return 0
    fi
  done
  return 1
}
args=()
COUNTER=0
while [ "$1" != "" ]; do
  args[$COUNTER]="${1}"
  echo "Arugments: ${1}" && shift;
  let COUNTER=COUNTER+1
done;

if [ $COUNTER = 0 ];then
  args=(vim zshrc ssh emacs)
fi

cd ~/myscripts/
git pull origin master

if in_array args vimrc;then
  echo "Sync vimrc..."
  cp -f ~/.vimrc ~/myscripts/.vimrc
  cp -rf ~/.vim ~/myscripts/.vim
  tar -zcvf vim.tar.gz .vim/autoload .vim/colors .vim/UltiSnips .vim/bundle/vundle
fi

if in_array args zshrc;then
  echo "Sync zshrc..."
  cp -f ~/.zshrc ~/myscripts/.zshrc
fi

if in_array args emacs;then
  echo "Sync dot spacemacs"
  cp -f ~/.spacemacs ~/myscripts/.spacemacs
fi

if in_array args ssh;then
  echo "Sync ssh config..."
  openssl rsautl -encrypt -in ~/.ssh/config -inkey ./friparia.pub -pubin -out ssh_config.de
fi

git commit -am "update config files"
git push 
