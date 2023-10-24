#!/bin/zsh

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt autocd
setopt interactivecomments
setopt extended_glob

#
# EXPORTS
#

export PATH=$PATH:$HOME/.local/bin:$HOME/.bin

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"
export PAGER="less"
export DEFAULT_USER="$(whoami)"
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=setting'

echo 1/4: Loading zstyle, compinit...

zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit && compinit

echo 2/4: Initializing dependencies with zplug...

if [[ ! -d ~/.zplug ]];then
    git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh
source ~/.cargo/env

zplug "mafredri/zsh-async", from:github
zplug "lib/completion", from:oh-my-zsh
zplug "themes/agnoster", use:agnoster.zsh, from:oh-my-zsh, as:theme
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3
zplug "MichaelAquilina/zsh-you-should-use"
zplug "zsh-users/zsh-autosuggestions", from:github

echo 3/4: Loading zplug dependencies...

zplug load

if ! zplug check --verbose; then
    printf "Install zplug plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

echo 4/4: Setting aliases...

#
# Aliases
#

#
# Files

alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'

alias size='du -hs'

alias md='mkdir -p'
alias mkdirs='mkdir -pv'
alias rd='rmdir'

alias tree='find . -print | sed -e '\''s;[^/]*/;|____;g;s;____|; |;g'\'''

# List

alias ls='ls --color=auto -h'
alias la='ls --color=auto -la -F'
alias ll='ls --color=auto -lh -F'

#
# GIT commands
#

alias gaa="git add ."
alias gaap="git add -p ."
alias ga="git add"
alias gap="git add -p"
alias gc="git commit"
alias gch="git checkout"
alias gcm="git commit -m"
alias gps="git push"
alias gpu="git pull"
alias gs="git status"
alias gbr="git branch"
alias gd="git diff"
alias gdc="git diff --cached"
alias gl="git log --oneline"

alias please="sudo !!"

#
# Grep
#

alias grep='grep --color=auto'
alias g='grep --color=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

#
# VIM
#
alias vi="nvim"
alias nv="nvim"

alias q='exit'
alias reload='source ~/.zshrc'
alias :q="quit"


clear

