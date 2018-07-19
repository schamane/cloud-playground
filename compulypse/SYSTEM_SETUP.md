# System Setup

## SSH

'''
cd /etc/ssh/
nano -w sshd_config
'''

## Locale Unicode

eselect locale list
eselect locale set 3

env-update && source /etc/profile

### unicode for screen

cd
nano -w .screenrc
defutf8 on

## Metalog

systemctrl daemon-reload
systemctrl start metalog
systemctrl enable metalog

## Systemd resolv.conf

rm /etc/resolv.conf
ln -snf /run/systemd/resolve/resolv.conf /etc/resolv.conf
systemctl enable systemd-resolved.service
systemctl start systemd-resolved.service
