if CLIENT then
    include("tfc/sh_tfc.lua")
    include("tfc/cl_tfc.lua")
    include("vgui/lockermenu.lua")
    include("vgui/testingmenu.lua")
    include("vgui/craftingmenu.lua")
end
if SERVER then
    AddCSLuaFile("tfc/sh_tfc.lua")
    include("tfc/sh_tfc.lua")
    include("tfc/sv_tfc.lua")
    AddCSLuaFile("tfc/cl_tfc.lua")
    AddCSLuaFile("vgui/lockermenu.lua")
    AddCSLuaFile("vgui/testingmenu.lua")
    AddCSLuaFile("vgui/craftingmenu.lua")
end
print("Autorun Init")