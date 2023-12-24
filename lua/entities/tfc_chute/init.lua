AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

    self:SetModel("models/props_wasteland/laundry_cart002.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Touch(ent)
    if(blacklist[ent]==true or self:GetLastsuck()==ent) then return end
    if(usewhitelist==true) then
        if(whitelist[ent:GetClass()]==nil) then return end
    end
    self:SetLastsuck(ent)
    self:EmitSound("items/battery_pickup.wav")
    print(resourcecount[ent])
    if resourcecount[ent:GetClass()] == nil then
        resourcecount[ent:GetClass()] = 1
        modelreference[ent:GetClass()] = ent:GetModel()
    else
        print("Configuring")
        resourcecount[ent:GetClass()] = resourcecount[ent:GetClass()] + 1
    end
    utilfunctions.saveAll()
    ent:Remove()
end