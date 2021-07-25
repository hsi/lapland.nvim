-- Theme:   lapland
-- Author:  hsi
-- Source:  https://github.com/hsi/lapland.nvim
-- License: Apache-2.0

local M = {}

local palette = require('lapland.palette')

local builtins = {
    ColorColumn  = {                              background = palette.gray15,                         },
    Conceal      = { foreground = palette.white                                                        },
    Cursor       = { foreground = palette.gray11, background = palette.green,                          },
    -- CursorIM link
    -- CursorColumn link
    CursorLine   = {                              background = palette.gray15,                         },
    Directory    = { foreground = palette.blue,                                attribute = 'bold'      },
    DiffAdd      = { foreground = palette.green,                                                       },
    -- DiffChange link
    DiffDelete   = { foreground = palette.red,                                                         },
    -- DiffText link
    EndOfBuffer  = { foreground = palette.gray35,                              attribute = 'bold'      },
    -- TermCursor link
    TermCursorNC = { foreground = palette.gray11, background = palette.gray50,                         },
    ErrorMsg     = { foreground = palette.white,  background = palette.red,    attribute = 'bold'      },
    VertSplit    = { foreground = palette.gray50,                                                      },
    Folded       = { foreground = palette.blue,                                attribute = 'bold'      },
    FoldColumn   = { foreground = palette.gray50,                                                      },
    SignColumn   = {                                                           attribute = 'bold'      },
    -- IncSearch link
    Substitute   = { foreground = palette.gray11, background = palette.green,  attribute = 'bold'      },
    LineNr       = { foreground = palette.gray35,                                                      },
    CursorLineNr = { foreground = palette.gold,   background = palette.gray15,                         },
    MatchParen   = { foreground = palette.white,  background = palette.gray35, attribute = 'bold'      },
    ModeMsg      = { foreground = palette.gold,                                                        },
    MsgArea      = { foreground = palette.gold,                                                        },
    MsgSeparator = { foreground = palette.gray50,                                                      },
    MoreMsg      = { foreground = palette.gray50,                              attribute = 'bold'      },
    NonText      = { foreground = palette.gold,                                attribute = 'bold'      },
    Normal       = { foreground = palette.gray85, background = palette.gray11,                         },
    NormalFloat  = { foreground = palette.white,  background = palette.gray7,                          },
    -- NormalNC link
    Pmenu        = { foreground = palette.gray50, background = palette.gray7,                          },
    PmenuSel     = { foreground = palette.yellow, background = palette.gray7,                          },
    PmenuSbar    = {                              background = palette.gray7,                          },
    PmenuThumb   = {                              background = palette.gray50,                         },
    Question     = { foreground = palette.white,                               attribute = 'bold'      },
    QuickFixLine = { foreground = palette.white,                               attribute = 'bold'      },
    Search       = { foreground = palette.white,  background = palette.purple,                         },
    SpecialKey   = { foreground = palette.yellow,                              attribute = 'bold'      },
    SpellBad     = { foreground = palette.red,                                 attribute = 'underline' },
    -- SpellCap link
    SpellLocal   = {                                                           attribute = 'underline' },
    SpellRare    = { foreground = palette.orange,                              attribute = 'underline' },
    StatusLine   = { foreground = palette.gold,                                attribute = 'bold'      },
    StatusLineNC = { foreground = palette.gray50, background = palette.gray15,                         },
    TabLine      = { foreground = palette.gray50, background = palette.gray15,                         },
    TabLineFill  = {                              background = palette.gray11,                         },
    TabLineSel   = { foreground = palette.gold,   background = palette.gray15,                         },
    Title        = { foreground = palette.blue,                                attribute = 'bold'      },
    Visual       = { foreground = palette.yellow, background = palette.purple, attribute = 'bold'      },
    -- VisualNOS link
    WarningMsg   = { foreground = palette.orange,                                                      },
    Whitespace   = { foreground = palette.white,  background = palette.red,                            },
    WildMenu     = { foreground = palette.yellow,                                                      },
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
    Comment     = { foreground = palette.gray35,                                                       },
    --
    Constant    = { foreground = palette.maroon,                                                       },
    String      = { foreground = palette.seagreen,                                                     },
    Character   = { foreground = palette.green,                                                        },
    --
    Identifier  = { foreground = palette.cyan,                                                         },
    --
    Statement   = { foreground = palette.yellow,                                                       },
    Conditional = { foreground = palette.yellow,                               attribute = 'bold'      },
    Repeat      = { foreground = palette.yellow,                               attribute = 'bold'      },
    Operator    = { foreground = palette.blue,                                                         },
    Exception   = { foreground = palette.yellow,                               attribute = 'bold'      },
    --
    PreProc     = { foreground = palette.blue,                                                         },
    --
    Type        = { foreground = palette.blue,                                 attribute = 'bold'      },
    --
    Special     = { foreground = palette.white,                                                        },
    --
    Underlined  = {                                                            attribute = 'underline' },
    --
    Ignore      = { foreground = palette.gray3,    background = palette.white,                         },
    --
    Error       = { foreground = palette.white,    background = palette.red,   attribute = 'bold'      },
    --
    Todo        = { foreground = palette.gray11,   background = palette.white, attribute = 'bold'      },
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
    local foreground_color = foreground_color and 'ctermfg=' .. foreground_color.terminal or 'ctermfg=NONE'
    local background_color = background_color and 'ctermbg=' .. background_color.terminal or 'ctermbg=NONE'
    local attribute = attribute and 'cterm=' .. attribute or 'cterm=NONE'

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
