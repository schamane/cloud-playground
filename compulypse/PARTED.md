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
mkpart primary 1 131
name 2 boot
set 1 bios_grub on
set 1 boot on
mkpart primary 131 643
name 2 swap
mkpart primary 643 -1
name 3 rootfs
```

### print configured partitions

`p`

### quit parted

`q`
