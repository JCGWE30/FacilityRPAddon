include("shared.lua")

function ENT:Draw()
    cam.Start3D2D(self:LocalToWorld(Vector(0, 0, 50)), Angle(0, EyeAngles().y - 90, -EyeAngles().x + 90), 0.05)
    if(self:GetInuse()) then
        draw.RoundedBox(30,-500,0,1000,150,color_white)
        local prog = math.Clamp(CurTime()-self:GetStarttime(),0,recipes[self:GetRecipe()]["duration"])
        local bar = (1000/recipes[self:GetRecipe()]["duration"])*prog
        local percent = (100/recipes[self:GetRecipe()]["duration"])*prog
        draw.RoundedBox(30,-500,0,bar,150,Color(0,255,0))
        draw.SimpleText("Crafting "..math.floor(percent).."%","Hovertext",0,30,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
    else
        draw.RoundedBox(30,-500,0,1000,150,Color(255,255,255))
        draw.SimpleText("No Recipe Selected","Hovertext",0,30,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
    end
    cam.End3D2D()
    self:DrawModel()
end