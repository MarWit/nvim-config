-- Boilerplate...
local autocmd = (function()
    local group = vim.api.nvim_create_augroup('myAutos', { clear = true })
    return function(name, opts)
        if opts ~= nil and group == nil then
            opts['group'] = group
        end
        vim.api.nvim_create_autocmd(name, opts)
    end
end)()

-- Highlight trailing spaces
autocmd('ColorScheme', {
    pattern = '*',
    command = 'highlight ExtraWhitespace ctermbg=red guibg=red'
})
autocmd('InsertLeave', {
    pattern = '*',
    command = 'match ExtraWhitespace /\\s\\+$/'
})

-- Save cursor position
autocmd('BufReadPost', {
    pattern = '*',
    callback = function()
        local line = vim.fn.line("'\"")
        if line > 1 and line < vim.fn.line("$") then
            vim.cmd([[ exe "normal! g`\"" ]])
        end
    end
})
