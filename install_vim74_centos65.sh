yum remove $(rpm -qa | grep ^vim)
mkdir -p /opt/pkgs
cd /opt/pkgs
wget http://zlib.net/zlib-1.2.8.tar.gz
tar zxf zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure
make
make install
cd /opt/pkgs
yum install openssl openssl-devel
wget https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tgz --no-check-certificate
tar zxf Python-2.7.9.tgz
cd Python-2.7.9
./configure
make
make install
cd /opt/pkgs
wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar jxvf vim-7.4.tar.bz2
cd /opt/pkgs
wget https://bootstrap.pypa.io/get-pip.py --no-check-certificate
python get-pip.py
pip install powerline-status
cd /opt/pkgs
cd vim74
yum install gcc make ncurses-devel
updatedb
pyconfig=`echo | locate python | grep 'python2.7/config$'`
./configure --disable-selinux --enable-multibyte --with-features=huge --with-python-config-dir=$pyconfig --enable-pythoninterp
make
make install
hash -r
