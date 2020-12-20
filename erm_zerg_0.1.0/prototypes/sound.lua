--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/17/2020
-- Time: 1:04 AM
-- To change this template use File | Settings | File Templates.
--
local ZergSound = {}

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

return ZergSound
