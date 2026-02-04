#!/usr/bin/env zsh
if [[ -d ~/dot-files/ ]];then
    root_dir=~/dot-files
else
    root_dir=/usr/local/dot-files
fi
source ${root_dir}/.zshrc.base
source ${root_dir}/.zshrc.alias
source ${root_dir}/.zshrc.shell
source ${root_dir}/.zshrc.extra
[[ -f ~/src/masa-tools/profile-dd.sh ]] && source ~/src/masa-tools/profile-dd.sh;true

# Created by `pipx` on 2025-10-23 12:12:13
export PATH="$PATH:/Users/mkashi/.local/bin"

# BEGIN SCFW MANAGED BLOCK
alias npm="scfw run npm"
alias pip="scfw run pip"
alias poetry="scfw run poetry"
export SCFW_DD_AGENT_LOG_PORT="10365"
export SCFW_DD_LOG_LEVEL="ALLOW"
export SCFW_HOME="/Users/mkashi/.scfw"
# END SCFW MANAGED BLOCK
