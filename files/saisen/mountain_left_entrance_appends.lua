dofile_once("mods/th_immortal/files/environment.lua")
dofile_once("mods/th_immortal/files/utilities.lua")

local raw_init = init
function init(x, y, w, h)
    raw_init(x, y, w, h)
    local saisen = EntityLoad("mods/th_immortal/files/saisen/saisen.xml", x + 100, y + 450)
    local saisen_object = Saisen(saisen)
    saisen_object.contents = "mods/th_immortal/files/gohei/gohei.xml"
end
