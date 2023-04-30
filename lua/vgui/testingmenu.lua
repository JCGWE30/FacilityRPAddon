local PANEL = {
    Init = function(self)
        pane = self
        self:SetSize(300,600)
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

    end,
    AddTests = function(self,entity,test)
        local pane = self
        local rest = vgui.Create("DPanel",self)
        rest:Dock(FILL)
        rest:DockMargin(20,50,20,0)
        function rest:Paint() end
        for k,v in pairs(tests) do
        print(k.." "..test)
        print(preformedtests[k][test])
        if preformedtests[k][test] == true then
            local test = vgui.Create("DButton", rest)
            test:SetSize(0,50)
            test:SetText(v["display"])
            test:SetTextColor(color_white)
            test:Dock(TOP)
            test:DockMargin(0,10,0,0)
            test.Paint = function(self,w,h)
                draw.RoundedBox(20,0,0,w,h, Color(77,78,75,250))
            end
        else
            local test = vgui.Create("DButton", rest)
            test:SetSize(0,50)
            test:SetText(v["display"])
            test:Dock(TOP)
            test:DockMargin(0,10,0,0)
            test.Paint = function(self,w,h)
                draw.RoundedBox(20,0,0,w,h, Color(212,255,0,250))
            end
            test.DoClick = function(self,w,h)
                net.Start("tfc_test")
                net.WriteEntity(entity)
                net.WriteString(k)
                local pid = LocalPlayer():UserID()
                print(pid)
                net.WriteInt(pid,9)
                net.SendToServer()
                pane:SetVisible(false)
            end
        end
        end
    end,
    Paint = function(self,w,h)
        draw.RoundedBox(20,0,0,w,h,Color(47,47,47,200))
    end
}
vgui.Register("tfc_testmenu",PANEL)