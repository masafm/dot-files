# dot-files
## Mac
`brew install coreutils diffutils ed findutils gawk gnu-sed gnu-tar grep gzip fzf golang pstree git pyenv pyenv-virtualenv wget wireguard-go wireguard-tools zsh-autosuggestions zsh-completions zsh-syntax-highlighting emacs global font-source-code-pro-for-powerline olets/tap/zsh-abbr`
```
cd ~ && git clone git@github.com:masafm/dot-files.git
ln -s dot-files/.zshrc ~/
ln -s dot-files/.emacs ~/
ln -s dot-files/.colorrc ~/
ln -s dot-files/.screenrc ~/
sudo env GOPATH=/opt/powerline-go go install github.com/justjanne/powerline-go@latest
```

## Linux
Ubuntu: `apt update -y && apt install -y zsh zsh-autosuggestions zsh-syntax-highlighting fzf golang git emacs global`
RHEL: `yum install -y zsh golang git util-linux-user emacs`
```
cd ~ && git clone git@github.com:masafm/dot-files.git && sudo mv dot-files /usr/local/
ln -s /usr/local/dot-files/.zshrc ~/
ln -s /usr/local/dot-files/.emacs ~/
ln -s /usr/local/dot-files/.colorrc ~/
ln -s /usr/local/dot-files/.screenrc ~/
chsh -s /usr/bin/zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# exit and login again
sudo env GOPATH=/opt/powerline-go go install github.com/justjanne/powerline-go@latest
git clone git@github.com:powerline/fonts.git && cd fonts && ./install.sh && cd - && rm -rf ./fonts
brew install olets/tap/zsh-abbr
```
