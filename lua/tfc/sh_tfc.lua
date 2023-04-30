resourcecount = {}
modelreference = {}
playerpackages = {}
playerinventoryspace = {}
//Didint use JSON storage to save time
preformedtests = {}
unlocks = {}
blacklist = {
    "player",
    "tfc_crafter",
    "tfc_chute",
    "tfc_locker",
    "tfc_experiment_table"
}
usewhitelist = true
whitelist = {
    ["item_battery"] = "Battery",
    ["item_ammo_ar2"] = "AR2 Ammunition",
    ["item_rpg_round"] = "Rocket",
    ["item_ammo_ar2_altfire"] = "AR2 Orb",
    ["item_ammo_crossbow"] = "Scrap Metal"
}
recipes = {
    ["pulserifle"] = {
        ["display"] = "Pulse Rifle",
        ["ent"] = "weapon_ar2",
        ["model"] = "models/weapons/w_irifle.mdl",
        ["duration"] = 30,
        ["items"] = {
            ["item_battery"] = 3,
            ["item_ammo_ar2"] = 5,
            ["item_rpg_round"] = 1,
            ["item_ammo_ar2_altfire"] = 3
        }
    },
    ["rocketlauncher"] = {
        ["display"] = "RPG",
        ["ent"] = "weapon_rpg",
        ["model"] = "models/weapons/w_rocket_launcher.mdl",
        ["duration"] = 40,
        ["items"] = {
            ["item_battery"] = 3,
            ["item_rpg_round"] = 5,
        }
    },
    ["crowbar"] = {
        ["display"] = "Crowbar",
        ["ent"] = "weapon_crowbar",
        ["model"] = "models/weapons/w_crowbar.mdl",
        ["duration"] = 5,
        ["items"] = {
            ["item_ammo_crossbow"] = 3,
        }
    }
}
tests = {
    ["test_explode"] = {
        ["display"] = "Test Explosion Ressitance",
        ["unlocks"] = {
            ["item_rpg_round"] = "rocketlauncher"
        },
        ["duration"] = 5,
        ["particleeffect"] = "Explosion",
        ["particledata"] = function(data)
            data:SetScale(1)
            return data
        end
    },
    ["test_radiate"] = {
        ["display"] = "Test Radiation Ressistance",
        ["unlocks"] = {
            ["item_battery"] = "pulserifle"
        },
        ["duration"] = 5,
        ["particleeffect"] = "VortDispel",
        ["particledata"] = function(data)
            data:SetScale(1)
            return data
        end
    },
    ["test_ressistance"] = {
        ["display"] = "Test Material Strength",
        ["unlocks"] = {
            ["item_ammo_crossbow"] = "crowbar"
        },
        ["duration"] = 5,
        ["particleeffect"] = "GlassImpact",
        ["particledata"] = function(data)
            data:SetScale(1)
            return data
        end
    }
}
playerinvensize = 5

for k,v in pairs(tests) do
    preformedtests[k] = {}
    print(k.." is set")
end