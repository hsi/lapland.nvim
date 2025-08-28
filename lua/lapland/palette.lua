local M = {}

local colors = require('lapland.colors')

local sky = {
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
}

local snow = {
    darker   = colors.gray9,
    default  = colors.gray22,
    brighter = colors.white,
}

local palette = {
    -- "Snow" palette
    hint       = colors.gray13,
    -- "Fruit" palette
    magenta = colors.fancy_fuchsia,
    green   = colors.hobgoblin,
    blue    = colors.krishna_blue,
    cyan    = colors.ice_cold_stare,
    yellow  = colors.vic_20_creme,
    orange  = colors.mandarin_jelly,
    gold    = colors.daddy_o,
    purple  = colors.purple,
}


function M.build(options)
    palette.sky = sky[math.min(math.max(math.floor(#sky/2 + 0.5) + options.sky, 1), #sky)]
    palette.snow = snow

    return palette
end

return M
