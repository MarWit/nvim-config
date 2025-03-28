local configs = require('nvim-treesitter.configs')
configs.setup {
    ensure_installed = {
        'c',
        'lua',
        'vim',
        'vimdoc',
        'c_sharp',
        'rust',
        'python',
        'markdown',
        'markdown_inline',
        'robot',
        'yaml',
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
