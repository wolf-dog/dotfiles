# WSL環境セットアップ手順

## Ctrl2Cap

以下からダウンロードしてインストールする。
https://learn.microsoft.com/ja-jp/sysinternals/downloads/ctrl2cap


## UDEV Gothic font

以下からダウンロードしてインストールする。
https://github.com/yuru7/udev-gothic


## WSL

Powershellからインストールする。

```
wsl --install
```


## Ubuntu

Microsoft storeからインストールする。


## Locale

英語UTF8ロケールをインストールしてシステム既定に設定する。

```
sudo apt install language-pack-en
sudo update-locale LANG=en_US.UTF-8
```

`update-locale` 実行時にperlのロケール警告が出ることがあるが、
現在のシェルの `LANG` が未生成のロケールを指しているために出るものなので無視してよい。

Powershellからシャットダウンして再起動すると反映される。

```
wsl --shutdown
```


## Alacritty

PowershellからWinGetでインストールする。

```
winget install alacritty
```

Windows上で `dotfiles/.config/alacritty/*` にある設定ファイルを
`Users/{User}/AppData/Roaming/alacritty/` に配置する。
`alacritty-wsl.toml` を `alacritty-local.toml` にリネームする。


## Fish

```
sudo apt update && sudo apt upgrade
sudo apt install fish
```

```
sudo ln -s /usr/bin/fish /usr/local/bin/fish
echo '/usr/local/bin/fish' | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

ここからはfish上で実行する。
```

```
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

fisher install jethrokuan/z
fisher install wolf-dog/styriga
```

## Neovim

```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar -C ./ -xzf nvim-linux-x86_64.tar.gz
sudo mv nvim-linux-x86_64/bin/* /usr/local/bin/
sudo mv nvim-linux-x86_64/lib/* /usr/local/lib/
sudo mv nvim-linux-x86_64/share/* /usr/local/share/
```

設定ファイルへのシンボリックリンクを張る。
この設定はVS Code Neovimと素のNeovimの両方で共用する。

```
ln -sfn ~/dotfiles/.config/nvim ~/.config/nvim
```

プラグインマネージャにvim-plugを使っているので、
インストールしてから `nvim` を起動し `:PlugInstall` を実行する。

```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
