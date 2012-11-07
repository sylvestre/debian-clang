#!/bin/bash

echo "apt-get -yf install clang"
apt-get -yf install clang

echo "Put dpkg on hold (http://buildd-clang.debian.net uses a patched version of dpkg)"
echo "dpkg hold" | dpkg --set-selections
