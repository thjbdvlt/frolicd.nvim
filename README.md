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
    -- i map with optiong '-c' which says:
    -- "when press enter without selecting a file to edit,
    -- ask for the creation of a new file (which will be
    -- edited in neovim)"
    ':lua Frolicd("-c")<cr>',
    {noremap = true, silent = true}
)
```
