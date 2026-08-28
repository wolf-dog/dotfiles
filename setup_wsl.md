# WSL environment setup

## Ctrl2Cap

Download and install from:
https://learn.microsoft.com/ja-jp/sysinternals/downloads/ctrl2cap


## UDEV Gothic font

Download and install the JPDOC variant from:
https://github.com/yuru7/udev-gothic


## WSL

Install from PowerShell.

```
wsl --install
```


## Ubuntu

Install from the Microsoft Store.


## Locale

Install the English UTF-8 locale and set it as the system default.

```
sudo apt install language-pack-en
sudo update-locale LANG=en_US.UTF-8
```

`update-locale` may print a perl locale warning. It appears because the current
shell's `LANG` points at a locale that has not been generated yet, so it is safe
to ignore.

Shut down from PowerShell and restart for the change to take effect.

```
wsl --shutdown
```


## Alacritty

Install from PowerShell with WinGet.

```
winget install alacritty
```

On Windows, place the config files from `dotfiles/.config/alacritty/*` into
`Users/{User}/AppData/Roaming/alacritty/`.
Rename `alacritty-wsl.toml` to `alacritty-local.toml`.


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

Run the rest from fish.

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

Symlink the config directory.
This config is shared by both VS Code Neovim and plain Neovim.

```
ln -sfn ~/dotfiles/.config/nvim ~/.config/nvim
```

vim-plug is used as the plugin manager, so install it, then launch `nvim` and
run `:PlugInstall`.

```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
