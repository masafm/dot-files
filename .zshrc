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
[[ $(hostname) == COMP-P7VR73TR7F ]] && source ~/src/masa-tools/profile-dd.sh;true
