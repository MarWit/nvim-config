-- Default plug-ins path
local plugins_path = vim.fn.stdpath("config") .. "/plug-ins"

-- Install lazy.nvim if its not installed yet
local lazynvim_path = plugins_path .. "/lazy.nvim"
if vim.fn.isdirectory(lazynvim_path) == 0 then
    vim.fn.system(('git clone "https://github.com/folke/lazy.nvim" %s'):format(lazynvim_path))
end

-- Add lazy.nvim to namespace
vim.opt.rtp:prepend(lazynvim_path)
local lazy = require("lazy")

-- Default configuration for lazy.nvim
local lazy_config = {
    root = plugins_path,
    lockfile = lazynvim_path .. "/lazy-lock.json"
}

-- Install plugins
lazy.setup({
    {
        "navarasu/onedark.nvim",
        config = function()
            require('onedark').setup {
                style = 'warm',
                transparent = true,
            }
            require('onedark').load()
        end
    },
    "tpope/vim-sensible",
    "sheerun/vim-polyglot",
    "tpope/vim-repeat",
    "Joe-Withey/v-star",
    {
        "ellisonleao/glow.nvim",
        config = true,
        cmd = "Glow",
    },
    {
        "karb94/neoscroll.nvim",
        config = true,
        opts = {
            easing_function = "cubic"
        }
    },
    "mhinz/vim-startify",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "NvChad/nvim-colorizer.lua",
        config = true,
    },
    {
        "folke/which-key.nvim",
        config = true,
    },
    {
       "xiyaowong/nvim-cursorword",
       init = function()
           vim.g.cursorword_disable_at_startup = false
       end
    },
    "HiPhish/rainbow-delimiters.nvim",
    {
        "monaqa/dial.nvim",
        config = function()
            local augend = require("dial.augend")
            local default = require("dial.config").augends.group.default
            require("dial.config").augends:on_filetype {
                cs = {
                    augend.constant.new {
                        elements = { "public", "private", "protected" },
                    },
                    augend.constant.new {
                        elements = { "true", "false" },
                    },
                    augend.constant.new {
                        elements = { "&&", "||" },
                    },
                    unpack(default),
                },
            }
        end
    },
    "sQVe/sort.nvim",
    {
        "nvim-lualine/lualine.nvim",
        config = true,
        opts = {
            tabline = {
                lualine_a = { 'buffers' }
            }
        }
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = true,
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require('Comment').setup()

            local ft = require('Comment.ft')
            ft.set('repl', {'// %s', '/*%s*/'})
        end
    },
    {
        "nvim-tree/nvim-web-devicons",
        tag = "nerd-v2-compat",
    },
    "mbbill/undotree",
    "ibhagwan/fzf-lua",
    {
        "nvim-tree/nvim-tree.lua",
        config = true,
    },
    "tpope/vim-fugitive",
    "junegunn/gv.vim",
    {
        "lewis6991/gitsigns.nvim",
        config = true,
    },
    {
        'Julian/lean.nvim',
        event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
        opts = {
            lsp = {
                on_attach = on_attach,
            },
            mappings = true,
        }
    },
    {
        'mrcjkb/haskell-tools.nvim',
        version = '^3',
        ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
    },

    -- Autocompletion
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
            require("luasnip.loaders.from_snipmate").lazy_load()
        end,
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
        },
    },
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-lint",
    {
        "ray-x/lsp_signature.nvim",
        config = true,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "lukas-reineke/cmp-under-comparator",
        }
    },
    "nvimdev/lspsaga.nvim",
    {
        "folke/trouble.nvim",
        opts = {
            mode = 'document_diagnostics',
        },
    },
    {
        "folke/todo-comments.nvim",
        config = true,
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
    },
    {
        "echasnovski/mini.indentscope",
        version = false,
        setup = true,
        opts = {
            symbol = '|',
        },
    },
    {
        "echasnovski/mini.align",
        config = true,
        version = false
    },
}, lazy_config)
