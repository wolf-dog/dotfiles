# WSL環境セットアップ手順

## Ctrl2Cap

以下からダウンロードしてインストールする。
https://learn.microsoft.com/ja-jp/sysinternals/downloads/ctrl2cap


## Cica font

以下からダウンロードしてインストールする。
https://github.com/miiton/Cica


## WSL

Powershellからインストールする。

```
wsl --install
```


## Ubuntu

Microsoft storeからインストールする。


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
```

```
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

fisher install jethrokuan/z
fisher install wolf-dog/styriga
```

## Neovim

```
sudo apt install build-essential

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar -C ./ -xzf nvim-linux-x86_64.tar.gz
sudo mv nvim-linux-x86_64/bin/* /usr/local/bin/
sudo mv nvim-linux-x86_64/lib/* /usr/local/lib/
sudo mv nvim-linux-x86_64/share/* /usr/local/share/
```
