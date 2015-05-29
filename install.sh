#!/bin/sh
#
# wigglytuff's configurator <wiggly@wigglytuff.org>
#
# mescaline is created by netzverweigerer - http://github.com/netzverweigerer/
#
# this script assumes you've already installed zsh and ran chsh -s /usr/bin/zsh

# parameter expansion to extract the scripts home directory
script="${0%/*}"
home="$(readlink -f $script)"
cd "$home"

# print a message
msg () {
  printf "[wigglytuff] "
  printf "$@ \n"
}

# run mescaline installer
msg 'running mescaline installer...'
if [ -e "$HOME/.mescaline" ]; then
  rm -rf "$HOME/.mescaline"
fi
mv "$HOME/.zshrc" "$HOME/.zshrc.pre-mescaline"
sh ./mescaline/install.sh || msg 'mescaline install failed. continuing anyway.'

# create .wigglytuff directory
msg 'creating .wigglytuff directory...'
rm -rf "$HOME/.wigglytuff"
mkdir "$HOME/.wigglytuff"
rsync -a . "$HOME/.wigglytuff"

# backup old dotfiles and create new symlinks
msg 'creating dotfile symlinks...'
if [ -e "$HOME/.vimrc" ]; then
  mv "$HOME/.vimrc" "$HOME/.vimrc-prewiggly"
fi
if [ -e "$HOME/.tmux.conf" ]; then
  mv "$HOME/.tmux.conf" "$HOME/.tmux.conf-prewiggly"
fi
if [ -e "$HOME/.zshrc" ]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc-prewiggly"
fi
ln -s "$HOME/.wigglytuff/dotfiles/.vimrc" "$HOME/.vimrc"
ln -s "$HOME/.wigglytuff/dotfiles/.tmux.conf" "$HOME/.tmux.conf"
ln -s "$HOME/.wigglytuff/dotfiles/.zshrc" "$HOME/.zshrc"

if [ -e "./dotfiles/apikeys" ]; then
  cat "./dotfiles/apikeys" >> "$HOME/.zshrc"
fi

msg 'done.'

# refresh zsh
#zsh -l
