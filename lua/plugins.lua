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
        "karb94/neoscroll.nvim",
        config = function ()
            require('neoscroll').setup {
                easing_function = "cubic"
            }
        end
    },
    "mhinz/vim-startify",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require('lualine').setup {
                tabline = {
                    lualine_a = { 'buffers' }
                }
            }
        end
    },
    "mbbill/undotree",
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require('nvim-tree').setup()
        end
    },
    "tpope/vim-fugitive",
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end
    },

    -- Autocompletion
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp"
    },
    "neovim/nvim-lspconfig",
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        }
    }
}, lazy_config)
