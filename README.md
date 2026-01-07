# windows环境下需要安装的软件

```txt
Neovim.Neovim
Microsoft.Git
Volta.Volta
BurntSushi.ripgrep.MSVC
JesseDuffield.lazygit
ajeetdsouza.zoxide
junegunn.fzf
sharkdp.fd
Python.Python
zig.zig
7zip.7zip
DEVCOM.LuaJIT
DenoLand.Deno
```

获取当前buffer的filetype

```lua
lua print(vim.bo.filetype)
```

## Q&A

1. wsl 剪切板处理

```bash
sudo apt install -y xsel xclip
```
