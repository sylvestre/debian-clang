#!/bin/bash

echo "deb http://ftp.fr.debian.org/debian/ experimental main" > /etc/apt/sources.list.d/clang.list

echo "Install of clang"
apt-get update
aptitude -y --without-recommends install cpp g++ gcc clang -t experimental 
#apt-get install --yes --no-install-recommends clang -t experimental

echo "Replace gcc, g++ & cpp by clang"
VERSIONS="4.8 4.7"
for VERSION in $VERSIONS; do
cd /usr/bin
rm g++-$VERSION gcc-$VERSION cpp-$VERSION
ln -s clang++ g++-$VERSION
ln -s clang gcc-$VERSION
ln -s clang cpp-$VERSION
cd -

echo "Block the installation of new gcc version $VERSION"
echo "gcc-$VERSION hold"|dpkg --set-selections
echo "cpp-$VERSION hold"|dpkg --set-selections
echo "g++-$VERSION hold"|dpkg --set-selections
done

echo "Check if gcc, g++ & cpp are actually clang"
gcc --version|grep clang > /dev/null || exit 1

#echo "Put dpkg on hold (http://buildd-clang.debian.net uses a patched version of dpkg)"
#echo "dpkg hold" | dpkg --set-selections
