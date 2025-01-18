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
depmod -a "$(ls -1 /lib/modules/ | sort -V | tail -n 1)"
depmod -a "$(uname -r)"
```

