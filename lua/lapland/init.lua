-- Theme:   lapland
-- Author:  hsi
-- Source:  https://github.com/hsi/lapland.nvim
-- License: Apache-2.0

local M = {}

local palette = require('lapland.palette')

local builtins = {
    ColorColumn  = { background = palette.gray4, },
    Conceal      = { foreground = palette.white, },
    Cursor       = { foreground = palette.gray3, background = palette.green, },
    -- CursorIM link
    -- CursorColumn link
    CursorLine   = { background = palette.gray4, },
    Directory    = { foreground = palette.krishna_blue, attribute = 'bold', },
    DiffAdd      = { foreground = palette.green, },
    -- DiffChange link
    DiffDelete   = { foreground = palette.rosso_corsa, },
    -- DiffText link
    EndOfBuffer  = { foreground = palette.gray9, attribute = 'bold', },
    -- TermCursor link
    TermCursorNC = { foreground = palette.gray3, background = palette.gray13, },
    ErrorMsg     = { foreground = palette.white, background = palette.rosso_corsa, attribute = 'bold', },
    VertSplit    = { foreground = palette.gray13, },
    Folded       = { foreground = palette.krishna_blue, attribute = 'bold', },
    FoldColumn   = { foreground = palette.gray13, },
    SignColumn   = { attribute = 'bold', },
    -- IncSearch link
    Substitute   = { foreground = palette.gray3, background = palette.green, attribute = 'bold', },
    LineNr       = { foreground = palette.gray9, },
    CursorLineNr = { foreground = palette.daddy_o, background = palette.gray4, },
    MatchParen   = { foreground = palette.white, background = palette.gray9, attribute = 'bold', },
    ModeMsg      = { foreground = palette.daddy_o, },
    MsgArea      = { foreground = palette.daddy_o, },
    MsgSeparator = { foreground = palette.gray13, },
    MoreMsg      = { foreground = palette.gray13, attribute = 'bold', },
    NonText      = { foreground = palette.daddy_o, attribute = 'bold', },
    Normal       = { foreground = palette.gray22, background = palette.gray3, },
    NormalFloat  = { foreground = palette.white, background = palette.gray2, },
    -- NormalNC link
    Pmenu        = { foreground = palette.gray13, background = palette.gray2, },
    PmenuSel     = { foreground = palette.vic_20_creme, background = palette.gray2, },
    PmenuSbar    = { background = palette.gray2, },
    PmenuThumb   = { background = palette.gray13, },
    Question     = { foreground = palette.white, attribute = 'bold', },
    QuickFixLine = { foreground = palette.white, attribute = 'bold', },
    Search       = { foreground = palette.white, background = palette.purple_climax, },
    SpecialKey   = { foreground = palette.vic_20_creme, attribute = 'bold', },
    SpellBad     = { foreground = palette.rosso_corsa, attribute = 'underline', },
    -- SpellCap link
    SpellLocal   = { attribute = 'underline', },
    SpellRare    = { foreground = palette.vivid_orange, attribute = 'underline', },
    StatusLine   = { foreground = palette.daddy_o, attribute = 'bold', },
    StatusLineNC = { foreground = palette.gray13, attribute = 'bold', },
    TabLine      = { foreground = palette.gray13, background = palette.gray4, },
    TabLineFill  = { background = palette.gray3, },
    TabLineSel   = { foreground = palette.daddy_o, background = palette.gray4, },
    Title        = { foreground = palette.krishna_blue, attribute = 'bold', },
    Visual       = { foreground = palette.vic_20_creme, background = palette.purple_climax, attribute = 'bold', },
    -- VisualNOS link
    WarningMsg   = { foreground = palette.vivid_orange, },
    Whitespace   = { foreground = palette.white, background = palette.rosso_corsa, },
    WildMenu     = { foreground = palette.vic_20_creme, },
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
    Comment     = { foreground = palette.gray9, },
    --
    Constant    = { foreground = palette.fancy_fuchsia, },
    String      = { foreground = palette.hobgoblin, },
    Character   = { foreground = palette.green, },
    --
    Identifier  = { foreground = palette.ice_cold_stare, },
    --
    Statement   = { foreground = palette.vic_20_creme, },
    Conditional = { foreground = palette.vic_20_creme, attribute = 'bold', },
    Repeat      = { foreground = palette.vic_20_creme, attribute = 'bold', },
    Operator    = { foreground = palette.krishna_blue, },
    Exception   = { foreground = palette.vic_20_creme, attribute = 'bold', },
    --
    PreProc     = { foreground = palette.krishna_blue, },
    --
    Type        = { foreground = palette.krishna_blue, attribute = 'bold', },
    --
    Special     = { foreground = palette.white, },
    --
    Underlined  = { attribute = 'underline', },
    --
    Ignore      = { foreground = palette.gray1, background = palette.white, },
    --
    Error       = { foreground = palette.white, background = palette.rosso_corsa, attribute = 'bold', },
    --
    Todo        = { foreground = palette.gray3, background = palette.white, attribute = 'bold', },
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


local function highlight(group_name, foreground_color, background_color, attribute)
    local foreground_color = foreground_color and
        'ctermfg=' .. foreground_color.terminal .. ' ' .. 'guifg=' .. foreground_color.graphical or
        'ctermfg=NONE guifg=NONE'
    local background_color = background_color and
        'ctermbg=' .. background_color.terminal .. ' ' .. 'guibg=' .. background_color.graphical or
        'ctermbg=NONE guibg=NONE'
    local attribute = attribute and
        'cterm=' .. attribute .. ' ' .. 'gui=' .. attribute or
        'cterm=NONE gui=NONE'

    vim.cmd(
        'highlight ' .. group_name .. ' ' ..
        foreground_color .. ' ' ..
        background_color .. ' ' ..
        attribute
    )
end


local function highlight_link(source, target)
    vim.cmd('highlight! link ' .. source .. ' ' .. target)
end


function M.setup()
    initialize()

    for group_name, properties in pairs(builtins) do
        highlight(group_name, properties.foreground, properties.background, properties.attribute)
    end

    for source, target in pairs(builtin_links) do
        highlight_link(source, target)
    end

    for group_name, properties in pairs(generals) do
        highlight(group_name, properties.foreground, properties.background, properties.attribute)
    end

    for source, target in pairs(general_links) do
        highlight_link(source, target)
    end

    for source, target in pairs(links) do
        highlight_link(source, target)
    end
end

return M
