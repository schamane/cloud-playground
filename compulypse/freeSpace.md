# Cleanup System

after bulding, cleanup the system

## Portage build system

```
rm -rf /var/tmp/portage/*
rm -rf /usr/portage/distfiles/*
rm -rf /usr/portage/packages/*
```

## Kernel installs

```
mount /boot
rm /boot/kernel-<oldversions>
rm /boot/System-<oldversions>
umount /boot
rm -rf /usr/src/linux-<oldversion>
rm -rf /lib/modules/<oldversion>
```
