#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
TZ='UTC'; export TZ

umask 022

CC=gcc
export CC
CXX=g++
export CXX
/sbin/ldconfig

set -e

_tmp_dir="$(mktemp -d)"
cd "${_tmp_dir}"

TAGS=$(wget -qO- 'https://github.com/openzfs/zfs/tags' | \
       grep -i 'href="/.*/releases/tag/' | \
       sed 's|"|\n|g' | \
       grep -i '/releases/tag/' | \
       sed 's|.*/tag/||g' | grep -iv 'rc' | grep -v '\.99' | \
       grep '2\.3\.' | sort -V | uniq | sort -r)
CONTENT=''
ALL_CONTENT=''
for tag in $TAGS; do
    URL="https://github.com/openzfs/zfs/releases/expanded_assets/${tag}"
    CONTENT=$(wget -qO- "$URL")
    ALL_CONTENT+="$CONTENT\n"
done
_release_time=$(echo "${ALL_CONTENT}" | grep -i '\.tar' | grep -i '/openzfs/zfs/releases/download/zfs' | sed 's|"|\n|g' | grep -i '/openzfs/zfs/releases/download/zfs' | grep -iv '\.asc' | sed 's|.*download/||g' | awk -F/ '{print $1}' | sed 's|zfs-||g' | sort -V | tail -n 1)
_release_ver=$(echo "${ALL_CONTENT}" | grep -i '\.tar' | grep -i '/openzfs/zfs/releases/download/zfs' | sed 's|"|\n|g' | grep -i '/openzfs/zfs/releases/download/zfs' | grep -iv '\.asc' | sed 's|.*download/||g' | awk -F/ '{print $2}' | sed -e 's|zfs-||g' -e 's|\.tar.*||g' | sort -V | tail -n 1)
wget "https://github.com/openzfs/zfs/releases/download/zfs-${_release_time}/zfs-${_release_ver}.tar.gz"
CONTENT=''
ALL_CONTENT=''

tar -xof zfs-*.tar*
sleep 1
rm -f zfs-*.tar*
cd zfs-*
. /opt/rh/gcc-toolset-12/enable
./configure
make -j1 rpm-utils rpm-kmod

rm -fr /tmp/zfs
mkdir -p /tmp/zfs/zfs-kmod/packages
cp -afr *.rpm /tmp/zfs/zfs-kmod/packages/
cd /tmp/zfs/zfs-kmod
createrepo -v .
sleep 2
cd /tmp/zfs
_kernel_ver=$(ls -1 /tmp/zfs/zfs-kmod/packages/kmod-zfs-[1-9]*.rpm | grep -iv 'debug' | awk -F/ '{print $NF}' | sed -e 's|kmod-zfs-||g' -e 's|\.x86_64-.*|.x86_64|g' | sort -V | tail -n 1)
mv -v zfs-kmod zfs-kmod-${_release_ver}-${_kernel_ver}
echo
sleep 1
tar -zcvf zfs-kmod-${_release_ver}-${_kernel_ver}.tar.gz zfs-kmod-${_release_ver}-${_kernel_ver}
echo
sleep 1
rm -fr zfs-kmod-${_release_ver}-${_kernel_ver}
cd /tmp
rm -fr "${_tmp_dir}"
echo
echo ' zfs-kmod done'
echo
exit

