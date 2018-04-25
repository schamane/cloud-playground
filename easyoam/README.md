# Host bootstrap

## Gentoo installation - MUSL

get host in to resque mode

create disk partitions

``
cfdisk /dev/sda
``

| part | path  | size  |
| ---- | ----- | ----- |
| sda1 | bootloader | 2M  |
| sda2 | /boot     | 128M     |
| sda  | / | - |

create file systems

```
mkfs.ext2 -T small /dev/sda2
mkswap /dev/sda3
mkfs.ext4 /dev/sda4
```

mount rootfs

get *stage3* and extract to rootfs

```
mkdir -p /mnt/gentoo
mount /dev/sda4 /mnt/gentoo
cd /mnt/gentoo/
wget http://distfiles.gentoo.org/experimental/amd64/musl/stage3-amd64-musl-vanilla-20180404.tar.bz2
tar xpf stage3-amd64-musl-vanilla-20180404.tar.bz2 --xattrs-include='*.*' --numeric-owner
wget http://distfiles.gentoo.org/snapshots/portage-latest.tar.xz
tar xf portage-latest.tar.xz -C /mnt/gentoo/usr
```

setup portage system

```
wget https://github.com/schamane/cloud-playground/raw/master/easyoam/make.conf -O etc/portage/make.conf
mkdir /mnt/gentoo/etc/portage/repos.conf
wget https://github.com/schamane/cloud-playground/raw/master/easyoam/gentoo.conf -O /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
wget https://github.com/schamane/cloud-playground/raw/master/easyoam/package.use -O /mnt/gentoo/etc/portage/package.use
```

copy dns info

``
cp --dereference /etc/resolv.conf /mnt/gentoo/etc/
``

mounting the necessary filesystems

```
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
```

## Entering the set gentoo environment

chrooting

```
chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) ${PS1}"
```

mount /boot

``
mount /dev/sda2 /boot
``

switch to libress

```
emerge -f libressl
emerge -C openssl
emerge -1q libressl
emerge -1q openssh wget python:2.7 python:3.5 iputils
emerge -q @preserved-rebuild
```

emerge git and sync portage to latest

```
emerge -1q dev-vcs/git
emerge --sync
emerge -1q portage
eselect news read
```

configure timezone and locale

```
echo "Europe/Brussels" > /etc/timezone
emerge -1q sys-libs/timezone-data
emerge --config sys-libs/timezone-data
wget https://github.com/schamane/cloud-playground/raw/master/easyoam/locale.gen - O /etc/locale.gen
wget https://github.com/schamane/cloud-playground/raw/master/easyoam/02locale - O /etc/env.d/02locale
env-update && source /etc/profile && export PS1="(chroot) $PS1"
```

create kernel

```
emerge -1q sys-devel/bc
cd /usr/src
wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.16.4.tar.xz
tar xf linux-4.16.4.tar.xz
nano -w /etc/portage/package.mask
# add >=sys-kernel/linux-headers-4.17
ln -s linux-4.16.4 linux
cd linux
wget https://github.com/schamane/cloud-playground/raw/master/easyoam/.config
make oldconfig
make -j3
```
