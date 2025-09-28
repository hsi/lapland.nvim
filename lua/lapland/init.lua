-- Theme:   lapland
-- Author:  hsi
-- Source:  https://github.com/hsi/lapland.nvim
-- License: Apache-2.0

local M = {}

local MINIMUM_NVIM_API_LEVEL = 9
local palettes = require('lapland.palettes')
local sky
local snow
local fruit

local options = setmetatable({
    _sky = 0,
    _snow = 0,
}, {
    __index = function(table, key)
        return table['_' .. key]
    end,
    __newindex = function(table, key, value)
        if key == 'sky' then
            local skies_radius = palettes.get_skies_radius()
            table._sky = math.min(math.max(value, -skies_radius), skies_radius)
        elseif key == 'snow' then
            local snows_radius = palettes.get_snows_radius()
            table._snow = math.min(math.max(value, -snows_radius), snows_radius)
        end
    end,
})

local builtin_links = {
    CursorIM     = 'Cursor',
    CursorColumn = 'CursorLine',
    DiffAdd      = 'Added',
    DiffChange   = 'Normal',
    DiffDelete   = 'Removed',
    DiffText     = 'Changed',
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
    if not vim.version or vim.version().api_level < MINIMUM_NVIM_API_LEVEL then
        return false
    end

    if vim.g.colors_name then
        vim.cmd.highlight('clear')
    end

    vim.o.background = 'dark'
    vim.g.colors_name = 'lapland'

    return true
end


local function build_builtins()
    return {
        ColorColumn      = { background = sky.brighter, },
        Conceal          = { foreground = snow.brighter, },
        CurSearch        = {},
        Cursor           = { foreground = sky.default, background = fruit.green, },
        lCursor          = {},
        -- CursorIM link
        -- CursorColumn link
        CursorLine       = { background = sky.brighter, },
        Directory        = { foreground = fruit.blue, attributes = { bold = true }, },
        -- DiffAdd link
        -- DiffChange link
        -- DiffDelete link
        -- DiffText
        EndOfBuffer      = { foreground = snow.darker, attributes = { bold = true }, },
        -- TermCursor link
        ErrorMsg         = { foreground = snow.brighter, background = fruit.red, attributes = { bold = true }, },
        WinSeparator     = { foreground = fruit.gold, },
        Folded           = { foreground = fruit.blue, attributes = { bold = true }, },
        FoldColumn       = { foreground = snow.darker, },
        SignColumn       = { attributes = { bold = true }, },
        -- IncSearch link
        Substitute       = { foreground = sky.default, background = fruit.green, attributes = { bold = true }, },
        LineNr           = { foreground = snow.darker, },
        LineNrAbove      = {},
        LineNrBelow      = {},
        CursorLineNr     = { foreground = fruit.gold, background = sky.brighter, },
        CursorLineFold   = {},
        CursorLineSign   = {},
        MatchParen       = { foreground = snow.brighter, background = snow.darker, attributes = { bold = true }, },
        ModeMsg          = { foreground = fruit.gold, },
        MsgArea          = { foreground = fruit.gold, },
        MsgSeparator     = { foreground = snow.darker, },
        MoreMsg          = { foreground = snow.darker, attributes = { bold = true }, },
        NonText          = { foreground = snow.darker, },
        Normal           = { foreground = snow.default, background = sky.default, },
        NormalFloat      = { foreground = snow.brighter, background = sky.darker, },
        FloatBorder      = {},
        FloatTitle       = {},
        FloatFooter      = {},
        -- NormalNC link
        Pmenu            = { foreground = snow.darker, background = sky.darker, },
        PmenuSel         = { foreground = fruit.yellow, background = sky.darker, },
        PmenuKind        = {},
        PmenuKindSel     = {},
        PmenuExtra       = {},
        PmenuExtraSel    = {},
        PmenuSbar        = { background = sky.darker, },
        PmenuThumb       = { background = snow.darker, },
        PmenuMatch       = {},
        PmenuMatchSel    = {},
        ComplMatchIns    = {},
        Question         = { foreground = snow.brighter, attributes = { bold = true }, },
        QuickFixLine     = { foreground = snow.brighter, attributes = { bold = true }, },
        Search           = { foreground = fruit.yellow, background = fruit.purple, attributes = { bold = true }, },
        SnippetTabstop   = {},
        SpecialKey       = { foreground = fruit.yellow, attributes = { bold = true }, },
        SpellBad         = { foreground = fruit.red, attributes = { underline = true }, },
        -- SpellCap link
        SpellLocal       = { attributes = { underline = true }, },
        SpellRare        = { foreground = fruit.orange, attributes = { underline = true }, },
        StatusLine       = { foreground = fruit.gold, attributes = { bold = true }, },
        StatusLineNC     = { foreground = snow.darker, attributes = { bold = true }, },
        StatusLineTerm   = {},
        StatusLineTermNC = {},
        TabLine          = { foreground = snow.darker, },
        TabLineFill      = { background = sky.default, },
        TabLineSel       = { foreground = fruit.gold, },
        Title            = { foreground = fruit.blue, attributes = { bold = true }, },
        Visual           = { background = fruit.purple, },
        -- VisualNOS link
        WarningMsg       = { foreground = fruit.orange, },
        Whitespace       = { foreground = snow.brighter, background = fruit.red, },
        WildMenu         = { foreground = fruit.yellow, },
        WinBar           = {},
        WinBarNC         = {},
    }
end


local function build_generals()
    return {
        Comment     = { foreground = snow.darker, },
        --
        Constant    = { foreground = fruit.magenta, },
        String      = { foreground = fruit.green, },
        Character   = { foreground = fruit.green, },
        -- Number link
        -- Boolean link
        -- Float link
        --
        Identifier  = { foreground = fruit.cyan, },
        -- Function link
        --
        Statement   = { foreground = fruit.yellow, },
        Conditional = { foreground = fruit.yellow, attributes = { bold = true }, },
        Repeat      = { foreground = fruit.yellow, attributes = { bold = true }, },
        -- Label link
        Operator    = { foreground = fruit.blue, },
        -- Keyword link
        Exception   = { foreground = fruit.yellow, attributes = { bold = true }, },
        --
        PreProc     = { foreground = fruit.blue, },
        -- Include link
        -- Define link
        -- Macro link
        -- PreCondit link
        --
        Type        = { foreground = fruit.blue, attributes = { bold = true }, },
        -- StorageClass link
        -- Structure link
        -- Typedef link
        --
        Special     = { foreground = snow.brighter, },
        -- SpecialChar link
        -- Tag link
        -- Delimiter link
        -- SpecialComment link
        -- Debug link
        --
        Underlined  = { attributes = { underline = true }, },
        --
        Ignore      = { foreground = sky.darker, background = snow.brighter, },
        --
        Error       = { foreground = snow.brighter, background = fruit.red, attributes = { bold = true }, },
        --
        Todo        = { foreground = sky.default, background = snow.brighter, attributes = { bold = true }, },
        --
        Added       = { foreground = fruit.green, },
        Changed     = { foreground = fruit.orange, },
        Removed     = { foreground = fruit.red, },
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


function M.config(user_options)
    for key, value in pairs(user_options) do
        options[key] = value
    end
end


local function set_highlights()
    sky, snow, fruit = palettes.build(options)

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
    options.sky = options.sky + delta
    set_highlights()
end


function M.adjust_snow(delta)
    options.snow = options.snow + delta
    set_highlights()
end


function M.dump_config()
    local INDENT = '    '
    print(string.format(
        "-- after/plugin/lapland.lua\n" ..
        "require('lapland').config({\n" ..
        "%ssky  = %d,\n" ..
        "%ssnow = %d,\n" ..
        "})",
        INDENT, options.sky, INDENT, options.snow
    ))
end


function M.setup()
    if not initialize() then
        return
    end

    set_highlights()
    set_highlight_links()
end

return M
