# mescaline for zsh - based on powerline / ezzsh, but this version is
# entirely re-written from scratch.
# Written by Arminius <armin@arminius.org>
#
# Released under the terms of the GNU General Public License,
# Version 3, © 2007-2015 Free Software Foundation, Inc. -- http://fsf.org/

# set mescaline installation location
mescaline_home="$HOME/.mescaline/"

function _mescaline () {
  export PROMPT="$(~/.mescaline/mescaline $?)"
}
precmd () {
	_mescaline
}

# force $TERM on rxvt
if [[ "$COLORTERM" == "rxvt-xpm" ]]; then
    export TERM="rxvt-unicode-256color"
fi

if [[ "$TERM" == "xterm" ]]; then
    export TERM="xterm-256color"
fi

# set $PATH
export PATH=/usr/local/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH:$HOME/bin

# set standard editor via $EDITOR
if hash vim; then
  export EDITOR='vim'
else
	export EDITOR='vi'
fi

# show man pages color
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# fix for ssh host completion from ~/.ssh/config
[ -f ~/.ssh/config ] && : ${(A)ssh_config_hosts:=${${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*\**}:#*\?*}}

# needed to keep backgrounded jobs running
setopt NO_HUP

# set ls options
LS_OPTIONS="--color=auto --group-directories-first -F"

# set $SHELL:
# export SHELL="$(which zsh)"

# keychain stuff
if hash keychain; then
ssh_cmd="$(which ssh)"
function ssh () {
echo "$@" >> $HOME/.keychain-args
echo "$(date)" > $HOME/.keychain-output
keychain id_rsa >> $HOME/.keychain-output 2>&1
[ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
[ -f $HOME/.keychain/$HOSTNAME-sh ] && \
. $HOME/.keychain/$HOSTNAME-sh
[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
. $HOME/.keychain/$HOSTNAME-sh-gpg
"$ssh_cmd" "$@"
}
fi

# grep with color
alias grep='grep --color=auto'

# enable ls colorization: 
if [ "$TERM" != "dumb" ]; then
  eval "$(dircolors "$mescaline_home"/dircolors)"
  alias ls="ls $LS_OPTIONS"
fi

# do not autocorrect sudo commands (fixes "zsh: correct 'vim' to '.vim' [nyae]?")
alias sudo='nocorrect sudo'

# the more brutal attempt:
unsetopt correct{,all} 

# colored grep / less
alias grep="grep --color='auto'"
alias less='less -R'
alias diff='colordiff'

# additional zsh options
unsetopt menu_complete # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

# word completion/deletion non-boundary characters
WORDCHARS=''

zmodload -i zsh/complist
zstyle ':completion:*' list-colors ''

# some keybindings
bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $mescaline_home/cache/

# unless we really want to
zstyle '*' single-ignored show

expand-or-complete-with-dots() {
#    echo -n "\e[36mч\e[0m"
    echo -n "\e[36mᕁ\e[0m"
    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  bindkey "^I" expand-or-complete-with-dots

# set backspace boundaries
autoload -Uz select-word-style
$_ bash
zle -N backward-kill-word-match
bindkey 'tab' $_

# enable the advanced completion system
autoload -U compinit && compinit



export HISTSIZE=2000 
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt autocd

# When set, you're able to use extended globbing queries such as cp ^*.(tar|bz2|gz) .
setopt extendedglob

# aliases

alias t='tmux detach; tmux attach || tmux'
alias l='ls -al'
alias apt-get='sudo apt-get'
alias ..='cd ..'
alias ~='cd ~'
alias tmuxr='tmux source-file ~/.tmux.conf'
alias bigupdate='apt-get update; apt-get upgrade; apt-get dist-upgrade'
alias imgscrot='tmpfile="$(mktemp -u).png"; scrot "$tmpfile"; python "$HOME/.wigglytuff/scripts/imgur.py" "$tmpfile"'
alias imgscrots='tmpfile="$(mktemp -u).png"; scrot "$tmpfile" -s; python "$HOME/.wigglytuff/scripts/imgur.py" "$tmpfile"'
alias wigglyscrot='$HOME/.wigglytuff/scripts/wigglyscrot.sh'
alias service='sudo service'
alias roflcopter='$HOME/.wigglytuff/scripts/copter'

