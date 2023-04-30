AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    
    self:SetUseType(SIMPLE_USE)
    self:SetModel("models/props_wasteland/controlroom_storagecloset001a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(ply)
    if playerpackages[ply:SteamID()] ~= nil then
        net.Start("tfc_fullinven")
        net.Send(ply)
        return
    end
    net.Start("tfc_openlocker")
        net.WriteTable(resourcecount)
        net.WriteTable(modelreference)
    net.Send(ply)
end