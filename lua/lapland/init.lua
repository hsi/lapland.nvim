-- Theme:   lapland
-- Author:  hsi
-- Source:  https://github.com/hsi/lapland.nvim
-- License: Apache-2.0

local M = {}

local palette = require('lapland.palette')

local builtins = {
    ColorColumn  = { background = palette.active, },
    Conceal      = { foreground = palette.bright, },
    Cursor       = { foreground = palette.dark, background = palette.green, },
    -- CursorIM link
    -- CursorColumn link
    CursorLine   = { background = palette.active, },
    Directory    = { foreground = palette.blue, attributes = { 'bold' }, },
    DiffAdd      = { foreground = palette.green, },
    -- DiffChange link
    DiffDelete   = { foreground = palette.red, },
    -- DiffText link
    EndOfBuffer  = { foreground = palette.suppressed, attributes = { 'bold' }, },
    -- TermCursor link
    TermCursorNC = { foreground = palette.dark, background = palette.hint, },
    ErrorMsg     = { foreground = palette.bright, background = palette.red, attributes = { 'bold' }, },
    VertSplit    = { foreground = palette.hint, },
    Folded       = { foreground = palette.blue, attributes = { 'bold' }, },
    FoldColumn   = { foreground = palette.hint, },
    SignColumn   = { attributes = { 'bold' }, },
    -- IncSearch link
    Substitute   = { foreground = palette.dark, background = palette.green, attributes = { 'bold' }, },
    LineNr       = { foreground = palette.suppressed, },
    CursorLineNr = { foreground = palette.darkyellow, background = palette.active, },
    MatchParen   = { foreground = palette.bright, background = palette.suppressed, attributes = { 'bold' }, },
    ModeMsg      = { foreground = palette.darkyellow, },
    MsgArea      = { foreground = palette.darkyellow, },
    MsgSeparator = { foreground = palette.hint, },
    MoreMsg      = { foreground = palette.hint, attributes = { 'bold' }, },
    NonText      = { foreground = palette.suppressed, },
    Normal       = { foreground = palette.light, background = palette.dark, },
    NormalFloat  = { foreground = palette.bright, background = palette.darker, },
    -- NormalNC link
    Pmenu        = { foreground = palette.hint, background = palette.darker, },
    PmenuSel     = { foreground = palette.yellow, background = palette.darker, },
    PmenuSbar    = { background = palette.darker, },
    PmenuThumb   = { background = palette.hint, },
    Question     = { foreground = palette.bright, attributes = { 'bold' }, },
    QuickFixLine = { foreground = palette.bright, attributes = { 'bold' }, },
    Search       = { foreground = palette.yellow, background = palette.purple, attributes = { 'bold' }, },
    SpecialKey   = { foreground = palette.yellow, attributes = { 'bold' }, },
    SpellBad     = { foreground = palette.red, attributes = { 'underline' }, },
    -- SpellCap link
    SpellLocal   = { attributes = { 'underline' }, },
    SpellRare    = { foreground = palette.orange, attributes = { 'underline' }, },
    StatusLine   = { foreground = palette.darkyellow, attributes = { 'bold' }, },
    StatusLineNC = { foreground = palette.hint, attributes = { 'bold' }, },
    TabLine      = { foreground = palette.suppressed, },
    TabLineFill  = { background = palette.dark, },
    TabLineSel   = { foreground = palette.darkyellow, },
    Title        = { foreground = palette.blue, attributes = { 'bold' }, },
    Visual       = { background = palette.purple, },
    -- VisualNOS link
    WarningMsg   = { foreground = palette.orange, },
    Whitespace   = { foreground = palette.bright, background = palette.red, },
    WildMenu     = { foreground = palette.yellow, },
}

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

local generals = {
    Comment     = { foreground = palette.suppressed, },
    --
    Constant    = { foreground = palette.red, },
    String      = { foreground = palette.green, },
    Character   = { foreground = palette.green, },
    --
    Identifier  = { foreground = palette.lightblue, },
    --
    Statement   = { foreground = palette.yellow, },
    Conditional = { foreground = palette.yellow, attributes = { 'bold' }, },
    Repeat      = { foreground = palette.yellow, attributes = { 'bold' }, },
    Operator    = { foreground = palette.blue, },
    Exception   = { foreground = palette.yellow, attributes = { 'bold' }, },
    --
    PreProc     = { foreground = palette.blue, },
    --
    Type        = { foreground = palette.blue, attributes = { 'bold' }, },
    --
    Special     = { foreground = palette.bright, },
    --
    Underlined  = { attributes = { 'underline' }, },
    --
    Ignore      = { foreground = palette.ignored, background = palette.bright, },
    --
    Error       = { foreground = palette.bright, background = palette.red, attributes = { 'bold' }, },
    --
    Todo        = { foreground = palette.dark, background = palette.bright, attributes = { 'bold' }, },
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

local links = {
    -- Diff
    diffAdded   = 'DiffAdd',
    diffRemoved = 'DiffDelete',
    diffChanged = 'Statement',
    -- Git Commit
    gitcommitBranch = 'Special',
    gitcommitType   = 'Normal',
    gitcommitHeader = 'Type',
    gitcommitFile   = 'Identifier',
    gitcommitArrow  = 'Operator',
    -- XML
    xmlTagName     = 'Type',
    xmlEndTag      = 'Type',
    xmlNamespace   = 'Identifier',
    xmlAttribPunct = 'Operator',
}


local function initialize()
    vim.cmd('highlight clear')
    if vim.g.syntax_on == 1 then
        vim.cmd('syntax reset')
    end
    vim.o.background = 'dark'
    vim.g.colors_name = 'lapland'
end


local function highlight(group_name, foreground_color, background_color, attributes)
    local foreground_color = foreground_color and
        'ctermfg=' .. foreground_color.terminal .. ' ' .. 'guifg=' .. foreground_color.graphical or
        'ctermfg=NONE guifg=NONE'

    local background_color = background_color and
        'ctermbg=' .. background_color.terminal .. ' ' .. 'guibg=' .. background_color.graphical or
        'ctermbg=NONE guibg=NONE'

    if attributes then
        local concatenated_attributes = table.concat(attributes, ',')
        attributes = 'cterm=' .. concatenated_attributes .. ' ' .. 'gui=' .. concatenated_attributes
    else
        attributes = 'cterm=NONE gui=NONE'
    end

    vim.cmd(
        'highlight ' .. group_name .. ' ' ..
        foreground_color .. ' ' ..
        background_color .. ' ' ..
        attributes
    )
end


local function highlight_link(source, target)
    vim.cmd('highlight! link ' .. source .. ' ' .. target)
end


function M.setup()
    if not vim.version or vim.version().api_level < 7 then
        return
    end

    initialize()

    for group_name, properties in pairs(builtins) do
        highlight(group_name, properties.foreground, properties.background, properties.attributes)
    end

    for source, target in pairs(builtin_links) do
        highlight_link(source, target)
    end

    for group_name, properties in pairs(generals) do
        highlight(group_name, properties.foreground, properties.background, properties.attributes)
    end

    for source, target in pairs(general_links) do
        highlight_link(source, target)
    end

    for source, target in pairs(links) do
        highlight_link(source, target)
    end
end

return M
