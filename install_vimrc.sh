#!/usr/bin/env sh
if [ -z $1 ];then
  if [ -e ~/vimrc.tar.gz ];then
    echo -e '\033[041mYou already have your vimrc package download! Check it and remove it\033[0m'
    exit
  fi
  #need to write more check
  wget -O ~/vimrc.tar.gz www.friparia.com/vimrc.tar.gz
  mkdir ~/vimrc
  tar -zxvf ~/vimrc.tar.gz -C ~/vimrc
  if [ -d ~/.vim/ ]; then 
    rm -rf ~/.vim
    mkdir ~/.vim
  else
    mkdir ~/.vim
  fi
  cp -rf ~/vimrc/.vim/* ~/.vim/
  rm -rf ~/vimrc
  rm -rf ~/vimrc.tar.gz
  wget -O ~/.vimrc --no-check-certificate https://raw.githubusercontent.com/friparia/myscripts/master/.vimrc
  echo -e '\033[32mInstall Success!\033[0m'
  exit
elif [ $1 = --fast ];then
  echo -e ""
  exit
elif [ $1 = --update ];then
  echo -e ""
  exit
elif [ $1 = --github ];then
  echo -e '\033[31mclean install\033[0m'
  exit
else
  echo -e '\033[041mwrong parameter!\033[0m'
  exit
fi



