util.AddNetworkString("tfc_openlocker")
util.AddNetworkString("tfc_takepackage")
util.AddNetworkString("tfc_fullinven")
util.AddNetworkString("tfc_opentestable")
util.AddNetworkString("tfc_test")
util.AddNetworkString("tfc_research")
util.AddNetworkString("tfc_opencrafter")
util.AddNetworkString("tfc_craft")

net.Receive("tfc_takepackage", function(len,ply)
    local ent = net.ReadString()
    if resourcecount[ent] > 0 then
        local wep = ents.Create("weapon_package")
        ply:PickupWeapon(wep)
        playerpackages[ply:SteamID()] = ent
        resourcecount[ent] = resourcecount[ent] - 1
    end
end)
net.Receive("tfc_test", function(len,ply)
    local ent = net.ReadEntity()
    if(ent:GetSubject() ~= nil) then
        ent:SetStarttime(CurTime())
        ent:SetTesttype(net.ReadString())
        ent:SetResearcher(net.ReadInt(9))
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