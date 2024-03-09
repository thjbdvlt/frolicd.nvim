function Frolicd(opts)
    -- call `frolicd` in terminal emulator (in a new buffer) 
    -- and edit the file it outputs.
    --
    -- no default option (but not nil to avoid error)
    opts = opts or ""
    -- create a new buffer
    local bufnr = vim.api.nvim_create_buf(false, true)
    -- go to this buffer
    vim.api.nvim_set_current_buf(bufnr)
    -- no number (neither relative), but only for this buffer
    vim.cmd[[setlocal nonumber]]
    vim.cmd[[setlocal norelativenumber]]
    -- temporary file to store result
    local outputfile = vim.fn.tempname()
    -- open a terminal and call `frolicd` with options, and redirect
    -- its output to the temporary file.
    local cmd = 'frolicd ' .. opts .. ' > ' .. outputfile
    vim.fn.termopen(cmd, {
        on_exit = function(_)
            -- when terminal exits: delete its buffer, open the 
            -- temporary filetype storing the result, read its content
            -- (first line) and open the selected file.
            vim.api.nvim_buf_delete(bufnr, { force = true })
            local result = io.open(outputfile):read()
            vim.cmd("e " .. result)
            vim.fn.delete(outputfile)
        end
    })
    vim.cmd[[startinsert]]
end

local function setup()
    -- call `:lua Frolicd()` if neovim is entered with a directory
    -- as argument.
    --
    local augroup = vim.api.nvim_create_augroup(
        "FrolicdVimEnter", { clear = true }
    )
    vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = function()
            local first_arg = vim.v.argv[3]
            if first_arg and vim.fn.isdirectory(first_arg) == 1 then
                vim.cmd(":bd 1")
                Frolicd("")
            end
        end,
        group = augroup,
    })
end
return { setup = setup }
