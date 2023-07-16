## nvimの設定
1. 初回起動時にvim-plugの設定が入っていないエラーになる場合は先にダウンロードする
https://github.com/junegunn/vim-plug
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
2. nvimを開けたら、コマンドから`PlugInstall`を実行する
```
:PlugInstall
```
3. tree-sitterやmasonなどデフォルトでプラグインのインストールが実行されるものがあるので正常終了することを確認する
