AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    
    self:SetUseType(SIMPLE_USE)
    self:SetModel("models/props_wasteland/kitchen_counter001b.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Touch(ent)
    if(blacklist[ent]==true) then return end
    if(usewhitelist==true) then
        if(whitelist[ent:GetClass()]==nil) then return end
    end
    if self:GetSubject() == "" then
    local tent = ents.Create("prop_physics")
    tent:SetModel(ent:GetModel())
    tent:Spawn()
    tent:SetParent(self,0)
    print(ent:GetPos())
    tent:SetPos(Vector(0,0,20))
    ent:Remove()
    self:SetSubject(ent:GetClass())
    self:SetTestchild(tent)
    print(self:GetSubject())
    end
end

function ENT:Use(ply)
    if self:GetSubject() ~= "" and self:GetInuse() == false then
    net.Start("tfc_opentestable")
        net.WriteTable(preformedtests)
        net.WriteEntity(self)
        net.WriteString(self:GetSubject())
    net.Send(ply)
    end
end

function ENT:Think()
    if self:GetInuse() == true then
        print("Effeting everywhere")
        local data = EffectData()
        data:SetOrigin(self:GetPos()+Vector(0,0,20))
        data:SetScale(1)
        print(tests[self:GetTesttype()]["particleeffect"])
        util.Effect(tests[self:GetTesttype()]["particleeffect"],tests[self:GetTesttype()]["particledata"](data))
        if self:GetStarttime()+tests[self:GetTesttype()]["duration"] <= CurTime() then
            print(preformedtests[self:GetTesttype()])
            preformedtests[self:GetTesttype()][self:GetSubject()] = true
            utilfunctions.saveAll()
            net.Start("tfc_research")
            net.WriteBool(tests[self:GetTesttype()]["unlocks"][self:GetSubject()] ~= nil and unlocks[tests[self:GetTesttype()]["unlocks"][self:GetSubject()]] ~= true)
            net.Send(Player(self:GetResearcher()))
            if tests[self:GetTesttype()]["unlocks"][self:GetSubject()] ~= nil then
                print("unlock")
                //unlocks[tests[self:GetTesttype()]["unlocks"][self:GetSubject()]] = true
            end
            self:SetTesttype(0)
            self:SetInuse(false)
            self:GetTestchild():Remove()
            self:SetSubject("")
        end
    end
end