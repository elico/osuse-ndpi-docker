#!/usr/bin/env bash

cd /build
rm -rf ./nDPI
git clone -b netfilter https://github.com/vel21ripn/nDPI.git
cd nDPI
./autogen.sh
# The autogen should run configure automatically
#./configure
declare -x PKG_CONFIG=`which pkg-config`
KERNEL_VERSION=`ls /lib/modules/`
# Patch files
#a/ndpi-netfilter/ipt/Makefile
# pkg-config xtables --cflags 
ls /build/
mkdir /build/destdir
#declare -x  DESTDIR=/build/destdir/
ls
sed -i -e 's/-DOPENDPI_NETFILTER_MODULE/$(shell pkg-config --cflags xtables)/g' ndpi-netfilter/ipt/Makefile && \
sed -i -e 's@MODULES_DIR := /lib/modules/$(shell uname -r)@MODULES_DIR := /lib/modules/$(shell ls /lib/modules/)@g' ndpi-netfilter/src/Makefile && \
sed -i -e 's/depmod -a/depmod -a $(shell ls \/lib\/modules\/)/g' ndpi-netfilter/src/Makefile && \
cd ndpi-netfilter/ && \
make -j9 && \
make install && \
make modules_install && \
echo $?
mkdir -p /build/destdir/usr/lib64/xtables/ && \
cp /usr/lib64/xtables/libxt_NDPI.so /build/destdir/usr/lib64/xtables/ && \
mkdir -p /build/destdir/lib/modules/$KERNEL_VERSION/extra/ && \
cp /build/nDPI/ndpi-netfilter/src/xt_ndpi.ko /build/destdir/lib/modules/$KERNEL_VERSION/extra/xt_ndpi.ko && \
cp /build/nDPI/ndpi-netfilter/src/xt_ndpi.ko /build/destdir/lib/modules/$KERNEL_VERSION/extra/xt_ndpi.ko-non-stripped && \
cd /build/destdir/usr/lib64/xtables/ && \
ln -s libxt_NDPI.so libxt_ndpi.so && \
echo $?

strip --strip-debug /build/destdir/lib/modules/$KERNEL_VERSION/extra/xt_ndpi.ko

#modprobe xt_ndpi && lsmod|grep ndpi
#patch -p0 < /build/ipt-makefile.patch && \
#patch -p0 < /build/src-makefile.patch && \

