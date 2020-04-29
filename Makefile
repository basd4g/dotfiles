# =========== setup all ===========
inits:
	make link
	make packages-init-mini
	make user-default-init
	make xkeysnail-init
	make gnome-terminal-load
	make ubuntu-homedir-rename
	make yarn-init
	make vim-init
	make zsh-init

# =========== setup commands ===========
link:
	bin/link.sh
packages-init-mini:
	bin/packages-init.sh minimum
packages-init:
	bin/packages-init.sh
yarn-init:
	yarn global add
vim-init:
	vim -s etc/vimop
zsh-init:
	bin/zsh-init.sh

user-default-init:
	if [ "$(uname)" = "Darwin" ]; then
		bin/user-default/os.sh
		bin/user-default/shiftit.sh
	fi
ubuntu-homedir-rename:
	if [ "$(uname)" = "Linux" ];then
		LANG=C xdg-user-dirs-gtk-update
	fi
xkeysnail-init:
	if [ "$(uname)" = "Linux" ];then
		bin/xkeysnail-init.sh
	fi
gnome-terminal-load:
	if [ "$(uname)" = "Linux" ];then
		dconf reset /org/gnome/terminal/
		dconf load /org/gnome/terminal/ < etc/gnome-terminal.dconf
	fi

# =========== backup commands ===========
gnome-terminal-dump:
	if [ "$(uname)" = "Linux" ];then
		dconf dump /org/gnome/terminal/ > etc/gnome-terminal.dconf
	fi
brew-dump:
	if [ "$(uname)" = "Darwin" ]; then
		rm -f etc/Brewfile
		brew bundle dump --file etc/Brewfile
	fi

# =========== help message ===========
help:
	@echo '# Hello, this is dotfiles written by basd4g'
	@echo 'make (inits)             # run all scripts without packages-init'
	@echo 'make link                # Put symlinks of a dotfile'
	@echo 'make packages-init-mini  # Install minimum homebrew or apt packages'
	@echo 'make packages-init       # Install homebrew or apt packages (very heavy)'
	@echo 'make yarn-init           # Install nodejs packages'
	@echo 'make vim-init            # Install vim plugins'
	@echo 'make zsh-init            # Chenge default shell to zsh'
	@echo 'make user-default-init   # (macOS) Set user-default (macOS)'
	@echo 'make ubuntu-homedir-init # (ubuntu) Rename directories in homedir from Japanese to English'
	@echo 'make gnome-terminal-load # (ubuntu) Load gnome-terminal settings'
	@echo 'make xkeysnail-init      # (ubuntu) Set start xkeysnail automatically'
	@echo 'make gnome-terminal-dump # (ubuntu) Dump gnome-terminal settings'
	@echo 'make brew-dump           # (macOS) Dump installed packages with brew to `~/dotfiles/etc/Brewfile`'

