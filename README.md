frolicd.nvim
============

[neovim](https://github.com/neovim/neovim) integration of [frolicd](https://github.com/thjbdvlt/frolicd) directory browser.

installation
------------

just install it as any other neovim plugin, then require it at map any key to its main function:

```lua
require'frolicd`
vim.api.nvim_set_keymap(
    'n',
    '-',
    ':lua Frolicd()<cr>',
    {noremap = true, silent = true}
)
```

if you want to use `frolicd` instead of `netrw` when neovim is launched with `nvim $x` where `$x` is a directory, replace `require'frolicd` with:

```lua
require'frolicd`.setup()
```
