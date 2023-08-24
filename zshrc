# lang
export LANG=en_US.UTF-8

# color
autoload -Uz colors && colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# common 
setopt printeightbit
setopt nobeep
setopt noflowcontrol
setopt interactivecomments

# cd / pushed
setopt autocd
setopt autopushd
setopt pushdignoredups
DIRSTACKSIZE=20

# glob
setopt nocaseglob
setopt globcomplete
setopt extended_glob

# spelling
setopt correct
setopt correctall

# history
setopt share_history
setopt histignorealldups
setopt histreduceblanks
setopt extendedhistory
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
bindkey -e
bindkey "^R" history-incremental-search-backward

# word-delimiter
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# vcs
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# prompt
setopt promptsubst
PROMPT='%n %~ %# '
RPROMPT='%1(v|%F{green}%1v%f|)'

# aliases
alias ls='ls -G -F'
alias la='ls -a'
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias grep="grep --color -n -I --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"
alias tree='tree -NC'
alias -g C='| pbcopy'

# path
typeset -U path cdpath fpath manpath
export JAVA_HOME=`/usr/libexec/java_home -v 17`
export ANDROID_SDK_ROOT=$HOME/.android

path=(
    $HOME(N-/)
    $HOME/.flutter/bin(N-/)
    $ANDROID_SDK_ROOT/cmdline-tools/latest/bin(N-/)
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    $path
)

. "$HOME/.cargo/env"
eval "$(/opt/homebrew/bin/brew shellenv)"
