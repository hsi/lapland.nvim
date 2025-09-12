-- Theme:   lapland
-- Author:  hsi
-- Source:  https://github.com/hsi/lapland.nvim
-- License: Apache-2.0

local M = {}

local palettes = require('lapland.palettes')
local sky
local snow
local fruit

local default_options = {
    sky = 0,
    snow = 0,
}

M.options = nil

local builtin_links = {
    CursorIM     = 'Cursor',
    CursorColumn = 'CursorLine',
    DiffChange   = 'Normal',
    TermCursor   = 'Cursor',
    IncSearch    = 'Search',
    NormalNC     = 'Normal',
    SpellCap     = 'SpellBad',
    VisualNOS    = 'Visual',
}

local general_links = {
    Number  = 'Constant',
    Boolean = 'Constant',
    Float   = 'Constant',
    --
    Function = 'Identifier',
    --
    Label   = 'Statement',
    Keyword = 'Statement',
    --
    Include   = 'PreProc',
    Define    = 'PreProc',
    Macro     = 'PreProc',
    PreCondit = 'PreProc',
    --
    StorageClass = 'Type',
    Structure    = 'Type',
    Typedef      = 'Type',
    --
    SpecialChar    = 'Special',
    Tag            = 'Special',
    Delimiter      = 'Special',
    SpecialComment = 'Special',
    Debug          = 'Special',
}

local function initialize()
    if not M.options then
        M.options = default_options
    end

    if vim.g.colors_name then
        vim.cmd.highlight('clear')
    end

    vim.o.background = 'dark'
    vim.g.colors_name = 'lapland'
end


local function build_builtins()
    return {
        ColorColumn  = { background = sky.brighter, },
        Conceal      = { foreground = snow.brighter, },
        Cursor       = { foreground = sky.default, background = fruit.green, },
        -- CursorIM link
        -- CursorColumn link
        CursorLine   = { background = sky.brighter, },
        Directory    = { foreground = fruit.blue, attributes = { bold = true }, },
        DiffAdd      = { foreground = fruit.green, },
        -- DiffChange link
        DiffDelete   = { foreground = fruit.red, },
        DiffText     = { foreground = fruit.orange, },
        EndOfBuffer  = { foreground = snow.darker, attributes = { bold = true }, },
        -- TermCursor link
        TermCursorNC = { foreground = sky.default, background = fruit.hint, },
        ErrorMsg     = { foreground = snow.brighter, background = fruit.red, attributes = { bold = true }, },
        VertSplit    = { foreground = fruit.hint, },
        Folded       = { foreground = fruit.blue, attributes = { bold = true }, },
        FoldColumn   = { foreground = fruit.hint, },
        SignColumn   = { attributes = { bold = true }, },
        -- IncSearch link
        Substitute   = { foreground = sky.default, background = fruit.green, attributes = { bold = true }, },
        LineNr       = { foreground = snow.darker, },
        CursorLineNr = { foreground = fruit.gold, background = sky.brighter, },
        MatchParen   = { foreground = snow.brighter, background = snow.darker, attributes = { bold = true }, },
        ModeMsg      = { foreground = fruit.gold, },
        MsgArea      = { foreground = fruit.gold, },
        MsgSeparator = { foreground = fruit.hint, },
        MoreMsg      = { foreground = fruit.hint, attributes = { bold = true }, },
        NonText      = { foreground = snow.darker, },
        Normal       = { foreground = snow.default, background = sky.default, },
        NormalFloat  = { foreground = snow.brighter, background = sky.darker, },
        -- NormalNC link
        Pmenu        = { foreground = fruit.hint, background = sky.darker, },
        PmenuSel     = { foreground = fruit.yellow, background = sky.darker, },
        PmenuSbar    = { background = sky.darker, },
        PmenuThumb   = { background = fruit.hint, },
        Question     = { foreground = snow.brighter, attributes = { bold = true }, },
        QuickFixLine = { foreground = snow.brighter, attributes = { bold = true }, },
        Search       = { foreground = fruit.yellow, background = fruit.purple, attributes = { bold = true }, },
        SpecialKey   = { foreground = fruit.yellow, attributes = { bold = true }, },
        SpellBad     = { foreground = fruit.red, attributes = { underline = true }, },
        -- SpellCap link
        SpellLocal   = { attributes = { underline = true }, },
        SpellRare    = { foreground = fruit.orange, attributes = { underline = true }, },
        StatusLine   = { foreground = fruit.gold, attributes = { bold = true }, },
        StatusLineNC = { foreground = fruit.hint, attributes = { bold = true }, },
        TabLine      = { foreground = snow.darker, },
        TabLineFill  = { background = sky.default, },
        TabLineSel   = { foreground = fruit.gold, },
        Title        = { foreground = fruit.blue, attributes = { bold = true }, },
        Visual       = { background = fruit.purple, },
        -- VisualNOS link
        WarningMsg   = { foreground = fruit.orange, },
        Whitespace   = { foreground = snow.brighter, background = fruit.red, },
        WildMenu     = { foreground = fruit.yellow, },
        WinSeparator = { foreground = fruit.gold, }
    }
