yum remove $(rpm -qa | grep ^vim)
mkdir -p /opt/pkgs
cd /opt/pkgs
wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar jxvf vim-7.4.tar.bz2
cd vim74
yum install gcc make ncurses-devel
./configure --disable-selinux --enable-multibyte --with-features=huge
make
make install
hash -r
