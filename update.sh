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

git pull origin master

if in_array args vimrc;then
  echo "Updating vimrc..."
  cp -f ~/myscripts/.vimrc ~/.vimrc
  d=`date +"%Y-%m-%d_%T"`
  mv ~/.vim ~/.vim.bak.$d
  tar -zxvf vim.tar.gz
  mv ./root/.vim ~/.vim
  vim +BundleInstall +qa
fi

if in_array args zshrc;then
  echo "Updating zshrc..."
  cp -f ~/myscripts/.zshrc ~/.zshrc
  cp -f ./agnoster.zsh-theme ~/.oh-my-zsh/themes/.
fi

if in_array args emacs;then
  echo "Updating dot spacemacs"
  cp -f ~/myscripts/.spacemacs ~/.spacemacs
fi

if in_array args ssh;then
  echo "Updating ssh config..."
  openssl rsautl -decrypt -in ./ssh_config.de -inkey ~/.ssh/friparia.key -out ~/.ssh/config
fi

