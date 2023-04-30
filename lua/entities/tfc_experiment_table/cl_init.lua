include("shared.lua")

function ENT:Draw()
    cam.Start3D2D(self:LocalToWorld(Vector(0, 0, 50)), Angle(0, EyeAngles().y - 90, -EyeAngles().x + 90), 0.05)
    if(self:GetInuse()) then
        draw.RoundedBox(30,-500,0,1000,150,color_white)
        local prog = math.Clamp(CurTime()-self:GetStarttime(),0,tests[self:GetTesttype()]["duration"])
        local bar = (1000/tests[self:GetTesttype()]["duration"])*prog
        local percent = (100/tests[self:GetTesttype()]["duration"])*prog
        draw.RoundedBox(30,-500,0,bar,150,Color(0,255,0))
        draw.SimpleText("Testing "..math.floor(percent).."%","Hovertext",0,30,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
    elseif(self:GetSubject()~="") then
        draw.RoundedBox(30,-500,0,1000,150,Color(94,94,94))
        draw.SimpleText("Pick a test","Hovertext",0,30,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
    else
        draw.RoundedBox(30,-500,0,1000,150,Color(94,94,94))
        draw.SimpleText("Pick something to test","Hovertext",0,30,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
    end
    cam.End3D2D()
    self:DrawModel()
end