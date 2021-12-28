write_symbolic_links:
	$(shell [ ! -f ~/.bash_aliases ] && ln -s ~/.dot-files/.bash_aliases ~/.bash_aliases)
	$(shell [ ! -f ~/.inputrc ] && ln -s ~/.dot-files/.inputrc ~/.inputrc)

