# Create Disk with parted

`parted -a optimal /dev/sda`

## GPT disk

### create empty GPT disk

```
rm1
mklabel gpt
```

### create partitions

```
mkpart primary 1 3
name 1 grub
set 1 bios_grub on
mkpart primary 3 131
name 2 boot
set 2 boot on
mkpart primary 131 643
name 3 swap
mkpart primary 643 -1
name 4 rootfs
```

### print configured partitions

`p`

### quit parted

`q`

## GPT disk 2

`parted -a optimal /dev/sdb`

```
rm1
mkpart primary 1 -1
name 1 storagefs
```
