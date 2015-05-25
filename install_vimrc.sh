#!/usr/bin/env sh
cd ~
wget https://bootstrap.pypa.io/get-pip.py --no-check-certificate
python get-pip.py
pip install powerline-status

yum install -y wget
yum install -y ctags
FILESERVERHOST=( 10.3.18.186 file.friparia.com )
FILESERVERDIR=( /frip "")
echo -e "\033[032mCalculating fastest mirror\033[0m"
i=0
fastspeed=2000
selected=0

while [ $i -lt ${#FILESERVERHOST[*]} ] 
do
  speed=`ping -c2 ${FILESERVERHOST[$i]} | grep ^rtt | cut -d '/' -f5`
  speed=${speed/\.*}
  if [ $fastspeed -ge $speed ];then
    fastspeed=$speed
    selected=$i
  fi
  let i++
done

FASTFILESERVER=${FILESERVERHOST[$selected]}
FASTFILESERVERDIR=${FILESERVERDIR[$selected]}
echo -e "\033[032mThe fastest host is $FASTFILESERVER\033[0m"


if [ -z $1 ];then
  if [ -e ~/vimrc.tar.gz ];then
    echo -e '\033[041mYou already have your vimrc package download! Check it and remove it\033[0m'
    exit
  fi
  #need to write more check
  wget -O ~/vimrc.tar.gz $FASTFILESERVER/$FASTFILESERVERDIR/vimrc.tar.gz
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
  # vim +BundleInstall! +BundleClean +q
  exit
else
  echo -e '\033[041mwrong parameter!\033[0m'
  exit
fi

