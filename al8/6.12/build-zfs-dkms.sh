#!/usr/bin/env bash
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
TZ='UTC'; export TZ

umask 022

CC=gcc
export CC
CXX=g++
export CXX
/sbin/ldconfig

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
make -j1 rpm-utils rpm-dkms

rm -fr /tmp/zfs
mkdir -p /tmp/zfs/zfs-dkms/packages
cp -afr *.rpm /tmp/zfs/zfs-dkms/packages/
cd /tmp/zfs/zfs-dkms
createrepo -v .
sleep 2
cd /tmp/zfs
_kernel_ver=$(rpm -qa | grep -i 'kernel-[6789].*el[1-9]' | sed -e 's|kernel-||g' | sort -V | tail -n 1)
mv -v zfs-dkms zfs-dkms-${_release_ver}-${_kernel_ver}
echo
sleep 1
tar -zcvf zfs-dkms-${_release_ver}-${_kernel_ver}.tar.gz zfs-dkms-${_release_ver}-${_kernel_ver}
echo
sleep 1
rm -fr zfs-dkms-${_release_ver}-${_kernel_ver}
cd /tmp
rm -fr "${_tmp_dir}"
echo
echo ' zfs-dkms done'
echo
exit

