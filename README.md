frolicd.nvim
============

[frolicd](https://github.com/thjbdvlt/frolicd) integration in [neovim](https://github.com/neovim/neovim).

installation
------------

just install it as any other neovim plugin, then require it and map any key to its main and only function:

```lua
require'frolicd`
vim.api.nvim_set_keymap(
    'n',
    '-',
    ':lua Frolicd()<cr>',
    {noremap = true, silent = true}
)
```

if you want to use `frolicd` instead of `netrw` when neovim is launched with `nvim $x` where `$x` is a directory, replace `require'frolicd'` with:

```lua
require'frolicd`.setup()
```
