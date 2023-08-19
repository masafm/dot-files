# Base
source ~/.zshrc

# Functions & Aliases
source ~/dot-files/.zshrc.alias

# zsh
source ~/dot-files/.zshrc.shell

# Brew
source ~/dot-files/.zshrc.brew

# Powerline
source ~/dot-files/.zshrc.powerline

# Datadog
if [ "$(hostname)" = "COMP-P7VR73TR7F" ];then
   # Datadog related settings
   source ~/src/masa-tools/profile-dd.sh
fi
