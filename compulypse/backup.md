# Configure Backup

## SSH Key for backup server

```
cd projects/backup-keys
mkdir .ssh
chmod 700 .ssh
cd
ssh-keygen
ssh-keygen -e -f .ssh/id_rsa.pub | grep -v "Comment:" > .ssh/id_rsa_rfc.pub

cat .ssh/id_rsa.pub >> projects/backup-keys/.ssh/authorized_keys
cat .ssh/id_rsa_rfc.pub >> projects/backup-keys/.ssh/authorized_keys

chmod 600 projects/backup-keys/.ssh/authorized_keys
```

## upload key to backup server

```
 rsync -ax --progress -e 'ssh -p23' /home/schamane/projects/backup-keys/ <user>@<user>.your-backup.de:
```
