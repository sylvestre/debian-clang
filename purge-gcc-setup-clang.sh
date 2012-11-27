#!/bin/bash
# Here, we have two choice:
# * replace gcc by clang
# * fails on the usage of gcc

echo "Check if we are using the patched version of dpkg"
grep CC /usr/bin/dpkg-buildpackage >/dev/null|| (echo "Not using the dpkg patched version. Please contact sylvestre@debian.org"; exit 2)

echo "Set up the gcc/g++ hooks to make sure gcc/g++ are not used"
VERSIONS="4.7 4.6"
cd /usr/bin
echo "in /usr/bin/"
for VERSION in $VERSIONS; do

    CMDS="g++ gcc cpp"
    for CMD in $CMDS; do
	echo "rm $CMD-$VERSION"
	rm $CMD-$VERSION
	echo "cp /root/gcc-replacement.sh $CMD-$VERSION"
	cp /root/gcc-replacement.sh $CMD-$VERSION
    done
done
cd -

echo "update-alternatives --set cc /usr/bin/clang"
update-alternatives --set cc /usr/bin/clang

echo "update-alternatives --set c++ /usr/bin/clang++"
update-alternatives --set c++ /usr/bin/clang++

echo "CC = $CC"
echo "CXX = $CXX"
echo "/usr/bin/cc = $(readlink /etc/alternatives/cc)"
echo "/usr/bin/c++ = $(readlink /etc/alternatives/c++)"
