if [[ -d ~/dot-files/ ]];then
    root_dir=~/dot-files
else
    root_dir=/usr/local/dot-files
fi

# Base
source ${root_dir}/.zshrc.base

# Functions & Aliases
source ${root_dir}/.zshrc.alias

# Shell
source ${root_dir}/.zshrc.shell

# Extra
source ${root_dir}/.zshrc.extra

# Datadog
if [[ $(hostname) == COMP-P7VR73TR7F ]];then source ~/src/masa-tools/profile-dd.sh;fi
