local configs = require('nvim-treesitter.configs')
configs.setup {
    ensure_installed = {
        'c',
        'lua',
        'vim',
        'c_sharp',
        'rust'
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
