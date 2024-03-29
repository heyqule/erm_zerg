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

        variations = {
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

function ZergSound.broodling_attack(volume)
    return
    {

        filename = "__erm_zerg__/sound/enemies/broodling/attack.ogg",
        volume = volume
    }
end

function ZergSound.mutalisk_attack(volume)
    return
    {

        filename = "__erm_zerg__/sound/enemies/mutalisk/attack.ogg",
        volume = volume
    }
end

function ZergSound.guardian_attack(volume)
    return
    {

        filename = "__erm_zerg__/sound/enemies/guardian/attack.ogg",
        volume = volume
    }
end

function ZergSound.hydralisk_attack(volume)
    return
    {

        filename = "__erm_zerg__/sound/enemies/hydralisk/attack.ogg",
        volume = volume
    }
end

function ZergSound.devourer_attack(volume)
    return
    {

        filename = "__erm_zerg__/sound/enemies/devourer/attack.ogg",
        volume = volume
    }
end

function ZergSound.building_working_sound(name, volume)
    return
    {

        max_sounds_per_type = 2,
        sound = {
            filename = "__erm_zerg__/sound/buildings/" .. name .. ".ogg",
            volume = volume
        },
        probability = 1 / (15 * 60)
    }
end

function ZergSound.building_dying_sound(volume)
    return
    {
        filename = "__erm_zerg__/sound/buildings/building_death.ogg",
        volume = volume
    }
end

function ZergSound.cmd_building_dying_sound(volume)
    return
    {
        filename = "__erm_zerg__/sound/buildings/infested_building_death.ogg",
        volume = volume
    }
end

function ZergSound.devourer_hit(volume)
    return
    {

        filename = "__erm_zerg__/sound/enemies/devourer/goohit.ogg",
        volume = volume
    }
end

function ZergSound.overlord_drop(volume)
    return
    {

        filename = "__erm_zerg__/sound/enemies/overlord/attack.ogg",
        volume = volume
    }
end

function ZergSound.lurker_hit(volume)
    return
    {

        variations = {
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
    }
end

function ZergSound.lurker_attack(volume)
    return
    {

        variations = {
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

function ZergSound.sunken_idle(volume)
    return {

        sound = {
            {
                filename = "__erm_zerg__/sound/buildings/sunken_colony.ogg",
                volume = volume
            },
        },
        probability = 1 / (15 * 60),
        max_sounds_per_type = 3,
    }
end

function ZergSound.sunken_attack(volume)
    return {

        filename = "__erm_zerg__/sound/buildings/sunken_colony_attack.ogg",
        volume = volume
    }
end

function ZergSound.sunken_hit(volume)
    return {

        filename = "__erm_zerg__/sound/buildings/sunken_colony_hit.ogg",
        volume = volume
    }
end

function ZergSound.spore_idle(volume)
    return {

        sound = {
            {
                filename = "__erm_zerg__/sound/buildings/spore_colony.ogg",
                volume = volume
            },
        },
        max_sounds_per_type = 2,
        probability = 1 / (15 * 60),
    }
end

function ZergSound.infested_attack(volume)
    return {

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

        filename = "__erm_zerg__/sound/enemies/defiler/attack.ogg",
        volume = volume
    }
end

function ZergSound.scourge_attack(volume)
    return {

        variations = {
            {
                filename = "__erm_zerg__/sound/enemies/scourge/attack.ogg",
                volume = volume
            },
            {
                filename = "__erm_zerg__/sound/enemies/scourge/attack-2.ogg",
                volume = volume
            },
            {
                filename = "__erm_zerg__/sound/enemies/scourge/attack-3.ogg",
                volume = volume
            },
        }
    }
end

function ZergSound.scourge_death(volume)
    return {

        variations = {
            {
                filename = "__erm_zerg__/sound/enemies/scourge/death.ogg",
                volume = volume
            },
            {
                filename = "__erm_zerg__/sound/enemies/scourge/death-1.ogg",
                volume = volume
            }
        }
    }
end

return ZergSound
