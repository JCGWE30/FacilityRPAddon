resourcecount = {}

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Crafting Station"

ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("String", 0, "Recipe")
    self:NetworkVar("Bool", 0, "Inuse")
    self:NetworkVar("Int", 0, "Starttime")
end