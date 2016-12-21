#!/usr/bin/env sh
cd ~
wget https://bootstrap.pypa.io/get-pip.py --no-check-certificate
python get-pip.py
pip install powerline-status

yum install -y wget
yum install -y ctags

sh ~/myscripts/update.sh vimrc
