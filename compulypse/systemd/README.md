# Systemd setup

```
systemd-machine-id-setup
hostnamectl set-hostname kliopa.net
```

## configure network

```
cd /etc/systemd/network
touch 20-wired.network
nano -w 20-wired.network
```

check configuration example from git repository

enable network services

```
systemctl enable systemd-networkd.service
ln -snf /run/systemd/resolve/resolv.conf /etc/resolv.conf
systemctl enable systemd-resolved.service
```

## add user to get access to journal

```
useradd -m -G users,wheel,docker,systemd-journal -s /bin/bash <user>
#or gpasswd --add <user> systemd-journal
```

enable sshd service

```
systemctl enable sshd
```

## add cron

```
emerge -q systemd-cron
```
