function Frolicd(opts)
    -- call frolicd (in a new buffer) and edit it's output.
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
    vim.fn.termopen('frolicd ' .. opts .. ' > ' .. outputfile, {
        on_exit = function(_)
        -- when terminal exits: delete its buffer, open the 
        -- temporary filetype storing the result, read its content
        -- (first line) and open the selected file.
            vim.api.nvim_buf_delete(bufnr, { force = true })
            local result = io.open(outputfile):read()
            --if vim.fn.isdirectory(result) == 0 then
                vim.cmd("e " .. result)
                vim.fn.delete(outputfile)
            --end
        end
    })
    vim.cmd[[startinsert]]
end

function FrolicdFloating(opts)
    local curwin = vim.api.nvim_get_current_win()
    local w = vim.api.nvim_win_get_width(curwin)
    local h = vim.api.nvim_win_get_height(curwin) / 2
    local bufnr = vim.api.nvim_create_buf(false, true)
    local winid = vim.api.nvim_open_win( bufnr, true,
        { width=w, height=h, col=0, row=0, relative='win' }
    )
    vim.cmd[[setlocal nonumber]]
    vim.cmd[[setlocal norelativenumber]]
    local outputfile = vim.fn.tempname()
    opts = opts or ""
    vim.fn.termopen('frolicd ' .. opts .. ' > ' .. outputfile, {
        on_exit = function(_)
            vim.api.nvim_win_close(winid, true)
            vim.api.nvim_buf_delete(bufnr, { force = true })
            local result = io.open(outputfile):read()
            if vim.fn.isdirectory(result) == 0 then
                vim.cmd("e " .. result)
                vim.fn.delete(outputfile)
            end
        end
    })
    vim.cmd[[startinsert]]
end

-- pris depuis telescope
local ts_group = vim.api.nvim_create_augroup("TelescopeOnEnter", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        local first_arg = vim.v.argv[3]
        if first_arg and vim.fn.isdirectory(first_arg) == 1 then
            -- Vim creates a buffer for folder. Close it.
            vim.cmd(":bd 1")
            --require("telescope.builtin").find_files({ search_dirs = { first_arg } })
            Frolicd(' -c ')
        end
    end,
    group = ts_group,
})
