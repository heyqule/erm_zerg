--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/17/2020
-- Time: 1:04 AM
-- To change this template use File | Settings | File Templates.
--
local ZergSound = {}

function ZergSound.enemy_death(name, volume)
    return {
        filename = "__erm_zerg__/sound/enemies/" .. name .. "/death.ogg",
        volume = volume
    }
end

function ZergSound.meele_attack(volume)
    return
    {
        audible_distance_modifier = 0.5,
        variations =
        {
            {
                filename = "__erm_zerg__/sound/enemies/zergling/attack.ogg",
                volume = volume
            },
            {
                filename = "__erm_zerg__/sound/enemies/ultralisk/attack.ogg",
                volume = volume
            }
        }
    }
end

function ZergSound.mutalisk_attack(volume)
    return
    {
        audible_distance_modifier = 0.5,
        variations =
        {
            {
                filename = "__erm_zerg__/sound/enemies/mutalisk/attack.ogg",
                volume = volume
            }
        }
    }
end

function ZergSound.hydralisk_attack(volume)
return
{
    audible_distance_modifier = 0.5,
    variations =
    {
        {
            filename = "__erm_zerg__/sound/enemies/hydralisk/attack.ogg",
            volume = volume
        }
    }
}
end

function ZergSound.devourer_attack(volume)
    return
    {
        audible_distance_modifier = 0.5,
        variations =
        {
            {
                filename = "__erm_zerg__/sound/enemies/devourer/attack.ogg",
                volume = volume
            }
        }
    }
end

function ZergSound.building_working_sound(name, volume)
    return
    {
        audible_distance_modifier = 1,
        max_sounds_per_type = 3,
        sound =
        {
            filename = "__erm_zerg__/sound/buildings/"..name..".ogg",
            volume = volume
        },
        probability = 1 / (15 * 60)
    }
end

function ZergSound.building_dying_sound(volume)
    return
    {
        audible_distance_modifier = 1,
        filename = "__erm_zerg__/sound/buildings/building_death.ogg",
        volume = volume
    }
end

function ZergSound.devourer_hit(volume)
    return
    {
        {
            filename = "__erm_zerg__/sound/enemies/devourer/goohit.ogg",
            volume = volume
        }
    }
end

function ZergSound.overlord_drop(volume)
    return
    {
        {
            filename = "__erm_zerg__/sound/enemies/overlord/attack.ogg",
            volume = volume
        }
    }
end

function ZergSound.lurker_hit(volume)
    return
    {
        {
            filename = "__erm_zerg__/sound/enemies/lurker/hit-1.ogg",
            volume = volume
        },
        {
            filename = "__erm_zerg__/sound/enemies/lurker/hit-2.ogg",
            volume = volume
        },
        {
            filename = "__erm_zerg__/sound/enemies/lurker/hit-3.ogg",
            volume = volume
        }

    }
end

function ZergSound.lurker_attack(volume)
    return
    {
        audible_distance_modifier = 0.5,
        variations =
        {
            {
                filename = "__erm_zerg__/sound/enemies/lurker/attack-1.ogg",
                volume = volume
            },
            {
                filename = "__erm_zerg__/sound/enemies/lurker/attack-2.ogg",
                volume = volume
            }
        }
    }
end

function ZergSound.sunker_idle(volume)
    return {
        audible_distance_modifier = 0.5,
        sound = {
            {
                filename = "__erm_zerg__/sound/buildings/sunker_colony.ogg",
                volume = volume
            },
        },
        probability = 1 / (15 * 60),
        max_sounds_per_type = 3,
    }
end

function ZergSound.sunker_attack(volume)
    return {
        audible_distance_modifier = 1,
        variations = {
            {
                filename = "__erm_zerg__/sound/buildings/sunker_attack.ogg",
                volume = volume
            },
        }
    }
end

function ZergSound.sunker_hit(volume)
    return {
        audible_distance_modifier = 0.5,
        variations = {
            {
                filename = "__erm_zerg__/sound/buildings/sunker_hit.ogg",
                volume = volume
            },
        }
    }
end

function ZergSound.spore_idle(volume)
    return {
        audible_distance_modifier = 0.5,
        sound = {
            {
                filename = "__erm_zerg__/sound/buildings/spore_colony.ogg",
                volume = volume
            },
        },
        max_sounds_per_type = 3,
        probability = 1 / (15 * 60),
    }
end

function ZergSound.infested_attack(volume)
    return {
        audible_distance_modifier = 0.5,
        variations = {
            {
                filename = "__erm_zerg__/sound/enemies/infested/attack.ogg",
                volume = volume
            },
            {
                filename = "__erm_zerg__/sound/enemies/infested/attack-2.ogg",
                volume = volume
            },
            {
                filename = "__erm_zerg__/sound/enemies/infested/attack-3.ogg",
                volume = volume
            },
        }
    }
end


function ZergSound.infested_death(volume)
    return {
        audible_distance_modifier = 0.5,
        variations = {
            {
                filename = "__erm_zerg__/sound/enemies/infested/death.ogg",
                volume = volume
            },
            {
                filename = "__erm_zerg__/sound/enemies/infested/death-1.ogg",
                volume = volume
            }
        }
    }
end

function ZergSound.defiler_attack(volume)
    return
    {
        audible_distance_modifier = 0.5,
        variations =
        {
            {
                filename = "__erm_zerg__/sound/enemies/defiler/attack.ogg",
                volume = volume
            }
        }
    }
end

function ZergSound.defiler_deat(volume)
    return
    {
        audible_distance_modifier = 0.5,
        variations =
        {
            {
                filename = "__erm_zerg__/sound/enemies/hydralisk/attack.ogg",
                volume = volume
            }
        }
    }
end

return ZergSound
