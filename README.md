# dot-files
## Mac
```
cd ~
git clone git@github.com:masafm/dot-files.git
mkdir ~/.zsh
ln -s ../dot-files/.zshrc ~/.zsh/.zshrc
ln -s dot-files/.zshrc.base ~/.zshrc
ln -s dot-files/.emacs ~/
ln -s dot-files/.colorrc ~/
ln -s dot-files/.screenrc ~/
```
ターミナルの設定で､シェルのコマンドを実行に`export ZDOTDIR=~/.zsh; exec script ~/.logs/$(date +%Y%m%d%H%M%S)-$$.log zsh`とシェル内で実行にチェックを入れる

## Ubuntu
```
cd ~
apt install zsh zsh-autosuggestions fzf golang git emacs
git clone git@github.com:masafm/dot-files.git
ln -s dot-files/.zshrc ~/.zshrc
ln -s dot-files/.emacs ~/
ln -s dot-files/.colorrc ~/
ln -s dot-files/.screenrc ~/
chsh -s /usr/bin/zsh
# exit and login again
go install github.com/justjanne/powerline-go@latest
```

## RHEL
```
cd ~
yum install zsh golang git util-linux-user emacs
git clone git@github.com:masafm/dot-files.git
ln -s dot-files/.zshrc ~/.zshrc
ln -s dot-files/.emacs ~/
ln -s dot-files/.colorrc ~/
ln -s dot-files/.screenrc ~/
chsh -s /usr/bin/zsh
# exit and login again
go install github.com/justjanne/powerline-go@latest
```
