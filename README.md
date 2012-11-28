Series of patches/scripts for the usage of clang in a Debian sbuild service

**dpkg-clang.patch**
Patch in dpkg to export the various compiler variables (CC, CXX, etc).

**clang-setup.sh**
Install clang and make sure dpkg is not updated (since we use a patched version)

**gcc-replacement.sh**
Script to kill any usage of gcc/g++/cpp

**purge-gcc-setup-clang.sh**
Remove all instances of cpp/g++ & gcc + configure clang as /usr/bin/cc & /usr/bin/c++

**sbuild.patch**
To plug pre build hooks (after the apt-get install)
`
"chroot-pre-build-commands" => [
      	['/root/purge-gcc-setup-clang.sh'],
],
`
in .sbuildrc

**builddrc**
The configuration of the buildd service

**sbuildrc**
The hooks to be started to setup the env
