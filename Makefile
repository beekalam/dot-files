backup_autokey:
	cp -R ~/.config/autokey/ ~/bin/autokey-backups

backup_bashaliases:
	mkdir -p ~/bin/bashalias-backup/
	cp  ~/.bash_aliases ~/bin/bashalias-backup/.bash_aliases

all: backup_bashaliases backup_autokey
