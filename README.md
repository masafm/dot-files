# dot-files
## Mac
```
cd ~ && git clone git@github.com:masafm/dot-files.git
ln -s dot-files/.zshrc ~/
ln -s dot-files/.emacs ~/
ln -s dot-files/.colorrc ~/
ln -s dot-files/.screenrc ~/
```

## Linux
Ubuntu: `apt update -y && apt install -y zsh zsh-autosuggestions fzf golang git emacs fonts-powerline`
RHEL: `yum install -y zsh golang git util-linux-user emacs`
```
cd /usr/local/ && sudo git clone git@github.com:masafm/dot-files.git && sudo chown -R $(id -u):$(id -g) dot-files
ln -s /usr/local/dot-files/.zshrc ~/
ln -s /usr/local/dot-files/.emacs ~/
ln -s /usr/local/dot-files/.colorrc ~/
ln -s /usr/local/dot-files/.screenrc ~/
chsh -s /usr/bin/zsh
# exit and login again
go install github.com/justjanne/powerline-go@latest
git clone git@github.com:powerline/fonts.git && cd fonts && ./install.sh
```
