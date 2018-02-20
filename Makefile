backup_autokey:
	cp  ~/.config/autokey/autokey.json ~/bin/autokey-backups/autokey.json
	cp -R ~/.config/autokey/data ~/bin/autokey-backups/

restore_autokey:
	cp ~/bin/autokey-backups/autokey.json ~/.config/autokey/autokey.json
	cp -R ~/bin/autokey-backups/data  ~/.config/autokey

all: backup_autokey
