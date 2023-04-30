resourcecount = {}

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Material Chute"

ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "Lastsuck")
end