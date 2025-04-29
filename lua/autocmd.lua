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

local add_shebang = (function(bang)
    return function()
        vim.fn.execute(('normal! I%s\n\n'):format(bang))
    end
end)

-- Highlight trailing spaces and tabs
autocmd('ColorScheme', {
    pattern = '*',
    command = [[
        highlight ExtraWhitespace guibg=red
        highlight TabsBad guifg=#4C304B gui=underdashed
        highlight CorrectFormatting gui=reverse
    ]]
})

autocmd({'BufReadPost', 'InsertLeave'}, {
    pattern = '*',
    callback = function()
        vim.fn.matchadd('ExtraWhitespace', '\\s\\+$')
        vim.fn.matchadd('TabsBad', '\\t')
        vim.fn.matchadd('CorrectFormatting', ',[^ \\r]\\+')
    end
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

-- Insert shebangs in files
autocmd('BufNewFile', {
    pattern = '*.py',
    callback = add_shebang('#!/bin/env python3')
})

autocmd('BufNewFile', {
    pattern = '*.sh',
    callback = add_shebang('#!/bin/bash')
})

-- .robot for Robot Framework files
autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.robot',
    command = 'set ft=robot',
})

-- .repl for Renode Platform files
autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.repl',
    command = 'set ft=repl',
})

-- .resc for Renode Scripts
autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.resc',
    command = 'set ft=resc',
})

-- .envrc is envrc
autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '.envrc',
    command = 'set ft=envrc',
})

-- Diagnostics symbols
autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
        vim.cmd([[ sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl= ]])
        vim.cmd([[ sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl= ]])
        vim.cmd([[ sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl= ]])
        vim.cmd([[ sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl= ]])
    end
})

-- Allow for <path>:<line> vim argument
autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*:*',
    callback = vim.schedule_wrap(function()
        local file = vim.fn.expand('%')
        if vim.fn.filereadable(file) ~= 0 then
            return
        end

        local _, _, filepath, line_no = file:find('^(.+):(%d+)$')

        if vim.fn.filereadable(filepath) == 0 then
            return
        end

        local bufnr = vim.fn.bufnr('%')
        vim.cmd.bwipeout(bufnr)
        vim.cmd('keepalt edit ' .. filepath)
        vim.api.nvim_win_set_cursor(0, { tonumber(line_no), 0 })
    end)
})
