-- Symbols for legacy Nerd Font v2.0
-- Based on https://github.com/nvimdev/lspsaga.nvim/blob/44af2ab1fee6bf166a001f7f006284a13737b45e/lua/lspsaga/lspkind.lua#L31
local kind = {
    File = { ' ', 'Tag' },
    Module = { ' ', 'Exception' },
    Namespace = { ' ', 'Include' },
    Package = { ' ', 'Label' },
    Class = { ' ', 'Include' },
    Method = { ' ', 'Function' },
    Property = { ' ', '@property' },
    Field = { ' ', '@field' },
    Constructor = { ' ', '@constructor' },
    Enum = { '了', '@number' },
    Interface = { ' ', 'Type' },
    Function = { ' ', 'Function' },
    Variable = { ' ', '@variable' },
    Constant = { ' ', 'Constant' },
    String = { ' ', 'String' },
    Number = { ' ', 'Number' },
    Boolean = { ' ', 'Boolean' },
    Array = { ' ', 'Type' },
    Object = { ' ', 'Type' },
    Key = { ' ', 'Constant' },
    Null = { ' ', 'Constant' },
    EnumMember = { ' ', 'Number' },
    Struct = { ' ', 'Type' },
    Event = { ' ', 'Constant' },
    Operator = { ' ', 'Operator' },
    TypeParameter = { ' ', 'Type' },
    TypeAlias = { ' ', 'Type' },
    Parameter = { ' ', '@parameter' },
    StaticMethod = { 'ﴂ ', 'Function' },
    Macro = { ' ', 'Macro' },
    Text = { ' ', 'String' },
    Snippet = { ' ', '@variable' },
    Folder = { ' ', 'Title' },
    Unit = { ' ', 'Number' },
    Value = { ' ', '@variable' },
}

require('lspsaga').setup {
    lightbulb = {
        enable = false,
    },
    ui = {
        kind = kind,
    }
}
