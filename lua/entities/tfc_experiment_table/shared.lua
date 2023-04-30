resourcecount = {}

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Testing Table"

ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("String", 0, "Subject")
    self:NetworkVar("String", 1, "Testtype")
    self:NetworkVar("Bool", 0, "Inuse")
    self:NetworkVar("Int", 0, "Starttime")
    self:NetworkVar("Entity", 0, "Testchild")
    self:NetworkVar("Int", 1, "Researcher")
end