# Set Locale and Keymap for Systemd

## Set locale

### List locales

`localectl list-locales`

### Set locale

`localectl set-locale LANG=en_US.utf8`

### Show locale was set

`localectl | grep "System Locale"``

## Set Keymap for local console

### List locales keymaps

`localectl list-keymaps`

### Set Keymap to de

`localectl set-keymap de-alt_UTF-8`

### Check Keymap was set

`localectl | grep "VC Keymap"`
