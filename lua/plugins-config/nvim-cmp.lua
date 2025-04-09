local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "nvim_lsp" },
    }, {
        {
            name = "buffer",
            option = {
                get_bufnrs = function()
                    local bufs = {}
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        bufs[vim.api.nvim_win_get_buf(win)] = true
                    end
                    return vim.tbl_keys(bufs)
                end
            },
        },
        { name = "path" },
    }),
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require "cmp-under-comparator".under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end),
        ["<C-n>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end
        }),
        ["<C-p>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end
        }),
        ["<C-k>"] = cmp.mapping.confirm({ select = true })
    }
})

local lsp_sources = {
    -- package = default_configuration:bool
    lua_ls = true,
    rust_analyzer = true,
    clangd = true,
    pyright = true,
    svelte = true,
    ts_ls = true,
    omnisharp = false,
}

local ensure_installed = {}
for package, _ in pairs(lsp_sources)
do
    table.insert(ensure_installed, package)
end

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = ensure_installed
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

for server, should_setup in pairs(lsp_sources)
do
    if should_setup then
        lspconfig[server].setup { capabilities = capabilities }
    end
end

-- Custom language servers
-- | C#
local capabilities_without_semantic_tokens = vim.deepcopy(capabilities)
capabilities_without_semantic_tokens.textDocument.semanticTokens = vim.NIL

lspconfig.omnisharp.setup {
    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler,
        ["textDocument/semanticTokens"] = function() end,
    },
    capabilities = capabilities_without_semantic_tokens,
    on_new_config = function(new_config, root_dir)
        -- HACK: Check if we are in Renode directory, and try to use Renode_NET.sln
        local renode_project = root_dir .. '/Renode_NET.sln'
        if vim.fn.filereadable(renode_project) ~= 0 then
            vim.list_extend(new_config.cmd, { '-s', renode_project })
        end

        -- NOTE: Load omnisharp.json if exists
        local omnisharp_json = root_dir .. '/omnisharp.json'
        if vim.fn.filereadable(omnisharp_json) ~= 0 then
            local settings_str = io.input(omnisharp_json):read('a')
            local settings = vim.json.decode(settings_str)
            new_config.settings = vim.tbl_deep_extend('keep', new_config.settings, settings)
        end

        -- NOTE: Run default on_new_config
        local default_config = lspconfig.omnisharp.config_def.default_config
        return default_config.on_new_config(new_config, root_dir)
    end,
}
