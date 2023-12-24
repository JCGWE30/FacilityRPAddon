utilfunctions = {}
util.AddNetworkString("tfc_openlocker")
util.AddNetworkString("tfc_takepackage")
util.AddNetworkString("tfc_fullinven")
util.AddNetworkString("tfc_opentestable")
util.AddNetworkString("tfc_test")
util.AddNetworkString("tfc_research")
util.AddNetworkString("tfc_opencrafter")
util.AddNetworkString("tfc_craft")
util.AddNetworkString("tfc_drop")

net.Receive("tfc_takepackage", function(len,ply)
    local ent = net.ReadString()
    if resourcecount[ent] > 0 then
        local wep = ents.Create("weapon_package")
        ply:PickupWeapon(wep)
        playerpackages[ply:SteamID()] = ent
        resourcecount[ent] = resourcecount[ent] - 1
        utilfunctions.saveAll()
    end
end)
net.Receive("tfc_test", function(len,ply)
    local ent = net.ReadEntity()
    if(ent:GetSubject() ~= nil) then
        ent:SetStarttime(CurTime())
        ent:SetTesttype(net.ReadString())
        ent:SetResearcher(ply:UserID())
        print(ent:GetSubject().." Button Start")
        ent:SetInuse(true)
    end
end)
net.Receive("tfc_craft", function()
    local rec = net.ReadString()
    for k, v in pairs(recipes[rec]["items"]) do
        if resourcecount[k] < v then return end
    end
    local ent=net.ReadEntity()
    ent:SetRecipe(rec)
    ent:SetInuse(true)
    ent:SetStarttime(CurTime())
    print(net.ReadEntity())
end)
net.Receive("tfc_drop", function(len,ply)
    local ent = net.ReadEntity()
    ent:GetTestchild():Remove()
    local wep = ents.Create("weapon_package")
    ply:PickupWeapon(wep)
    playerpackages[ply:SteamID()] = ent:GetSubject()
    ent:SetSubject("")
end)

utilfunctions.saveAll = function()
    local combined = {}
    combined.resource = resourcecount
    combined.models = modelreference
    combined.preformed = preformedtests
    combined.unlocked = unlocks
    local converted = util.TableToJSON(combined)
    file.Write("tfc_info.json",converted)
end