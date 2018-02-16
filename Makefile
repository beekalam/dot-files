backup_autokey:
	cp  ~/.config/autokey/autokey.json ~/bin/autokey-backups/autokey.js
	cp -R ~/.config/autokey/data ~/bin/autokey-backups/


all: backup_bashaliases backup_autokey
