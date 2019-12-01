backup_autokey:
	cp  ~/.config/autokey/autokey.json ~/bin/autokey-backups/autokey.json
	cp -R ~/.config/autokey/data ~/bin/autokey-backups/

restore_autokey:
	cp ~/bin/autokey-backups/autokey.json ~/.config/autokey/autokey.json
	cp -R ~/bin/autokey-backups/data  ~/.config/autokey

backup_sublime_keybindings:
	cp ~/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap ~/bin/sublime-backups/Default\ \(Linux\).sublime-keymap

restore_sublime_keybindings:
	cp ~/bin/sublime-backups/Default\ \(Linux\).sublime-keymap ~/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap
	
all: backup_autokey
