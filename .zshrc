# Base
source ~/dot-files/.zshrc.base

# Functions & Aliases
source ~/dot-files/.zshrc.alias

# Shell
source ~/dot-files/.zshrc.shell

# Extra
source ~/dot-files/.zshrc.extra

# Datadog
if [[ $(hostname) = COMP-P7VR73TR7F ]];then
   source ~/src/masa-tools/profile-dd.sh
fi
