[![lint](https://github.com/basd4g/dotfiles/workflows/lint/badge.svg)](https://github.com/basd4g/dotfiles/actions?query=workflow%3Alint)
[![macOS Setup](https://github.com/basd4g/dotfiles/workflows/macOS%20Setup/badge.svg)](https://github.com/basd4g/dotfiles/actions?query=workflow%3A%22macOS+Setup%22)
[![Ubuntu Setup](https://github.com/basd4g/dotfiles/workflows/Ubuntu%20Setup/badge.svg)](https://github.com/basd4g/dotfiles/actions?query=workflow%3A%22Ubuntu+Setup%22)

# My dotfiles

## Setup

### Ubuntu Setup

```sh
$ curl -sL dot.basd4g.net | bash
$ cd ~/dotfiles
$ sudo make
```

### macOS Setup

```sh
# Sign in to Apple ID
$ open /System/App\ Store.app

# Setup Homebrew
$ xcode-select --install
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Setup my settings
$ curl -sL dot.basd4g.net | bash
$ cd ~/dotfiles
$ make

# Enable macOS settings of User Defaults
$ sudo reboot

# Enable karabiner settings
$ open /Applications/Karabiner-Elements.app/
#   Complex modifications > Add rule > basd4g's setting > Enable All

# It may take some time to download and install all packages
#  and the computer sometimes ask you password.
$ make packages-init
```

## Dotfiles

### Install and deploy dotfiles

```
$ curl -sL dot.basd4g.net | sh
$ cd ~/dotfiles
$ make link
```

### Add new dotfile

```sh
$ cd ~/dotfiles
$ mv ~/.hogerc ./
$ make link
```

## LICENSE

MIT

## ToDo

- [ ] Add anyenv
- [ ] Add `dot.basd4g.net/help`

