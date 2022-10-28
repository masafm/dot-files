## Env
export PATH=$PATH:~/bin
export HISTSIZE=10000
export SAVEHIST=100000

## Nutanix
if [ "$(hostname)" = "C02Y41YCJHD3" ];then
   # Nutanix related settings
   source ~/sre/masa-tools/profile-ntnx.sh
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
# Coloring
autoload -Uz colors
colors
# Case-insensitive for completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
function chpwd() {
    # Set terminal window name
    echo -en "\033]2; "$(pwd | perl -pe 's#/Users/mkashi#~#;s#/[^/]+$##')" \007"
    # Set teminal tab name
    echo -en "\033]1; "$(pwd | perl -pe 's#/Users/mkashi#~#;s#.*?/(\d+ \| [^/]+).*#$1#')" \007"
    ls -FG
}
chpwd
# Completion without ls
function expand-or-complete-or-list-files() {
    if [[ $#BUFFER == 0 ]]; then
        BUFFER="ls -FG ./"
        CURSOR=7
        zle list-choices
        zle backward-kill-line
	CURSOR=6
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
alias gb='git branch -a'
alias gcommit='git add --all && git commit -m update && git push'
alias gc='git checkout'
alias gd='git diff'
alias gs='git status'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -s {txt,log,out}=emacs
alias -s {png,PNG,jpg,JPG,bmp,BMP,xls,XLS,xlsx,XLSX,doc,DOC,docx,DOCX,ppt,PPT,pptx,PPTX,pdf,PDF,zip,ZIP,tar,TAR,gz,GZ}=open
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
    PS1="$($GOPATH/bin/powerline-go -error $? -jobs ${${(%):%j}:-0} -modules venv,ssh,cwd,perms,jobs,exit,root -path-aliases \
\~/src/ahv/=\~ahv,\
\~/src/aos/=\~aos,\
\~/src/files/=\~files,\
\~/src/foundation/=\~foun,\
\~/src/lcm/=\~lcm,\
\~/src/move/=\~move,\
\~/src/ncc/=\~ncc,\
\~/src/pc/=\~pc,\
\~/downloads/=\~d,\
\~/Downloads/=\~d,\
/Volumes/NTNX/downloads=\~d,\
/Volumes/GoogleDrive/マイドライブ/cases/=\~c,\
\~/cases/=~c\
)"
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

function extract-all() {
    find . \( -name '*.zip' -o -name '*.tar.gz' -o -name '*.tgz' \) -maxdepth 1 -type f | while read f
    do
	echo Extracting $f
	if [[ "$f" =~ \.zip$ ]]
	then
	    unzip "$f" >/dev/null && rm -f "$f" &
	elif [[ "$f" =~ \.(tar\.gz|tgz)$ ]]
	then
	    tar xf "$f" >/dev/null && rm -f "$f" &
	else
	    open "$f" && rm -f "$f" &
	fi
    done
    wait
}
