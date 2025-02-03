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

yum erase zfs libnvpair3 libuutil3 libzfs6 libzpool6

```

```
# /lib/modules/ 下的文件夹名
depmod -a "$(ls -1 /lib/modules/ | sort -V | tail -n 1)"
depmod -a "$(uname -r)"
```

zfs-dkms 需要现场编译，费时间，做好用 zfs-kmod

```
# 如果 dkms 没有生成 zfs.ko, 要重装 zfs-dkms, 马上编译
yum reinstall zfs-dkms

```
```
yum reinstall -y zfs-dkms
===============================================================================================================================================================================================================
 Package                                          Architecture                                   Version                                                Repository                                        Size
===============================================================================================================================================================================================================
Reinstalling:
 zfs-dkms                                         noarch                                         2.3.0-1.el9                                            zfs-dkms                                          31 M

Transaction Summary
===============================================================================================================================================================================================================

Total size: 31 M
Installed size: 57 M
Is this ok [y/N]: y
Downloading Packages:
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                                                                                       1/1 
  Running scriptlet: zfs-dkms-2.3.0-1.el9.noarch                                                                                                                                                           1/2 
Running pre installation script: /var/tmp/rpm-tmp.kq7RCM. Parameters: 2
Removing zfs dkms modules version 2.3.0 from all kernels.

Deleting module zfs/2.3.0 completely from the DKMS tree.

  Reinstalling     : zfs-dkms-2.3.0-1.el9.noarch                                                                                                                                                           1/2 
  Running scriptlet: zfs-dkms-2.3.0-1.el9.noarch                                                                                                                                                           1/2 
Running post installation script: /var/tmp/rpm-tmp.LIqknP. Parameters: 2
Adding zfs dkms modules version 2.3.0 to dkms.
Creating symlink /var/lib/dkms/zfs/2.3.0/source -> /usr/src/zfs-2.3.0
Installing zfs dkms modules version 2.3.0 for the current kernel.

Sign command: /lib/modules/6.12.11-20250124.el9.x86_64/build/scripts/sign-file
Signing key: /var/lib/dkms/mok.key
Public certificate (MOK): /var/lib/dkms/mok.pub
Certificate or key are missing, generating self signed certificate for MOK...

