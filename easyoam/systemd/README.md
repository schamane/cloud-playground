# Systemd setup

```
systemd-machine-id-setup
hostnamectl set-hostname easyoam.de
```

## add user to get access to journal

```
gpasswd --add larry systemd-journal
```

## add cron

```
emerge -q systemd-cron
```
