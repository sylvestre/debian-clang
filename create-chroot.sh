#!/bin/bash
mkdir -p /srv/chroot/
cd /srv/chroot
distribution=sid
architecture=amd64
mkdir -p /srv/chroot/$distribution-$architecture-sbuild
debootstrap $distribution /srv/chroot/$distribution-$architecture-sbuild
chown -R buildd:buildd /srv/chroot/$distribution-$architecture-sbuild
sbuild-update --keygen

usersfile=/srv/chroot/$distribution-$architecture-sbuild/root/users

echo "#\!/bin/sh" > "$usersfile"
echo "groupadd -g $(id -g buildd) buildd" >> "$usersfile"
echo "useradd -u $(id -u buildd) -g $(id -g buildd) buildd" >> "$usersfile"
echo "groupadd -g $(id -g sbuild) sbuild" >> "$usersfile"
echo "useradd -u $(id -u sbuild) -g $(id -g sbuild) sbuild" >> "$usersfile"
chmod a+x "$usersfile"

chroot /srv/chroot/$distribution-$architecture-sbuild/ /root/users
git clone https://github.com/sylvestre/debian-clang.git
cd /usr/share/perl5/
patch -p2 < /srv/chroot/debian-clang/sbuild.patch
cd /srv/chroot/sid-amd64-sbuild/root/
ln  ../../debian-clang/clang-setup.sh
