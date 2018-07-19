# Host bootstrap

## Gentoo installation

get host in to resque mode

create disk partitions as in PARTED.md

```
mkfs.ext2 -T small /dev/sda2
mkswap /dev/sda3
mkfs.ext4 /dev/sda4
```

mount rootfs

get _stage3_ and extract to rootfs

```
mkdir -p /mnt/gentoo
mount /dev/sda4 /mnt/gentoo
cd /mnt/gentoo/
wget http://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-systemd/stage3-amd64-systemd-20180713.tar.bz2
tar xpf stage3-amd64-systemd-20180713.tar.bz2 --xattrs-include='*.*' --numeric-owner
```

setup portage system

```
wget http://distfiles.gentoo.org/snapshots/portage-latest.tar.xz
tar xf portage-latest.tar.xz -C /mnt/gentoo/usr
wget https://github.com/schamane/cloud-playground/raw/master/compulypse/portage/make.conf -P etc/portage/
wget https://github.com/schamane/cloud-playground/raw/master/compulypse/portage/package.use -P etc/portage/
wget https://github.com/schamane/cloud-playground/raw/master/compulypse/portage/package.mask -P etc/portage/
wget https://github.com/schamane/cloud-playground/raw/master/compulypse/portage/package.accept_keywords -P etc/portage/
mkdir /mnt/gentoo/etc/portage/repos.conf
wget https://github.com/schamane/cloud-playground/raw/master/compulypse/portage/repos.conf/gentoo.conf -P /mnt/gentoo/etc/portage/repos.conf/
mkdir /mnt/gentoo/etc/portage/sets
wget https://github.com/schamane/cloud-playground/raw/master/compulypse/portage/sets/cloud -P /mnt/gentoo/etc/portage/sets/
```

copy dns info

`cp --dereference /etc/resolv.conf /mnt/gentoo/etc/`

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

`mount /dev/sda2 /boot`

emerge git and sync portage to latest

```
emerge -1q dev-vcs/git
# rm -rf /usr/portage/
emerge --sync
emerge -1q portage
eselect news read
```

configure timezone and locale

```
echo "Europe/Brussels" > /etc/timezone
emerge -1q sys-libs/timezone-data
emerge --config sys-libs/timezone-data
rm /etc/locale.gen
rm /etc/conf.d/02locale
wget https://github.com/schamane/cloud-playground/raw/master/compulypse/locale.gen -P /etc/
#wget https://github.com/schamane/cloud-playground/raw/master/compulypse/02locale -P /etc/env.d/
ln -s -n -f ../locale.conf /etc/env.d/02locale
env-update && source /etc/profile && export PS1="(chroot) $PS1"
```

create kernel

```
emerge -1q sys-devel/bc
cd /usr/src
wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.17.8.tar.xz
tar xf linux-4.17.8.tar.xz
nano -w /etc/portage/package.mask
# add >=sys-kernel/linux-headers-4.18
ln -s linux-4.17.8 linux
cd linux
wget https://github.com/schamane/cloud-playground/raw/master/compulypse/.config
make oldconfig
make -j3
make modules_install
cp System.map /boot/System-4.17.8
cp arch/x86_64/boot/bzImage /boot/kernel-4.17.8
```

configure system for boot with systemd

```
wget https://github.com/schamane/cloud-playground/raw/master/compulypse/fstab -O /etc/fstab
nano -w /etc/conf.d/hostname
# change host name to n1

nano -e /etc/hosts
# add n1 befor localhost
```

## install bootloader

```
emerge --ask --verbose -q sys-boot/grub:2
grub-install /dev/sda
nano -w /etc/default/grub
# Change timeout to 1
# Enable line for systemd init
cd
grub-mkconfig -o /boot/grub/grub.cfg
nano -w /boot/grub/grub.cfg
# remove kernel version
```

## configure systemd

See README.md from systemd folder

```
nano -w /etc/hosts
# 127.0.0.1       n1.easyoam n1 localhost
# ::1             n1.easyoam n1 localhost

passwd
# change root password
```

reboot systems

```
useradd -m -G users,wheel -s /bin/bash <username>
passwd <username>

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
