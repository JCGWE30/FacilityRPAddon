function ulx.toggleunlock( calling_ply, item,unlockstate )
    unlocks[item] = unlockstate
    if unlockstate then
        ulx.fancyLogAdmin( calling_ply, true, "#A unlocked #s recipe", item)
    else
        ulx.fancyLogAdmin( calling_ply, true, "#A locked #s recipe", item)
    end
end
local toggleunlock = ulx.command( "FacilityRP", "ulx toggleunlock", ulx.toggleunlock, "!toggleunlock" )
toggleunlock:addParam{ type=ULib.cmds.StringArg, hint="item"}
toggleunlock:addParam{ type=ULib.cmds.BoolArg, hint="unlockstate", ULib.cmds.takeRestOfLine }
toggleunlock:defaultAccess( ULib.ACCESS_ADMIN )
toggleunlock:help( "Unlocks a recipe" )