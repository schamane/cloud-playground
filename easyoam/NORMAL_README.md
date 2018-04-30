# Host bootstrap

## Gentoo installation

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
mkdosfs -F 32 -n efi-boot /dev/sda1
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
wget http://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64/stage3-amd64-20180426T214504Z.tar.xz
tar xpf stage3-amd64-20180426T214504Z.tar.xz --xattrs-include='*.*' --numeric-owner
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
locale-gen
env-update && source /etc/profile && export PS1="(chroot) $PS1"
```

create kernel

```
emerge -1q sys-devel/bc
cd /usr/src
wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.16.5.tar.xz
tar xf linux-4.16.5.tar.xz
nano -w /etc/portage/package.mask
# add >=sys-kernel/linux-headers-4.17
ln -s linux-4.16.5 linux
cd linux
wget https://github.com/schamane/cloud-playground/raw/master/easyoam/.config
make oldconfig
make -j3
make modules_install
cp System.map /boot/System-4.16.5
cp arch/x86_64/boot/bzImage /boot/kernel-4.16.5
```

configure system

```
wget https://github.com/schamane/cloud-playground/raw/master/easyoam/fstab -O /etc/fstab
nano -w /etc/conf.d/hostname
# change host name to easyoam

emerge --ask --noreplace net-misc/netifrc

nano -w /etc/conf.d/net
# config_enp0s3="dhcp"
# dns_domain_lo="easyoam.de"

cd /etc/init.d
ln -s net.lo net.enp0s3
rc-update add net.enp0s3 default

nano -w /etc/hosts
# 127.0.0.1       easyoam.local localhost
# ::1             easyoam.local localhost

passwd
# change root password

useradd -m -G users,wheel -s /bin/bash <username>
passwd <username>
```

install tools

```
emerge -1q metalog
rc-update add metalog default
emerge -1q cronie
rc-update add cronie default
crontab /etc/crontab
rc-update add sshd default
emerge --ask net-misc/dhcpcd
rc-update add dhcpcd default
```

install bootloader

```
emerge --ask --verbose sys-boot/grub:2
grub-install /dev/sda
nano -w /etc/default/grub
cd /boot
ln -s System-4.16.4 System
ln -s kernel-4.16.4 kernel
cd
grub-mkconfig -o /boot/grub/grub.cfg
nano -w /boot/grub/grub.cfg
# remove kernel version
```

reboot systems
```
exit
cd
umount -l /mnt/gentoo/dev{/shm,/pts,}
umount -R /mnt/gentoo
reboot
```

## Software
```
emerge -1q htop
emerge -1q app-misc/screen app-misc/mc
```
