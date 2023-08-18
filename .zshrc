## Env
export PATH=/usr/local/bin:$PATH:~/bin
export HISTSIZE=100000
export SAVEHIST=100000

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Google Cloud SDK
if [ -f ~/google-cloud-sdk/path.zsh.inc ]; then . ~/google-cloud-sdk/path.zsh.inc; fi

# gcloud command completion
if [ -f ~/google-cloud-sdk/completion.zsh.inc ]; then . ~/google-cloud-sdk/completion.zsh.inc; fi

## Datadog
if [ "$(hostname)" = "COMP-P7VR73TR7F" ];then
   # Datadog related settings
   source ~/src/masa-tools/profile-dd.sh
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
    # kubectl
    [[ $commands[kubectl] ]] && source <(kubectl completion zsh)
fi
if [ -f $(brew --prefix)/bin/pyenv ]; then
    eval "$(pyenv init --path)"
fi
if [ -d $(brew --prefix)/opt/openjdk/bin ]; then
    export PATH="$(brew --prefix)/opt/openjdk/bin:$PATH"
fi

if [ -f $(brew --prefix)/bin/nodebrew ]; then
    export PATH=$HOME/.nodebrew/current/bin:$PATH
fi

if [ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ];then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Coloring
if [ -x $(brew --prefix)/bin/gdircolors -a -f ~/.colorrc ]; then
    eval `gdircolors ~/.colorrc`
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
setopt extended_history
setopt interactivecomments
# Case-insensitive for completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
function chpwd() {
    if [ -x $(brew --prefix)/bin/gls ]
    then
	gls -ltr --color=auto
    else
	ls -ltrFG
    fi
}
# Completion without ls
function expand-or-complete-or-list-files() {
    if [[ $#BUFFER == 0 ]]; then
        BUFFER="ls -t ./"
        CURSOR=6
        zle list-choices
        zle backward-kill-line
	CURSOR=2
    else
	zle expand-or-complete
        #zle expand-or-complete-or-list-hosts
    fi
}
zle -N expand-or-complete-or-list-files
# Bind to tab
bindkey '^I' expand-or-complete-or-list-files
bindkey '^U' backward-kill-line

## Alias
if [ -x $(brew --prefix)/bin/gls ];then
    alias ls='gls --color=auto'
    alias la='gls -la --color=auto'
    alias ll='gls -l --color=auto'
else
    alias ls='ls -FG'
    alias la='ls -alFG'
    alias ll='ls -lFG'
fi
if [ -x $(brew --prefix)/bin/gdate ];then
    alias date='gdate'
fi
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias gtags='gtags --gtagslabel=pygments -v'
alias emacs='emacs -nw'
alias dot-files='cd ~/dot-files'
alias .zshrc='emacs ${ZDOTDIR-~}/.zshrc && . ${ZDOTDIR-~}/.zshrc'
alias .zprofile="emacs ${ZDOTDIR-~}/.zprofile && . ${ZDOTDIR-~}/.zprofile"
alias .emacs='emacs ~/.emacs'
alias av='aws-vault exec sso-sandbox-account-admin --'
for c in aws sam eksctl;do alias $c="av $c";done
alias cs='cd ~/cases'
alias c='code .'
alias d='cd ~/downloads'
alias e='emacs -nw'
alias ea='extract-all'
alias f='open .'
alias o='open'
alias gb='git branch -a'
alias gco='git checkout'
alias gcm='git add --all && git commit -m update && git push'
alias gcl='git clone'
alias gd='git diff'
alias gp='git pull --all'
alias gs='git status'
alias h='cd ~'
alias history='history -t "%F %T"'
alias jq='jq -C'
alias kube='kubectl'
alias less='less -R'
alias pubkey='op item get id_rsa --fields label="public key"'
alias src='cd ~/src'
alias s='src'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -s {txt,log,out}=emacs
alias -s {png,PNG,jpg,JPG,bmp,BMP,xls,XLS,xlsx,XLSX,doc,DOC,docx,DOCX,ppt,PPT,pptx,PPTX,pdf,PDF,zip,ZIP,tar,TAR,gz,GZ}=open
alias -s {html,HTML}=elinks
function ssh() {
    if [ -n "$*" ];then
	/usr/bin/ssh $*
	# Erase ssh hostname from terminal tab name
	echo -en "\033]2;\007"
    else
       /usr/bin/ssh
    fi
}
for h in $(awk '/^[^#]/{print $2}' </etc/hosts | tail +4);do alias $h="ssh $h";done
function gssh() {
    gcloud compute ssh --plain masafumi_kashiwagi_datadoghq_com@$*
}

## Powerline
GOPATH=$(brew --prefix)
PATH_ALIASES=(
    '~/downloads/=~d'
    '~/Downloads/=~d'
)
for d in $(find ~/src -type d -maxdepth 1 -mindepth 1);do
    PATH_ALIASES+='~/src/'$(basename $d)'/=~s:'$(basename $d)
done
function powerline_precmd() {
    PS1="$($GOPATH/bin/powerline-go -error $? -jobs ${${(%):%j}:-0} -modules venv,ssh,cwd,perms,aws,jobs,exit,root,terraform-workspace,docker,git,goenv -path-aliases ${(pj:,:)PATH_ALIASES})"
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
