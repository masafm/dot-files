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
Ubuntu: `apt update -y && apt install -y zsh zsh-autosuggestions fzf golang git emacs`
RHEL: `yum install -y zsh golang git util-linux-user emacs`
```
cd /usr/local/ && git clone git@github.com:masafm/dot-files.git
ln -s /usr/local/dot-files/.zshrc ~/
ln -s /usr/local/dot-files/.emacs ~/
ln -s /usr/local/dot-files/.colorrc ~/
ln -s /usr/local/dot-files/.screenrc ~/
chsh -s /usr/bin/zsh
# exit and login again
go install github.com/justjanne/powerline-go@latest
```
