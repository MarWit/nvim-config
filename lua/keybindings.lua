-- [Boilerplate...]
-- [[
local wrap_map = function(mode, opts)
    local use_opts = opts and vim.deepcopy(opts) or {}
    return function(mapping, handler, silent)
        use_opts['silent'] = silent and silent or false
        vim.keymap.set(mode, mapping, handler, use_opts)
    end
end

local nmap = wrap_map('n')
local vmap = wrap_map('v')
local imap = wrap_map('i')
local xmap = wrap_map('x')
local tmap = wrap_map('t')
local smap = wrap_map('s')

local noremap_opts = { noremap = true }
local nnoremap = wrap_map('n', noremap_opts)
local vnoremap = wrap_map('v', noremap_opts)
local inoremap = wrap_map('i', noremap_opts)
local xnoremap = wrap_map('x', noremap_opts)
local tnoremap = wrap_map('t', noremap_opts)
local snoremap = wrap_map('s', noremap_opts)
-- ]]

-- [Setup mapleader]
-- [[
vim.g.mapleader = ','
vim.g.localmapleader = '\\'
-- ]]

-- [Keybindings]
-- [[
-- Remap > and < to use single press
nnoremap('>', '>>', true)
vnoremap('>', '>gv', true)
nnoremap('<', '<<', true)
vnoremap('<', '<gv', true)

-- Remap / to always include \v
nnoremap('/', '/\\v')
vnoremap('/', '/\\v')

-- Remap j and k to move relative to visible text
nnoremap('j', 'gj', true)
nnoremap('k', 'gk', true)

-- Move line up and down
nnoremap('<A-j>', ':m+<CR>', true)
nnoremap('<A-k>', ':m--<CR>', true)
vnoremap('<A-j>', ":m'>+<CR>gv", true)
vnoremap('<A-k>', ":m'<--<CR>gv", true)

-- Remap digraph keybinding
inoremap('<C-y>', '<C-k>', true)

-- Sorting
nnoremap('<leader>s', '<Cmd>Sort<CR>', true)
vnoremap('<leader>s', '<Esc><Cmd>Sort<CR>', true)

-- Folds
nnoremap('<Space>', 'za', true)
vnoremap('<Space>', 'za', true)

-- Moving between buffers
nnoremap('<A-[>', ':bprevious<CR>', true)
nnoremap('<A-]>', ':bnext<CR>', true)
for i=1,9 do
    nnoremap(('<A-%d>'):format(i), (':b%d<CR>'):format(i), true)
end

-- Fuzzy-finding
nnoremap('<leader>f', function() require('fzf-lua').files() end, true)
nnoremap('<leader>b', function() require('fzf-lua').buffers() end, true)
nnoremap('<leader>r', function() require('fzf-lua').live_grep() end, true)
vnoremap('<leader>r', function()
    vim.cmd.normal{ '"vy', bang = true }
    local visual = vim.fn.getreg('v')
    require('fzf-lua').live_grep({search = visual})
end, true)
nnoremap('<localleader>s', function() require('fzf-lua').lsp_live_workspace_symbols() end, true)

-- File explorer
nnoremap('<leader>,', ':NvimTreeToggle<CR>', true)

-- Git blame
nnoremap('<leader>gb', function() package.loaded.gitsigns.blame_line() end)

-- Git status
nnoremap('<leader>gs', function() require('fzf-lua').git_status() end)

-- Open Git in floating window
nnoremap('<localleader>g', function()
    vim.cmd(':Git')

    local git_win = vim.api.nvim_get_current_win()
    local ok = require('detour').Detour()
    if ok then
        vim.api.nvim_win_close(git_win, false)
    end
end)

-- Jump between git changes
nnoremap(']g', package.loaded.gitsigns.next_hunk, true)
nnoremap('[g', package.loaded.gitsigns.prev_hunk, true)

-- Jump between errors
nnoremap(']e', function()
    vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR, wrap = true }
end, true)
nnoremap('[e', function()
    vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR, wrap = true }
end, true)

-- Snippet expand
inoremap('<C-k>', function() require('luasnip').expand_or_jump() end)
snoremap('<C-n>', function() require('luasnip').jump(1) end)
snoremap('<C-p>', function() require('luasnip').jump(-1) end)

-- Undo Tree
nnoremap('<leader>u', ':UndotreeToggle<CR>', true)

-- Hover doc
nnoremap('K', '<cmd>Lspsaga hover_doc<CR>')

-- Outline
nnoremap('<leader>.', '<cmd>Lspsaga outline<CR>')

-- Go to definition
nnoremap('gd', '<cmd>Lspsaga goto_definition<CR>')

-- Peek definition
nnoremap('<localleader>p', '<cmd>Lspsaga peek_definition<CR>')

-- Rename symbol
nnoremap('<localleader>r', '<cmd>Lspsaga rename<CR>')

-- References
nnoremap('<localleader>f', '<cmd>Lspsaga finder<CR>')

-- Code action
nnoremap('<localleader>\\', '<cmd>Lspsaga code_action<CR>')

-- Use dial.nvim
nnoremap('<C-a>', function() require("dial.map").manipulate("increment", "normal") end)
nnoremap('<C-x>', function() require("dial.map").manipulate("decrement", "normal") end)

-- Jump TODOs
nnoremap(']t', function() require('todo-comments').jump_next() end, true)
nnoremap('[t', function() require('todo-comments').jump_prev() end, true)
-- ]]