Running the pre_build script:
checking for gawk... gawk
checking metadata... META file
checking build system type... x86_64-pc-linux-gnu
checking host system type... x86_64-pc-linux-gnu
checking target system type... x86_64-pc-linux-gnu
checking whether to enable maintainer-specific portions of Makefiles... no
checking whether make supports nested variables... yes
checking for a BSD-compatible install... /bin/install -c
checking whether build environment is sane... yes
checking for a race-free mkdir -p... /bin/mkdir -p
checking whether make sets $(MAKE)... yes
checking how to print strings... printf
checking whether make supports the include directive... yes (GNU style)
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables... 
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether the compiler supports GNU C... yes
checking whether gcc accepts -g... yes
checking for gcc option to enable C11 features... none needed
checking whether gcc understands -c and -o together... yes
checking dependency style of gcc... none
checking for a sed that does not truncate output... /bin/sed
checking for grep that handles long lines and -e... /bin/grep
checking for egrep... /bin/grep -E
checking for fgrep... /bin/grep -F
checking for ld used by gcc... /bin/ld
checking if the linker (/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /bin/nm -B
checking the name lister (/bin/nm -B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking how to convert x86_64-pc-linux-gnu file names to x86_64-pc-linux-gnu format... func_convert_file_noop
checking how to convert x86_64-pc-linux-gnu file names to toolchain format... func_convert_file_noop
checking for /bin/ld option to reload object files... -r
checking for file... file
checking for objdump... objdump
checking how to recognize dependent libraries... pass_all
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for ar... ar
checking for archiver @FILE support... @
checking for strip... strip
checking for ranlib... ranlib
checking command to parse /bin/nm -B output from gcc object... ok
checking for sysroot... no
checking for a working dd... /bin/dd
checking how to truncate binary pipes... /bin/dd bs=4096 count=1
checking for mt... no
checking if : is a manifest tool... no
checking for stdio.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for strings.h... yes
checking for sys/stat.h... yes
checking for sys/types.h... yes
checking for unistd.h... yes
checking for dlfcn.h... yes
checking for objdir... .libs
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC -DPIC
checking if gcc PIC flag -fPIC -DPIC works... yes
checking if gcc static flag -static works... no
checking if gcc supports -c -o file.o... yes
checking if gcc supports -c -o file.o... (cached) yes
checking whether the gcc linker (/bin/ld -m elf_x86_64) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking for gcc... (cached) gcc
checking whether the compiler supports GNU C... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for gcc option to enable C11 features... (cached) none needed
checking whether gcc understands -c and -o together... (cached) yes
checking dependency style of gcc... (cached) none
checking whether ln -s works... yes
checking for pkg-config... /bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
checking dependency style of gcc... none
checking whether to build with code coverage support... no
checking how to create a pax tar archive... gnutar
checking zfs author... OpenZFS
checking zfs license... CDDL
checking whether NLS is requested... yes
checking for msgfmt... /bin/msgfmt
checking for gmsgfmt... /bin/msgfmt
checking for xgettext... /bin/xgettext
checking for msgmerge... /bin/msgmerge
checking for ld... /bin/ld -m elf_x86_64
checking if the linker (/bin/ld -m elf_x86_64) is GNU ld... yes
checking for shared library run path origin... done
checking 32-bit host C ABI... no
checking for the common suffixes of directories in the library search path... lib64,lib64
checking zfs config... kernel
checking the number of available CPUs... 2
checking whether gcc supports -Wno-clobbered... yes
checking whether gcc supports -Winfinite-recursion... no
checking whether  supports -Winfinite-recursion... no
checking whether gcc supports -Wimplicit-fallthrough... yes
checking whether gcc supports -Wframe-larger-than=<size>... yes
checking whether gcc supports -Wno-format-truncation... yes
checking whether gcc supports -Wno-format-zero-length... yes
checking whether gcc supports -Wformat-overflow... yes
checking whether gcc supports -fno-omit-frame-pointer... yes
checking whether gcc supports -fno-ipa-sra... yes
checking whether  supports -fno-ipa-sra... yes
checking whether to build with -fsanitize=address support... no
checking whether to build with -fsanitize=undefined support... no
checking whether host toolchain supports SSE... yes
checking whether host toolchain supports SSE2... yes
checking whether host toolchain supports SSE3... yes
checking whether host toolchain supports SSSE3... yes
checking whether host toolchain supports SSE4.1... yes
checking whether host toolchain supports SSE4.2... yes
checking whether host toolchain supports AVX... yes
checking whether host toolchain supports AVX2... yes
checking whether host toolchain supports AVX512F... yes
checking whether host toolchain supports AVX512CD... yes
checking whether host toolchain supports AVX512DQ... yes
checking whether host toolchain supports AVX512BW... yes
checking whether host toolchain supports AVX512IFMA... yes
checking whether host toolchain supports AVX512VBMI... yes
checking whether host toolchain supports AVX512PF... yes
checking whether host toolchain supports AVX512ER... yes
checking whether host toolchain supports AVX512VL... yes
checking whether host toolchain supports AES... yes
checking whether host toolchain supports PCLMULQDQ... yes
checking whether host toolchain supports MOVBE... yes
checking whether host toolchain supports XSAVE... yes
checking whether host toolchain supports XSAVEOPT... yes
checking whether host toolchain supports XSAVES... yes
checking for system type (linux-gnu)... Linux
checking for python3... python3
checking for python version... 3.9
checking for python platform... linux
checking for GNU default python prefix... ${prefix}
checking for GNU default python exec_prefix... ${exec_prefix}
checking for python script directory (pythondir)... ${PYTHON_PREFIX}/lib/python3.9/site-packages
checking for python extension module directory (pyexecdir)... ${PYTHON_EXEC_PREFIX}/lib64/python3.9/site-packages
configure: Disabling pyzfs for kernel/srpm config
checking whether to enable pyzfs: ... no
checking for sed --in-place... --in-place
checking for cppcheck... no
checking for shellcheck... no
checking for checkbashisms... no
checking for parallel... no
checking kernel source and build directories... done
checking kernel source directory... /lib/modules/6.12.11-20250124.el9.x86_64/source
checking kernel build directory... /lib/modules/6.12.11-20250124.el9.x86_64/build
checking kernel source version... 6.12.11-20250124.el9.x86_64
checking for kernel config option compatibility... done
checking whether CONFIG_MODULES is defined... yes
checking whether CONFIG_BLOCK is defined... yes
checking whether mutex_lock() is GPL-only... no
checking whether CONFIG_TRIM_UNUSED_KSYM is disabled... yes
checking whether CONFIG_ZLIB_DEFLATE is defined... yes
checking whether CONFIG_ZLIB_INFLATE is defined... yes
checking kernel file name for module symbols... Module.symvers
checking whether fpu headers are available... asm/fpu/api.h
checking whether objtool header is available... linux/objtool.h
checking whether /dev/zfs minor is available... 249
checking whether DECLARE_EVENT_CLASS() is available... no
checking for available kernel interfaces... done
checking whether kernel defines intptr_t... yes
checking whether access_ok() has 'type' parameter... no
checking whether compile-time stack validation (objtool) is available... yes
checking whether STACK_FRAME_NON_STANDARD is defined... yes
checking whether pde_data() is lowercase... yes
checking whether generic_fadvise() is available... yes
checking whether header linux/sched/rt.h exists... yes
checking whether usleep_range() is available... yes
checking whether __vmalloc(ptr, flags, pageflags) is available... no
checking whether timestamp_truncate() exists... yes
checking whether inode_get_ctime() exists... yes
checking whether inode_set_ctime_to_ts() exists... yes
checking whether inode_get_atime() exists... yes
checking whether inode_set_atime_to_ts() exists... yes
checking whether inode_get_mtime() exists... yes
checking whether inode_set_mtime_to_ts() exists... yes
checking whether proc_ops structure exists... yes
checking whether bops->check_events() exists... yes
checking whether bops->release() is void and takes 2 args... no
checking whether bops->release() is void and takes 1 arg... yes
checking whether bops->revalidate_disk() exists... no
checking whether bio_set_op_attrs is available... no
checking whether bio_set_dev() is GPL-only... yes
checking whether bio_set_dev() is a macro... no
checking whether current->bio_list exists... yes
checking whether blkg_tryget() is available... no
checking whether bio->bi_bdev->bd_disk exists... yes
checking whether block_device_operations->submit_bio() returns void... yes
checking whether bio_alloc() wants 4 args... yes
checking whether blkdev_get_by_path() exists and takes 3 args... no
checking whether blkdev_get_by_path() exists and takes 4 args... no
checking whether bdev_open_by_path() exists... no
checking whether bdev_file_open_by_path() exists... yes
checking whether blkdev_put() exists... no
checking whether blkdev_put() accepts void* as arg 2... no
checking whether bdev_release() exists... no
checking whether blkdev_reread_part() exists... no
checking whether invalidate_bdev() exists... yes
checking whether lookup_bdev() wants dev_t arg... yes
checking whether bdev_logical_block_size() is available... yes
checking whether bdev_physical_block_size() is available... yes
checking whether check_disk_change() exists... no
checking whether bdev_check_media_change() exists... no
checking whether bdev_whole() is available... yes
checking whether bdev_nr_bytes() is available... yes
checking whether bdevname() exists... no
checking whether blkdev_get_by_path() handles ERESTARTSYS... no
checking whether blkdev_issue_discard() is available... yes
checking whether blkdev_issue_discard(flags) is available... no
checking whether __blkdev_issue_discard() is available... yes
checking whether __blkdev_issue_discard(flags) is available... no
checking whether blkdev_issue_secure_erase() is available... yes
checking whether bdev_kobj() exists... yes
checking whether part_to_dev() exists... no
checking whether disk_check_media_change() exists... yes
checking whether BLK_STS_RESV_CONFLICT is defined... yes
checking whether blk_mode_t is defined... yes
checking whether struct blk_plug is available... yes
checking whether blk_queue bdi is dynamic... no
checking whether backing_dev_info is available through queue gendisk... yes
checking whether blk_queue_update_readahead() exists... no
checking whether disk_update_readahead() exists... no
checking whether bdev_max_discard_sectors() is available... yes
checking whether bdev_max_secure_erase_sectors() is available... yes
checking whether blk_queue_max_hw_sectors() is available... no
checking whether blk_queue_max_segments() is available... no
checking whether block multiqueue hardware context is cached in struct request... yes
checking whether GENHD_FL_EXT_DEVT flag is available... no
checking whether GENHD_FL_NO_PART flag is available... yes
checking whether revalidate_disk_size() is available... no
checking whether revalidate_disk() is available... no
checking whether get_disk_ro() is available... yes
checking whether ql->discard_granularity is available... yes
checking whether inode_owner_or_capable() exists... no
checking whether inode_owner_or_capable() takes user_ns... no
checking whether inode_owner_or_capable() takes mnt_idmap... yes
checking whether super_block uses const struct xattr_handler... yes
checking whether xattr_handler->get() wants dentry and inode and flags... no
checking whether xattr_handler->set() wants dentry, inode, and mnt_idmap... yes
checking whether posix_acl_equiv_mode() wants umode_t... yes
checking whether iops->get_acl() exists... yes
checking whether iops->set_acl() with 4 args exists... yes
checking whether iops->setattr() takes mnt_idmap... yes
checking whether iops->getattr() takes mnt_idmap... yes
checking whether sops->show_options() wants dentry... yes
checking whether super_block has s_shrink... no
checking whether super_block has s_shrink pointer... yes
checking whether new var-arg register_shrinker() exists... no
checking whether shrinker_register() exists... yes
checking whether iops->mkdir() takes struct mnt_idmap*... yes
checking whether iops->lookup() passes flags... yes
checking whether iops->create() takes struct mnt_idmap*... yes
checking whether iops->permission() takes struct mnt_idmap*... yes
checking whether i_op->tmpfile() exists... yes
checking whether dops->d_automount() exists... yes
checking whether eops->commit_metadata() exists... yes
checking whether setattr_prepare() is available and accepts struct mnt_idmap*... yes
checking whether insert_inode_locked() is available... yes
checking whether truncate_setsize() is available... yes
checking whether security_inode_init_security wants callback... yes
checking whether fst->mount() exists... yes
checking whether set_nlink() is available... yes
checking whether sget() wants 5 args... yes
checking whether filemap_dirty_folio exists... yes
checking whether read_folio exists... yes
checking whether migrate_folio exists... yes
checking whether vfs_fsync() wants 2 args... yes
checking whether aops->readpages exists... no
checking whether __set_page_dirty_nobuffers exists... no
checking whether fault_in_iov_iter_readable() is available... yes
checking whether iov_iter_type() is available... yes
checking whether iter_is_ubuf() is available... yes
checking whether iter_iov() is available... yes
checking whether generic_copy_file_range() is available... no
checking whether splice_copy_file_range() is available... yes
checking whether fops->remap_file_range() is available... yes
checking whether fops->clone_file_range() is available... no
checking whether fops->dedupe_file_range() is available... no
checking whether kmap_atomic wants 1 args... yes
checking whether kmap_local_page exists... yes
checking whether follow_down_one() is available... yes
checking whether submit_bio is member of struct block_device_operations... yes
checking whether blk_alloc_disk() exists... no
checking whether blk_alloc_disk() exists and takes 2 args... yes
checking whether struct queue_limits has a features field... yes
checking whether blk_cleanup_disk() exists... no
checking whether 6.3+ bdev_*_io_acct() are available... yes
checking whether kernel fpu is available... internal
checking whether kernel defines fmode_t... yes
checking whether kuid_t/kgid_t is available... yes
checking whether i_(uid|gid)_(read|write) exist... yes
checking whether iops->rename() takes struct mnt_idmap*... yes
checking whether totalram_pages() exists... yes
checking whether totalhigh_pages() exists... yes
checking whether is inside percpu_ref.data... yes
checking whether generic_fillattr requires struct mnt_idmap* and request_mask... yes
checking whether iops->mknod() takes struct mnt_idmap*... yes
checking whether iops->symlink() takes struct mnt_idmap*... yes
checking whether bio_max_segs() exists... yes
checking whether kernel_siginfo_t tyepedef exists... yes
checking whether struct kobj_type.default_groups exists... yes
checking whether standalone <linux/stdarg.h> exists... yes
checking whether strlcpy() exists... no
checking whether folio_wait_bit() exists... yes
checking whether add_disk() returns int... yes
checking whether kthread_complete_and_exit() is available... yes
checking whether dequeue_signal() takes 4 arguments... no
checking whether 3-arg dequeue_signal() takes a type argument... yes
checking whether ZERO_PAGE() is GPL-only... no
checking whether __copy_from_user_inatomic is available... yes
checking whether APIs for idmapped mount are present... yes
checking whether idmapped mounts have a user namespace... yes
checking whether iattr->ia_vfsuid and iattr->ia_vfsgid exist... yes
checking whether int (*writepage_t)() takes struct folio*... yes
checking whether struct reclaim_state has reclaimed field... yes
checking whether register_sysctl_table exists... no
checking whether register_sysctl_sz exists... yes
checking whether proc_handler ctl_table arg is const... yes
checking whether copy_splice_read() exists... yes
checking whether fsync_bdev() exists... checking whether sync_blockdev() exists... yes
checking whether PG_error flag is available... no
checking whether page_size() is available... yes
checking whether page_mapping() is available... no
checking whether __assign_str() has one arg... no
checking whether file->f_version exists... no
checking whether pin_user_pages_unlocked() is available... yes
checking os distribution... redhat
checking default package type... rpm
checking default init directory... ${prefix}/etc/init.d
checking default shell... /bin/sh
checking default nfs server init script... nfs
checking default init config directory... /etc/sysconfig
checking whether initramfs-tools is available... no
checking default bash completion directory... /etc/bash_completion.d
checking whether rpm is available... yes (4.16.1.3)
checking whether rpmbuild is available... yes (4.16.1.3)
checking whether spec files are available... yes (rpm/generic/*.spec.in)
checking whether dpkg is available... no
checking whether dpkg-buildpackage is available... no
checking whether alien is available... no
checking whether assertion support will be enabled... no
checking whether debuginfo support will be forced... no
checking whether basic kmem accounting is enabled... no
checking whether detailed kmem tracking is enabled... no
checking whether FreeBSD kernel INVARIANTS checks are enabled... no
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating contrib/debian/rules
config.status: creating contrib/debian/changelog
config.status: creating Makefile
config.status: creating include/Makefile
config.status: creating lib/libzfs/libzfs.pc
config.status: creating lib/libzfs_core/libzfs_core.pc
config.status: creating lib/libzfsbootenv/libzfsbootenv.pc
config.status: creating module/Kbuild
config.status: creating module/Makefile
config.status: creating rpm/generic/zfs-dkms.spec
config.status: creating rpm/generic/zfs-kmod.spec
config.status: creating rpm/generic/zfs.spec
config.status: creating rpm/redhat/zfs-dkms.spec
config.status: creating rpm/redhat/zfs-kmod.spec
config.status: creating rpm/redhat/zfs.spec
config.status: creating tests/zfs-tests/tests/Makefile
config.status: creating zfs.release
config.status: creating zfs_config.h
config.status: executing depfiles commands
config.status: executing libtool commands
config.status: executing po-directories commands

Cleaning build area... done.
Building module(s)......................................................................................................................... done.
Signing module /var/lib/dkms/zfs/2.3.0/build/module/zfs.ko
Signing module /var/lib/dkms/zfs/2.3.0/build/module/spl.ko

Running the post_build script:
Cleaning build area... done.

Installing /lib/modules/6.12.11-20250124.el9.x86_64/extra/zfs.ko.xz
Installing /lib/modules/6.12.11-20250124.el9.x86_64/extra/spl.ko.xz
Running depmod........... done.

  Running scriptlet: zfs-dkms-2.3.0-1.el9.noarch                                                                                                                                                           2/2 
Running pre uninstall script: /var/tmp/rpm-tmp.1IfrEu. Parameters: 1
This is an upgrade. Skipping pre uninstall action.

  Cleanup          : zfs-dkms-2.3.0-1.el9.noarch                                                                                                                                                           2/2 
  Verifying        : zfs-dkms-2.3.0-1.el9.noarch                                                                                                                                                           1/2 
  Verifying        : zfs-dkms-2.3.0-1.el9.noarch                                                                                                                                                           2/2 

Reinstalled:
  zfs-dkms-2.3.0-1.el9.noarch                                                                                                                                                                                  

Complete!
```

```
RAIDZ 类型
ZFS 提供多种 RAIDZ 配置，主要包括：

RAIDZ1：

类似于 RAID 5，使用单个校验盘。
优点：存储效率高（N-1 个磁盘的空间用于存储数据，1 个磁盘用于校验）。
缺点：只能容忍一个磁盘故障，容错能力相对较低。
RAIDZ2：

类似于 RAID 6，使用两个校验盘。
优点：可以容忍两个磁盘同时故障，数据保护更高。
缺点：存储效率略低于 RAIDZ1（N-2 个磁盘用于数据存储）。
RAIDZ3：

使用三个校验盘。
优点：可以容忍三个磁盘同时故障，适用于超大规模阵列。
缺点：存储效率进一步降低，主要适合对数据保护要求极高的场景。



1. RAIDZ 类型及其最少磁盘数量
ZFS 提供三种 RAIDZ 配置，其最少使用磁盘数量分别为：

RAIDZ1

最少磁盘数：3 个
说明：采用 1 个校验盘保护数据，也就是说，在 3 个盘中有 2 个用于存储数据，1 个用于存储校验信息。
RAIDZ2

最少磁盘数：4 个
说明：采用 2 个校验盘，因此在 4 个盘中有 2 个数据盘，容忍最多 2 块盘同时故障。
RAIDZ3

最少磁盘数：5 个
说明：采用 3 个校验盘，能容忍 3 块盘故障。
2. 奇数盘与偶数盘的区别
在构建 RAIDZ 阵列时，选择奇数个盘还是偶数个盘主要影响以下几个方面：

2.1 有效容量比例
对于 RAIDZ 配置，有效存储容量的比例取决于数据盘数量（即总盘数减去校验盘数量）。例如：

RAIDZ1：

3 个盘时：有效数据盘数 = 3 – 1 = 2，存储效率约 66.7%
4 个盘时：有效数据盘数 = 4 – 1 = 3，存储效率约 75%
RAIDZ2：

4 个盘时：有效数据盘数 = 4 – 2 = 2，存储效率 50%
5 个盘时：有效数据盘数 = 5 – 2 = 3，存储效率 60%
6 个盘时：有效数据盘数 = 6 – 2 = 4，存储效率约 66.7%
RAIDZ3：

5 个盘时：有效数据盘数 = 5 – 3 = 2，存储效率 40%
7 个盘时：有效数据盘数 = 7 – 3 = 4，存储效率约 57%
因此，从容量利用率的角度看，增加盘数（无论奇数还是偶数）都会改善有效容量比例，但具体比率取决于“数据盘”占总盘数的比例。

2.2 性能和 I/O 分布
校验数据分布：
ZFS 的 RAIDZ 采用分布式校验，不存在单独的“校验盘”。数据和校验信息在所有磁盘上均匀分布。因此，从理论上讲，奇数盘和偶数盘在 I/O 分布上没有本质区别；不过在实际情况中，更多的数据盘意味着在一次条带（stripe）中可以同时并行访问更多的数据块，这可能带来略高的顺序读写性能。

条带宽度（Stripe Width）：
RAIDZ 的条带宽度由所有参与计算的磁盘数量决定。奇数或偶数个盘只要数据块在条带中均匀分布，性能差异通常不明显。不同的工作负载（例如顺序读写和随机读写）的表现可能有轻微差异，但整体来说并不会因为奇数或偶数而有根本性不同。

2.3 扩展和灵活性
扩容考量：
一般来说，RAIDZ 一旦创建后就不容易直接添加磁盘扩展阵列（扩容通常需要重建存储池）。因此，事先规划好需要的盘数量尤为重要。无论奇偶，通常建议根据未来存储需求选择合适的盘数。如果希望获得较高的存储效率，使用更多盘（比如 7、9 个盘）可以使校验开销在整体容量中所占比例更低。

故障容忍：
故障容忍能力只取决于所选的 RAIDZ 类型（即使用多少个校验盘），与奇偶数无关。例如 RAIDZ1 始终只能容忍 1 个盘故障，RAIDZ2 容忍 2 个，RAIDZ3 容忍 3 个，无论总盘数是奇数还是偶数。
```

