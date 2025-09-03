-- Theme:   lapland
-- Author:  hsi
-- Source:  https://github.com/hsi/lapland.nvim
-- License: Apache-2.0

local M = {}

local default_options = {
    sky = 0,
    snow = 0,
}

M.options = nil

local builtin_links = {
    CursorIM     = 'Cursor',
    CursorColumn = 'CursorLine',
    DiffChange   = 'Normal',
    DiffText     = 'DiffAdd',
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


local function build_builtins(palette)
    return {
        ColorColumn  = { background = palette.sky.brighter, },
        Conceal      = { foreground = palette.snow.brighter, },
        Cursor       = { foreground = palette.sky.default, background = palette.green, },
        -- CursorIM link
        -- CursorColumn link
        CursorLine   = { background = palette.sky.brighter, },
        Directory    = { foreground = palette.blue, attributes = { bold = true }, },
        DiffAdd      = { foreground = palette.green, },
        -- DiffChange link
        DiffDelete   = { foreground = palette.magenta, },
        -- DiffText link
        EndOfBuffer  = { foreground = palette.snow.darker, attributes = { bold = true }, },
        -- TermCursor link
        TermCursorNC = { foreground = palette.sky.default, background = palette.hint, },
        ErrorMsg     = { foreground = palette.snow.brighter, background = palette.magenta, attributes = { bold = true }, },
        VertSplit    = { foreground = palette.hint, },
        Folded       = { foreground = palette.blue, attributes = { bold = true }, },
        FoldColumn   = { foreground = palette.hint, },
        SignColumn   = { attributes = { bold = true }, },
        -- IncSearch link
        Substitute   = { foreground = palette.sky.default, background = palette.green, attributes = { bold = true }, },
        LineNr       = { foreground = palette.snow.darker, },
        CursorLineNr = { foreground = palette.gold, background = palette.sky.brighter, },
        MatchParen   = { foreground = palette.snow.brighter, background = palette.snow.darker, attributes = { bold = true }, },
        ModeMsg      = { foreground = palette.gold, },
        MsgArea      = { foreground = palette.gold, },
        MsgSeparator = { foreground = palette.hint, },
        MoreMsg      = { foreground = palette.hint, attributes = { bold = true }, },
        NonText      = { foreground = palette.snow.darker, },
        Normal       = { foreground = palette.snow.default, background = palette.sky.default, },
        NormalFloat  = { foreground = palette.snow.brighter, background = palette.sky.darker, },
        -- NormalNC link
        Pmenu        = { foreground = palette.hint, background = palette.sky.darker, },
        PmenuSel     = { foreground = palette.yellow, background = palette.sky.darker, },
        PmenuSbar    = { background = palette.sky.darker, },
        PmenuThumb   = { background = palette.hint, },
        Question     = { foreground = palette.snow.brighter, attributes = { bold = true }, },
        QuickFixLine = { foreground = palette.snow.brighter, attributes = { bold = true }, },
        Search       = { foreground = palette.yellow, background = palette.purple, attributes = { bold = true }, },
        SpecialKey   = { foreground = palette.yellow, attributes = { bold = true }, },
        SpellBad     = { foreground = palette.magenta, attributes = { underline = true }, },
        -- SpellCap link
        SpellLocal   = { attributes = { underline = true }, },
        SpellRare    = { foreground = palette.orange, attributes = { underline = true }, },
        StatusLine   = { foreground = palette.gold, attributes = { bold = true }, },
        StatusLineNC = { foreground = palette.hint, attributes = { bold = true }, },
        TabLine      = { foreground = palette.snow.darker, },
        TabLineFill  = { background = palette.sky.default, },
        TabLineSel   = { foreground = palette.gold, },
        Title        = { foreground = palette.blue, attributes = { bold = true }, },
        Visual       = { background = palette.purple, },
        -- VisualNOS link
        WarningMsg   = { foreground = palette.orange, },
        Whitespace   = { foreground = palette.snow.brighter, background = palette.magenta, },
        WildMenu     = { foreground = palette.yellow, },
        WinSeparator = { foreground = palette.gold, }
    }
end


local function build_generals(palette)
    return {
        Comment     = { foreground = palette.snow.darker, },
        --
        Constant    = { foreground = palette.magenta, },
        String      = { foreground = palette.green, },
        Character   = { foreground = palette.green, },
        --
        Identifier  = { foreground = palette.cyan, },
        --
        Statement   = { foreground = palette.yellow, },
        Conditional = { foreground = palette.yellow, attributes = { bold = true }, },
        Repeat      = { foreground = palette.yellow, attributes = { bold = true }, },
        Operator    = { foreground = palette.blue, },
        Exception   = { foreground = palette.yellow, attributes = { bold = true }, },
        --
        PreProc     = { foreground = palette.blue, },
        --
        Type        = { foreground = palette.blue, attributes = { bold = true }, },
        --
        Special     = { foreground = palette.snow.brighter, },
        --
        Underlined  = { attributes = { underline = true }, },
        --
        Ignore      = { foreground = palette.sky.darker, background = palette.snow.brighter, },
        --
        Error       = { foreground = palette.snow.brighter, background = palette.magenta, attributes = { bold = true }, },
        --
        Todo        = { foreground = palette.sky.default, background = palette.snow.brighter, attributes = { bold = true }, },
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
    local palette = require('lapland.palette').build(M.options)

    local builtins = build_builtins(palette)
    for group_name, properties in pairs(builtins) do
        highlight(group_name, properties.foreground, properties.background, properties.attributes)
    end

    local generals = build_generals(palette)
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
