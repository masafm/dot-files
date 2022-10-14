if [ "$(hostname)" = "C02Y41YCJHD3" ];then
   # Nutanix related settings
   source ~/ntnx-tools/zprofile.sh
fi

if [ -d "/opt/homebrew/bin" ];then
   # Set PATH, MANPATH, etc., for Homebrew.
   exportPATH="/opt/homebrew/bin:$PATH"
   eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH=$PATH:~/bin
export HISTSIZE=10000
export SAVEHIST=100000

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
# completion without ls
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
# bind to tab
bindkey '^I' expand-or-complete-or-list-files
bindkey '^U' backward-kill-line

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
function ssh() {
    if [ -n "$*" ];then
       echo -en "\033]1; "$(echo "$*" | perl -pe 's/\s*-[^\s]+\s+[^\s]+\s*//g')" \007"
       /usr/bin/ssh $*
       chpwd
    else
       /usr/bin/ssh
    fi
}
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
fi

if [ -f $(brew --prefix)/bin/pyenv ]; then
    eval "$(pyenv init --path)"
fi

function archive-case() {
    if [ -z "$1" ];then
       echo "Please specify case number."
       return
    fi
    if [ -z $(echo "$1" | egrep '^[0-9]{7,8}$') ];then
       echo "Illegal case number."
       return
    fi
    case_number=$(printf '%08d' $1)
    if [ $# -ge 2 ];then
       # Unarchiving
       source=$(find ~/cases/ -maxdepth 1 -type d -path "*${case_number}*" | head -1)
       target=~/downloads/
       echo "Unarchiving $source" >>~/logs/case-archive.log
    else
       # Archiving
       source=$(find ~/downloads/ -maxdepth 1 -type d -path "*${case_number}*" | head -1)
       target=~/cases/
       echo "Archiving $source" >>~/logs/case-archive.log
    fi
    if [ ! -d "$source" ];then
       echo "$source does not exist" >>~/logs/case-archive.log
       return
    fi
    if [ ! -d "$target" ];then
       echo "$target does not exist" >>~/logs/case-archive.log
       return
    fi
    tmp=$(find "$target" -path "*$case_number*" -mindepth 2 -maxdepth 2)
    if [ -n "$tmp" ];then
       echo "Case $case_number is already archived/unarchived"
       return
    fi
    nohup sh -c "/bin/mv -fv '$source' '$target' >>~/logs/case-archive.log 2>&1; echo 'Moving $source to $target completed' >>~/logs/case-archive.log" &
}

function unarchive-case() {
    if [ -z "$1" ];then
       echo "Please specify case number."
       return
    fi
    archive-case "$1" "unarchive"
}

function jump-case() {
    if [ -z "$1" ];then
       echo "Please specify case number."
       return
    fi
    if [ -z $(echo "$1" | egrep '^[0-9]{7,8}$') ];then
       echo "Illegal case number."
       return
    fi
    case_number=$(printf '%08d' $1)
    downloads=$(find ~/downloads/ -maxdepth 1 -type d -path "*${case_number}*" | head -1)
    if [ -d "$downloads" ];then
       cd "$downloads"
       return
    fi
    cases=$(find ~/cases/ -maxdepth 1 -type d -path "*${case_number}*" | head -1)
    if [ -d "$cases" ];then
       cd "$cases"
       return
    fi
    echo "$case_number does not exit"
}

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
