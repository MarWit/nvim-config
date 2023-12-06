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

local noremap_opts = { noremap = true }
local nnoremap = wrap_map('n', noremap_opts)
local vnoremap = wrap_map('v', noremap_opts)
local inoremap = wrap_map('i', noremap_opts)
local xnoremap = wrap_map('x', noremap_opts)
local tnoremap = wrap_map('t', noremap_opts)
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

-- Sorting
nnoremap('<leader>s', ':sort<CR>', true)
vnoremap('<leader>s', ':sort<CR>', true)

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

-- File explorer
nnoremap('<leader>,', ':NvimTreeToggle<CR>', true)

-- Git blame
nnoremap('<leader>gb', function() package.loaded.gitsigns.blame_line() end)

-- Snippet expand
inoremap('<C-k>', function() require('luasnip').expand_or_jump() end)
-- ]]
