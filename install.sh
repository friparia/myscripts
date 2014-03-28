#!/usr/bin/env sh
if [ -z "$1" ];then
  if [ -e "~/vimrc.tar.gz" ]
    echo -e '\033[041mYou already have your vimrc package download! Check it and remove it\033[0m'
  fi
  wget -O ~/vimrc.tar.gz www.friparia.com/vimrc.tar.gz
  tar -zxvf ~/vimrc.tar.gz
  if [ -d "~/.vim/" ]; then 
    rm -rf ~/.vim
    mkdir ~/.vim
  else
    mkdir ~/.vim
  fi
  cp ~/vimrc ~/.vimrc
  rm ~/vimrc
  echo -e '\033[32mOK!\033[0m'
  exit
elif [ "$1" = "--fast" ];then
  echo -e ""
  exit
elif [ "$1" = "--github" ];then
  echo -e '\033[31mclean install\033[0m'
  exit
else
  echo -e '\033[041mwrong parameter!\033[0m'
  exit
fi



