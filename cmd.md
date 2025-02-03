```
创建 ZFS 存储池（ZFS Pool）
zpool create mymirrorpool mirror /dev/nvme0n5 /dev/nvme0n6
zpool create myraidpool raidz /dev/nvme0n2 /dev/nvme0n3 /dev/nvme0n4

zpool destroy myraidpool

zpool list

zpool status

创建 ZFS 文件系统
zfs create myraidpool/myfs
zfs set compression=lz4 myraidpool/myfs
zfs set compression=zstd myraidpool/myfs

zfs list
zfs get all
zfs get all myraidpool/myfs
```


```
挂载、卸载
# zfs get mountpoint
NAME             PROPERTY    VALUE             SOURCE
myraidpool       mountpoint  /myraidpool       default
myraidpool/myfs  mountpoint  /myraidpool/myfs  default

zfs get mountpoint myraidpool/myfs

zfs unmount myraidpool/myfs
zfs mount myraidpool/myfs

禁用自动挂载
zfs set mountpoint=none myraidpool/myfs

mkdir -p /data1
zfs set mountpoint=/data1 myraidpool/myfs
修改 mountpoint 自动挂载到新的路径

设置开机自动挂载
zfs set canmount=on myraidpool/myfs
zfs set mountpoint=/data1 myraidpool/myfs
```

```
zfs 创建文件系统时同时设置配额
zfs create -o quota=500M myraidpool/myfs
```

设置配额（Quota）
使用 zfs set quota 命令为文件系统设置最大空间限制。假设你希望分配 5GB 的空间给 mypool/userfs 文件系统：
zfs set quota=5G mypool/userfs
这会限制 mypool/userfs 文件系统最多只能使用 5GB 的存储空间。
配额仅适用于该文件系统及其所有子文件系统，阻止超过指定空间的写入。

使用 refquota 设置文件系统大小限制
如果你希望设置限制来限制文件系统在某个目录下占用的空间，refquota 可以让你控制“引用配额”，即该目录及其所有子文件系统的总空间限制。
zfs set refquota=5G mypool/userfs
与 quota 相似，refquota 限制的是文件系统的实际使用空间。

| 配置项 | 作用范围	| 是否包含快照	| 是否包含子数据集	| 适用场景 |
| - | -	| -	| -	| - |
| quota	| 数据集及其所有子数据集	| ✅ 是	| ✅ 是	| 限制整个数据集的总空间，包括子数据集和快照 |
| refquota	| 仅当前数据集	| ❌ 否	| ❌ 否	| 限制数据集本身的空间，不影响快照和子数据集 |



| 属性 | quota | refquota |
| - | - | - |
定义 | 限制数据集及其所有子数据集（包括快照和克隆）的总存储空间。 | 限制数据集本身直接引用的存储空间，不包括子数据集的使用量。 |
计算范围 | 当前数据集和所有子数据集的累积空间。 | 仅计算数据集本身的空间占用，不叠加子数据集的数据。 |
作用对象 | 数据集及其所有后代数据集。 | 单个数据集，仅作用于该数据集。 |
使用场景 | 当需要对整个层级结构（父数据集及其所有子数据集）设置总容量限制时。 | 当希望单独限制某个数据集的使用量，而让子数据集单独管理自己的空间时。 |
对子数据集影响 | 子数据集的使用量会累加到父数据集的 quota 限制中。 | 子数据集的空间占用不计入父数据集的 refquota 限制。 |
设置命令示例 | zfs set quota=10G mypool/myfs | zfs set refquota=10G mypool/myfs |

