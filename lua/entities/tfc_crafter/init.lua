AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

    self:SetUseType(SIMPLE_USE)
    self:SetModel("models/props_wasteland/controlroom_desk001a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(ply)
    if(self:GetInuse() == true) then return end
    net.Start("tfc_opencrafter")
    net.WriteTable(unlocks)
    net.WriteTable(resourcecount)
    net.WriteEntity(self)
    net.Send(ply)
end

function ENT:Think()
    if self:GetInuse() == true then
        local data = EffectData()
        data:SetOrigin(self:GetPos()+Vector(0,0,20))
        util.Effect("GlassImpact",data)
        if self:GetStarttime()+recipes[self:GetRecipe()]["duration"] <= CurTime() then
            local ent = ents.Create(recipes[self:GetRecipe()]["ent"])
            ent:SetPos(self:GetPos()+Vector(0,0,20))
            ent:Spawn()
            self:SetInuse(false)
        end
    end
end