### /etc/yum.repos.d/zfs.repo
```
[zfs-dkms]
name=ZFS on Linux for EL$releasever - dkms
baseurl = file:///.repos/zfs-dkms
enabled = 0
gpgcheck = 0
proxy=_none_

[zfs-kmod]
name = ZFS on Linux for EL$releasever - kmod
baseurl = file:///.repos/zfs-kmod
enabled = 1
gpgcheck = 0
proxy=_none_

```

```
echo 'zfs' > /etc/modules-load.d/zfs.conf
```

```
# update kmod-zfs
yum list | grep -i kmod-zfs
kmod-zfs-6.12.11-20250124.el9.x86_64.x86_64                                              2.3.0-1.el9                          @zfs-kmod                   
kmod-zfs-6.12.12-20250202.el9.x86_64.x86_64                                              2.3.0-1.el9                          zfs-kmod                    

yum install kmod-zfs-6.12.12-20250202.el9.x86_64-2.3.0-1.el9

yum reinstall zfs libnvpair3 libuutil3 libzfs6 libzpool6
```

```
# /lib/modules/ 下的文件夹名
depmod -a "$(ls -1 /lib/modules/ | sort -V | tail -n 1)"
depmod -a "$(uname -r)"
```