end


local function build_generals()
    return {
        Comment     = { foreground = snow.darker, },
        --
        Constant    = { foreground = fruit.magenta, },
        String      = { foreground = fruit.green, },
        Character   = { foreground = fruit.green, },
        --
        Identifier  = { foreground = fruit.cyan, },
        --
        Statement   = { foreground = fruit.yellow, },
        Conditional = { foreground = fruit.yellow, attributes = { bold = true }, },
        Repeat      = { foreground = fruit.yellow, attributes = { bold = true }, },
        Operator    = { foreground = fruit.blue, },
        Exception   = { foreground = fruit.yellow, attributes = { bold = true }, },
        --
        PreProc     = { foreground = fruit.blue, },
        --
        Type        = { foreground = fruit.blue, attributes = { bold = true }, },
        --
        Special     = { foreground = snow.brighter, },
        --
        Underlined  = { attributes = { underline = true }, },
        --
        Ignore      = { foreground = sky.darker, background = snow.brighter, },
        --
        Error       = { foreground = snow.brighter, background = fruit.red, attributes = { bold = true }, },
        --
        Todo        = { foreground = sky.default, background = snow.brighter, attributes = { bold = true }, },
    }
end


local function highlight(group_name, foreground_color, background_color, attributes)
    vim.api.nvim_set_hl(0, group_name, {
        ctermfg = foreground_color and foreground_color.terminal or nil,
        ctermbg = background_color and background_color.terminal or nil,
        fg = foreground_color and foreground_color.graphical or nil,
        bg = background_color and background_color.graphical or nil,
        bold = attributes and attributes.bold,
        underline = attributes and attributes.underline,
    })
end


local function highlight_link(from_group, to_group)
    vim.api.nvim_set_hl(0, from_group, {link = to_group})
end


function M.config(options)
    M.options = vim.tbl_extend('force', default_options, options or {})
end


local function set_highlights()
    sky, snow, fruit = palettes.build(M.options)

    local builtins = build_builtins()
    for group_name, properties in pairs(builtins) do
        highlight(group_name, properties.foreground, properties.background, properties.attributes)
    end

    local generals = build_generals()
    for group_name, properties in pairs(generals) do
        highlight(group_name, properties.foreground, properties.background, properties.attributes)
    end
end


local function set_highlight_links()
    for from_group, to_group in pairs(builtin_links) do
        highlight_link(from_group, to_group)
    end

    for from_group, to_group in pairs(general_links) do
        highlight_link(from_group, to_group)
    end
end


function M.adjust_sky(delta)
    M.options.sky = M.options.sky + delta
    set_highlights()
end


function M.adjust_snow(delta)
    M.options.snow = M.options.snow + delta
    set_highlights()
end


function M.dump_config()
    print('-- after/plugin/lapland.lua')
    print('require(\'lapland\').config({')
    print('    sky  = ' .. M.options.sky .. ',')
    print('    snow = ' .. M.options.snow .. ',')
    print('})')
end


function M.setup()
    if not vim.version or vim.version().api_level < 9 then
        return
    end

    initialize()

    set_highlights()
    set_highlight_links()
end

return M
