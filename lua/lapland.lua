-- Theme:   lapland
-- Author:  hsi
-- Source:  https://github.com/hsi/lapland.nvim
-- License: Apache-2.0

local M = {}

local builtins = {
    ColorColumn  = {                   background = 235                          },
    Conceal      = { foreground = 231                                            },
    Cursor       = { foreground = 234, background =  46                          },
    CursorLine   = {                   background = 235                          },
    CursorLineNr = { foreground = 144, background = 235                          },
    DiffAdd      = { foreground =  46                                            },
    DiffDelete   = { foreground = 160                                            },
    Directory    = { foreground =  39,                   attribute = 'bold'      },
    EndOfBuffer  = { foreground = 240,                   attribute = 'bold'      },
    ErrorMsg     = { foreground = 231, background = 160, attribute = 'bold'      },
    FoldColumn   = { foreground = 244                                            },
    Folded       = { foreground =  39,                   attribute = 'bold'      },
    LineNr       = { foreground = 240                                            },
    MatchParen   = { foreground = 231, background = 240, attribute = 'bold'      },
    ModeMsg      = { foreground = 144                                            },
    MoreMsg      = { foreground = 244,                   attribute = 'bold'      },
    MsgArea      = { foreground = 144                                            },
    MsgSeparator = { foreground = 244                                            },
    NonText      = { foreground = 144,                   attribute = 'bold'      },
    Normal       = { foreground = 253, background = 234                          },
    NormalFloat  = { foreground = 231, background = 233                          },
    Pmenu        = { foreground = 244, background = 233                          },
    PmenuSbar    = {                   background = 233                          },
    PmenuSel     = { foreground = 229, background = 233                          },
    PmenuThumb   = {                   background = 244                          },
    Question     = { foreground = 231,                   attribute = 'bold'      },
    QuickFixLine = { foreground = 231,                   attribute = 'bold'      },
    Search       = { foreground = 231, background =  93                          },
    SignColumn   = {                                     attribute = 'bold'      },
    SpecialKey   = { foreground = 229,                   attribute = 'bold'      },
    SpellBad     = { foreground = 160,                   attribute = 'underline' },
    SpellLocal   = {                                     attribute = 'underline' },
    SpellRare    = { foreground = 202,                   attribute = 'underline' },
    StatusLine   = { foreground = 144,                   attribute = 'bold'      },
    StatusLineNC = { foreground = 244, background = 235                          },
    Substitute   = { foreground = 234, background =  46, attribute = 'bold'      },
    TabLine      = { foreground = 244, background = 235                          },
    TabLineFill  = {                   background = 234                          },
    TabLineSel   = { foreground = 144, background = 235                          },
    TermCursorNC = { foreground = 234, background = 244                          },
    Title        = { foreground =  39,                   attribute = 'bold'      },
    VertSplit    = { foreground = 244                                            },
    Visual       = { foreground = 229, background =  93, attribute = 'bold'      },
    WarningMsg   = { foreground = 202                                            },
    Whitespace   = { foreground = 231, background = 160                          },
    WildMenu     = { foreground = 229                                            },
}

local builtin_links = {
    CursorColumn = 'CursorLine',
    CursorIM     = 'Cursor',
    DiffChange   = 'Normal',
    DiffText     = 'DiffAdd',
    IncSearch    = 'Search',
    NormalNC     = 'Normal',
    SpellCap     = 'SpellBad',
    TermCursor   = 'Cursor',
    VisualNOS    = 'Visual',
}

local generals = {
    Comment     = { foreground = 240,                                           },
    --
    Constant    = { foreground = 198,                                           },
    String      = { foreground =  36,                                           },
    Character   = { foreground =  46,                                           },
    --
    Identifier  = { foreground = 153,                                           },
    --
    Statement   = { foreground = 229,                                           },
    Conditional = { foreground = 229,                   attribute = 'bold'      },
    Repeat      = { foreground = 229,                   attribute = 'bold'      },
    Operator    = { foreground =  39,                                           },
    Exception   = { foreground = 229,                   attribute = 'bold'      },
    --
    PreProc     = { foreground =  39,                                           },
    --
    Type        = { foreground =  39,                   attribute = 'bold'      },
    --
    Special     = { foreground = 231,                                           },
    --
    Underlined  = {                                     attribute = 'underline' },
    --
    Ignore      = { foreground = 232, background = 231,                         },
    --
    Error       = { foreground = 231, background = 160, attribute = 'bold'      },
    --
    Todo        = { foreground = 234, background = 231, attribute = 'bold'      },
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
    local foreground_color = foreground_color and 'ctermfg=' .. foreground_color or 'ctermfg=NONE'
    local background_color = background_color and 'ctermbg=' .. background_color or 'ctermbg=NONE'
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
