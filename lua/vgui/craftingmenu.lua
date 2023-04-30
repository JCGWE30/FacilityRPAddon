local PANEL = {
    Init = function(self)
        
    end,

    Setup = function(self,parent)
        local craftable = true
        self:SetSize(1000,700)
        self:Center()
        self:SetVisible(true)
        self:MakePopup()

        local x,y = self:GetSize()

        local button = vgui.Create("DButton",self)
        button:SetText("X")
        button:SetSize(30,30)
        button:SetPos(x-40,10)
        button.DoClick = function()
            self:SetVisible(false)
        end
        button.Paint = function(self,w,h)
            draw.RoundedBox(20,0,0,w,h, Color(255,89,89,250))
        end
        local scroll = vgui.Create("DScrollPanel",self)
        scroll:Dock(BOTTOM)
        scroll:DockMargin( 0, 0, 0, 10 )
        scroll:SetSize(x-50,y-50)
        local thres = 2
        local parentpanel = nil
        for k,v in pairs(recipes) do
            thres = thres + 1
            if thres == 3 then
                print("Lapping")
                parentpanel = nil
                parentpanel = scroll:Add("DPanel")
                parentpanel:SetSize(950,315)
                parentpanel:Dock(TOP)
                parentpanel:DockMargin( 10, 0, 10, 5 )
                thres = 0
                function parentpanel:Paint(w,h)
                end
            end
            local modelrest = vgui.Create("DPanel",parentpanel)
            modelrest:SetSize(315,315)
            modelrest:Dock(LEFT)
            modelrest:DockMargin( 5, 0, 0, 0 )
            local modelpanel = vgui.Create("DModelPanel",modelrest)
            modelpanel:SetModel(v["model"])
            local mdlpos = modelpanel.Entity:GetPos()
            //Wiki code to make my life easier
            local mn, mx = modelpanel.Entity:GetRenderBounds()
            local size = 0
            size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
            size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
            size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )

            modelpanel:SetFOV( 45 )
            modelpanel:SetCamPos( Vector( size, size, size ) )
            modelpanel:SetLookAt( (mn + mx) * 0.5 )
            //Wiki code to make my life easier
            modelpanel:SetSize(315,315)
            modelpanel:SetFOV(70)
            modelpanel.DoClick = function()
                self:SetVisible(false)
            end
            local modeldamp = vgui.Create("DPanel",modelpanel)
            modeldamp:Dock(FILL)
            local ingpanel = vgui.Create("DPanel",modeldamp)
            ingpanel:Dock(FILL)
            ingpanel:DockMargin(50,50,50,70)
            function ingpanel:Paint()end
            for k,v in pairs(v["items"]) do
                local ing = vgui.Create("DLabel",ingpanel)
                ing:SetText("")
                ing:Dock(TOP)
                ing.Paint = function(self,w,h)
                    if resourcecount[k] == nil then resourcecount[k] = 0 end
                    local displaytext = resourcecount[k].."/"..v.." "..whitelist[k]
                    surface.SetFont("default")
                    offset = (w/2)-(surface.GetTextSize(displaytext)/2)
                    print(w.." "..surface.GetTextSize(displaytext))
                    local color = Color(0,255,0)
                    if resourcecount[k] < v then color = Color(255,0,0) craftable = false end
                    draw.SimpleText(displaytext,"default",offset,0,color,TEXT_ALIGN_TOP,TEXT_ALIGN_TOP)
                end
            end
            local modeldrop = vgui.Create("DButton",modeldamp)
            modeldrop:Dock(FILL)
            modeldrop:SetText("")
            modeldrop:DockMargin(20,250,20,20)
            if craftable then
            modeldrop.DoClick = function()
                self:SetVisible(false)
                net.Start("tfc_craft")
                net.WriteString(k)
                net.WriteEntity(parent)
                net.SendToServer()
            end
            end
            function modeldamp:Paint(w,h)
                if(unlocks[k]~=true) then
                    modeldrop:SetVisible(false)
                    modeldamp:SetVisible(true)
                    ingpanel:SetVisible(false)
                    draw.SimpleText("LOCKED","DermaLarge",100,150,Color(255,255,255,255),TEXT_ALIGN_TOP,TEXT_ALIGN_TOP)
                    draw.RoundedBox(30,0,0,w,h, Color(38,38,38,200))
                elseif(modeldamp:IsHovered() or modeldrop:IsHovered() or ingpanel:IsHovered()) then
                    ingpanel:SetVisible(true)
                    modeldrop:SetVisible(true)
                    draw.RoundedBox(30,0,0,w,h, Color(38,38,38,200))
                    local displaytext = v["display"]
                    surface.SetFont("DermaLarge")
                    offset = (w/2)-(surface.GetTextSize(displaytext)/2)
                    draw.SimpleText(displaytext,"DermaLarge",offset,0,Color(255,255,255,255),TEXT_ALIGN_TOP,TEXT_ALIGN_TOP)
                else
                    ingpanel:SetVisible(false)
                    modeldrop:SetVisible(false)
                end
            end
            function modeldrop:Paint(w,h)
                local color = Color(255,123,0,255)
                if !craftable then color = Color(23,23,23) end
                draw.RoundedBox(30,0,0,w,h, color)
                local text = "Craft"
                surface.SetFont("DermaLarge")
                offset = (w/2)-(surface.GetTextSize(text)/2)
                draw.SimpleText(text,"DermaLarge",offset,5,Color(255,255,255,255),TEXT_ALIGN_TOP,TEXT_ALIGN_TOP)
            end
            function modelrest:Paint(w,h)
                draw.RoundedBox(30,0,0,w,h, Color(255,255,255,20))
            end
        end
        local bar = scroll:GetVBar()
        function bar:Paint(w,h)
            draw.RoundedBox(20,0,0,w,h, Color(38,38,38,0))
        end
        function bar.btnUp:Paint(w,h) end
        function bar.btnDown:Paint(w,h) end
        function bar.btnGrip:Paint(w,h)
            draw.RoundedBox(20,0,0,w,h, Color(38,38,38,255))
        end
    end,

    Paint = function(self,w,h)
        draw.RoundedBox(0,0,0,w,h, Color(10,10,10,250))
        //surface.SetDrawColor(255,255,255)
        //surface.DrawOutlinedRect(2,2,w-4,h-4)
    end
}
vgui.Register("tfc_craftingmenu",PANEL)