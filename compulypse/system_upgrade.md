# Upgrade System

## Upgrade gcc

change /etc/portage/package.accept_keywords

```
=sys-devel/gcc-8.1* **
```

### Switch gcc profile

```
gcc-config -l

gcc-config x86_64-pc-linux-gnu-8.1.0
```

### Rebuild system

```
emerge -q --emptytree --usepkg=n @system
emerge -q --emptytree --usepkg=n @world
```
