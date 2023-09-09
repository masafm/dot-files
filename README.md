# dot-files
## Mac
`brew install coreutils diffutils ed findutils gawk gnu-sed gnu-tar grep gzip fzf powerline-go pstree git pyenv pyenv-virtualenv wget wireguard-go wireguard-tools zsh-autosuggestions zsh-completions zsh-syntax-highlighting emacs global`
```
cd ~ && git clone git@github.com:masafm/dot-files.git
ln -s dot-files/.zshrc ~/
ln -s dot-files/.emacs ~/
ln -s dot-files/.colorrc ~/
ln -s dot-files/.screenrc ~/
```

## Linux
Ubuntu: `apt update -y && apt install -y zsh zsh-autosuggestions fzf golang git emacs global`
RHEL: `yum install -y zsh golang git util-linux-user emacs`
```
cd ~ && git clone git@github.com:masafm/dot-files.git && sudo mv dot-files /usr/local/
ln -s /usr/local/dot-files/.zshrc ~/
ln -s /usr/local/dot-files/.emacs ~/
ln -s /usr/local/dot-files/.colorrc ~/
ln -s /usr/local/dot-files/.screenrc ~/
chsh -s /usr/bin/zsh
# exit and login again
env GOPATH=/opt/powerline-go go install github.com/justjanne/powerline-go@latest
git clone git@github.com:powerline/fonts.git && cd fonts && ./install.sh && cd - && rm -rf ./fonts
```
