surface.CreateFont( "Hovertext", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 100,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

net.Receive("tfc_openlocker", function()
    resourcecount = net.ReadTable()
    modelreference = net.ReadTable()
    lockermenu = vgui.Create("tfc_lockermenu")
end)
net.Receive("tfc_opentestable", function()
    tablemenu = vgui.Create("tfc_testmenu")
    preformedtests = net.ReadTable()
    tablemenu:AddTests(net.ReadEntity(),net.ReadString())
end)
net.Receive("tfc_fullinven", function()
    notification.AddLegacy("You cannot open the storage locker with a package in your inventory", NOTIFY_ERROR, 2)
    surface.PlaySound( "buttons/button10.wav")
end)
net.Receive("tfc_research", function()
    local succeed = net.ReadBool()
    if(succeed) then
        notification.AddLegacy("The effects of this test were noteworthy", NOTIFY_GENERIC, 2)
        surface.PlaySound( "buttons/button9.wav")
    else
        notification.AddLegacy("Nothing happened", NOTIFY_ERROR, 2)
        surface.PlaySound( "buttons/button10.wav")
    end
end)
net.Receive("tfc_opencrafter", function()
    unlocks = net.ReadTable()
    resourcecount = net.ReadTable()
    local ent = net.ReadEntity()
    for k,v in pairs(unlocks) do print(k) end
    lockermenu = vgui.Create("tfc_craftingmenu")
    lockermenu:Setup(ent)
end)