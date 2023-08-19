# dot-files
```
cd ~
# git clone this repo
mkdir ~/.zsh
ln -s dot-files/.zshrc ~/.zsh/.zshrc
ln -s dot-files/.zshrc.base ~/.zshrc
ln -s dot-files/.emacs ~/
ln -s dot-files/.colorrc ~/
ln -s dot-files/.screenrc ~/
```
ターミナルの設定で､シェルのコマンドを実行に`export ZDOTDIR=~/.zsh; exec script ~/.logs/$(date +%Y%m%d%H%M%S)-$$.log zsh`とシェル内で実行にチェックを入れる
