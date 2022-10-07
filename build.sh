#!/bin/sh

# version of openssh to be based on
openssh="openssh-9.0p1"

# must be a absolute path
installDir="/baithook"

# build tools
echo "installing wget"
yum -y install wget
echo "installing gcc-g++"
yum -y install gcc-c++
echo "installing make"
yum -y install make

# libs
echo "installing zlib and zlib-devel"
yum -y install zlib zlib-devel
echo "installing openssl-devel"
yum -y install openssl-devel

# source code of openssh
echo "pulling ${openssh}"
wget https://mirror.leaseweb.com/pub/OpenBSD/OpenSSH/portable/${openssh}.tar.gz
if [ ! -f "${openssh}.tar.gz"  ]; then
     echo "no such file: ${openssh}.tar.gz"
     exit
fi
echo "uncompressing ${openssh}.tar.gz"
tar -zxvf ${openssh}.tar.gz

# replace files
cp auth-passwd.c ${openssh}/
cp sshd_config ${openssh}/
cp version.h ${openssh}/

# for error  "Privilege separation user sshd does not exist" :
echo "sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin" >> /etc/passwd

# make openssh
mkdir ${installDir}
cd ${openssh}/
./configure --sysconfdir=${installDir}/ --without-zlib-version-check --with-md5-passwords --prefix=${installDir}/
make
make install
cd ..

# update path
echo "PATH=$PATH:${installDir}/bin:${installDir}/sbin" >> ~/.bashrc

# make /run.sh
echo '#!/bin/sh' >> /run.sh
echo "${installDir}/sbin/sshd -f ${installDir}/sshd_config" >> /run.sh
echo '# also use options below to save log.' >> /run.sh
echo "#${installDir}/sbin/sshd -f ${installDir}/sshd_config -E /baithook.log" >> /run.sh
echo '# if you are using container, run bash as a long-term process' >> /run.sh
echo "bash" >> /run.sh
chmod u+x /run.sh

# copy LICENCE file
cp LICENCE ${installDir}/