local M = {}

local colors = require('lapland.colors')

local skies = {
    {
        darker   = colors.black,
        default  = colors.gray1,
        brighter = colors.gray2,
    },
    {
        darker   = colors.gray1,
        default  = colors.gray2,
        brighter = colors.gray3,
    },
    {
        darker   = colors.gray2,
        default  = colors.gray3,
        brighter = colors.gray4,
    },
    {
        darker   = colors.gray3,
        default  = colors.gray4,
        brighter = colors.gray5,
    },
    {
        darker   = colors.gray4,
        default  = colors.gray5,
        brighter = colors.gray6,
    },
}

local snows = {
    {
        darker   = colors.gray9,
        default  = colors.gray18,
        brighter = colors.gray21,
    },
    {
        darker   = colors.gray10,
        default  = colors.gray19,
        brighter = colors.gray22,
    },
    {
        darker   = colors.gray11,
        default  = colors.gray20,
        brighter = colors.gray23,
    },
    {
        darker   = colors.gray12,
        default  = colors.gray21,
        brighter = colors.gray24,
    },
    {
        darker   = colors.gray13,
        default  = colors.gray22,
        brighter = colors.white,
    },
}

local fruits = {
    {
        hint    = colors.gray13,
        red     = colors.glass_bull,
        magenta = colors.fancy_fuchsia,
        green   = colors.hobgoblin,
        blue    = colors.krishna_blue,
        cyan    = colors.ice_cold_stare,
        yellow  = colors.vic_20_creme,
        orange  = colors.mandarin_jelly,
        gold    = colors.daddy_o,
        purple  = colors.purple,
    },
}


function M.middle_index(table)
    return math.floor((#table + 1)/2)
end


function M.build(options)
    return vim.tbl_extend(
        'force',
        { sky = skies[math.min(math.max(M.middle_index(skies) + options.sky, 1), #skies)] },
        { snow = snows[math.min(math.max(M.middle_index(snows) + options.snow, 1), #snows)] },
        fruits[1]
    )
end

return M
