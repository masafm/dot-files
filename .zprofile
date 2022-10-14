## Env
export PATH=$PATH:~/bin
export HISTSIZE=10000
export SAVEHIST=100000

## Nutanix
if [ "$(hostname)" = "C02Y41YCJHD3" ];then
   # Nutanix related settings
   source ~/ntnx-tools/zprofile.sh
fi

## Brew
if [ -d "/opt/homebrew/bin" ];then
   # Set PATH, MANPATH, etc., for Homebrew.
   exportPATH="/opt/homebrew/bin:$PATH"
   eval "$(/opt/homebrew/bin/brew shellenv)"
fi
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
fi
if [ -f $(brew --prefix)/bin/pyenv ]; then
    eval "$(pyenv init --path)"
fi

## zsh customize
# Treat / as word separator
export WORDCHARS=${WORDCHARS/\/}
setopt auto_cd
setopt auto_pushd
setopt correct
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_all_dups
function chpwd() {
    # Set terminal window name
    echo -en "\033]2; "$(pwd | perl -pe 's#/Users/mkashi#~#;s#/[^/]+$##')" \007"
    # Set teminal tab name
    echo -en "\033]1; "$(pwd | perl -pe 's#/Users/mkashi#~#;s#.*?/(\d+ \| [^/]+).*#$1#')" \007"
}
chpwd
# Completion without ls
function expand-or-complete-or-list-files() {
    if [[ $#BUFFER == 0 ]]; then
        BUFFER="ls ./"
        CURSOR=3
        zle list-choices
        zle backward-kill-word
	CURSOR=2
    else
        zle expand-or-complete
    fi
}
zle -N expand-or-complete-or-list-files
# Bind to tab
bindkey '^I' expand-or-complete-or-list-files
bindkey '^U' backward-kill-line

## Alias
alias ls='ls -FG'
alias ll='ls -alFG'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias gtags='gtags --gtagslabel=pygments -v'
alias emacs='emacs -nw'
alias .zprofile='emacs ~/.zprofile && . ~/.zprofile'
alias .emacs='emacs ~/.emacs'
alias .zshrc='emacs ~/.zshrc && . ~/.zshrc'
alias c='cd ~/cases'
alias d='cd ~/downloads'
alias e='emacs -nw'
alias f='open .'
alias s='cd ~/src'
alias s2='cd ~/src2'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias bulma='emacs /ssh:bulma:~'
alias gohan='emacs /ssh:gohan:~'
alias goku='emacs /ssh:goku:~'
alias krillin='emacs /ssh:krillin:~'
alias piccolo='emacs /ssh:piccolo:~'
alias vegeta='emacs /ssh:vegeta:~'
alias yamcha='emacs /ssh:yamcha:~'
function ssh() {
    if [ -n "$*" ];then
       echo -en "\033]1; "$(echo "$*" | perl -pe 's/\s*-[^\s]+\s+[^\s]+\s*//g')" \007"
       /usr/bin/ssh $*
       chpwd
    else
       /usr/bin/ssh
    fi
}

## Powerline
GOPATH=/usr/local
function powerline_precmd() {
    PS1="$($GOPATH/bin/powerline-go -error $? -jobs ${${(%):%j}:-0} -modules venv,ssh,cwd,perms,jobs,exit,root -path-aliases \~/src/ahv/=\~ahv,\~/src/aos/=\~aos,\~/src/files/=\~files,\~/src/foundation/=\~foun,\~/src/lcm/=\~lcm,\~/src/move/=\~move,\~/src/ncc/=\~ncc,\~/src/pc/=\~pc,\~/downloads/=\~d,\~/Downloads/=\~d,\/Volumes\/NTNX\/downloads=\~d,/Volumes/GoogleDrive/マイドライブ/cases/=\~c,\~/cases/=~c)"

    # Uncomment the following line to automatically clear errors after showing
    # them once. This not only clears the error for powerline-go, but also for
    # everything else you run in that shell. Don't enable this if you're not
    # sure this is what you want.

    #set "?"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    install_powerline_precmd
fi
