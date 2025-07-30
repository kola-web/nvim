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


- vtsls (id: 1)
  - Version: 0.2.9
  - Root directory: ~\project\GeneB-miniprogram
  - Command: { "C:\\Users\\kola\\AppData\\Local\\LazyVim-data\\mason\\bin\\vtsls.CMD", "--stdio" }
  - Settings: {
      complete_function_calls = true,
      javascript = {
        inlayHints = <1>{
          enumMemberValues = {
            enabled = true
          },
          functionLikeReturnTypes = {
            enabled = true
          },
          parameterNames = {
            enabled = "literals"
          },
          parameterTypes = {
            enabled = true
          },
          propertyDeclarationTypes = {
            enabled = true
          },
          variableTypes = {
            enabled = false
          }
        },
        suggest = <2>{
          completeFunctionCalls = true
        },
        updateImportsOnFileMove = <3>{
          enabled = "always"
        }
      },
      typescript = {
        inlayHints = <table 1>,
        suggest = <table 2>,
        updateImportsOnFileMove = <table 3>
      },
      vtsls = {
        autoUseWorkspaceTsdk = true,
        enableMoveToFileCodeAction = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true
          },
          maxInlayHintLength = 30
        },
        tsserver = {
          globalPlugins = { {
              configNamespace = "typescript",
              enableForWorkspaceTypeScriptVersions = true,
              languages = { "vue" },
              location = "C:\\Users\\kola\\AppData\\Local\\LazyVim-data\\mason/packages/vue-language-server//node_modules/@vue/language-server",
              name = "@vue/typescript-plugin"
            } }
        }
      }
    }
  - Attached buffers: 12
