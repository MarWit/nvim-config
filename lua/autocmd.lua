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
