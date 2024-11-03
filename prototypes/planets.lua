---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 10/26/2024 7:20 PM
---

if feature_flags.space_travel then

local effects = require("__core__.lualib.surface-render-parameter-effects")
local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")
local planet_catalogue_vulcanus = require("__space-age__.prototypes.planet.procession-catalogue-vulcanus")

  local char_mapgen = function()
        return
        {
            property_expression_names =
            {
                elevation = "vulcanus_elevation",
                temperature = "vulcanus_temperature",
                moisture = "vulcanus_moisture",
                aux = "vulcanus_aux",
                cliffiness = "cliffiness_basic",
                cliff_elevation = "cliff_elevation_from_elevation",
                ["entity:coal:probability"] = "vulcanus_coal_probability",
                ["entity:coal:richness"] = "vulcanus_coal_richness",
                ["entity:calcite:probability"] = "vulcanus_calcite_probability",
                ["entity:calcite:richness"] = "vulcanus_calcite_richness",
                ["entity:sulfuric-acid-geyser:probability"] = "vulcanus_sulfuric_acid_geyser_probability",
                ["entity:sulfuric-acid-geyser:richness"] = "vulcanus_sulfuric_acid_geyser_richness",
            },
            cliff_settings =
            {
                name = "cliff-vulcanus",
                cliff_elevation_interval = 120,
                cliff_elevation_0 = 70
            },
            territory_settings =
            {
                units = {"small-demolisher", "medium-demolisher", "big-demolisher"},
                territory_index_expression = "demolisher_territory_expression",
                territory_variation_expression = "demolisher_variation_expression",
                minimum_territory_size = 10
            },
            autoplace_controls =
            {
                ["vulcanus_coal"] = {},
                ["sulfuric_acid_geyser"] = {},
                ["tungsten_ore"] = {},
                ["calcite"] = {},
                ["vulcanus_volcanism"] = {},
                [AUTOCONTROL_NAME] = {},
                --["rocks"] = {}, -- can"t add the rocks control otherwise nauvis rocks spawn
            },
            autoplace_settings =
            {
                ["tile"] =
                {
                    settings =
                    {
                        --nauvis tiles
                        ["volcanic-soil-dark"] = {},
                        ["volcanic-soil-light"] = {},
                        ["volcanic-ash-soil"] = {},
                        --end of nauvis tiles
                        ["volcanic-ash-flats"] = {},
                        ["volcanic-ash-light"] = {},
                        ["volcanic-ash-dark"] = {},
                        ["volcanic-cracks"] = {},
                        ["volcanic-cracks-warm"] = {},
                        ["volcanic-folds"] = {},
                        ["volcanic-folds-flat"] = {},
                        ["lava"] = {},
                        ["lava-hot"] = {},
                        ["volcanic-folds-warm"] = {},
                        ["volcanic-pumice-stones"] = {},
                        ["volcanic-cracks-hot"] = {},
                        ["volcanic-jagged-ground"] = {},
                        ["volcanic-smooth-stone"] = {},
                        ["volcanic-smooth-stone-warm"] = {},
                        ["volcanic-ash-cracks"] = {},
                    }
                },
                ["decorative"] =
                {
                    settings =
                    {
                        -- nauvis decoratives
                        ["v-brown-carpet-grass"] = {},
                        ["v-green-hairy-grass"] = {},
                        ["v-brown-hairy-grass"] = {},
                        ["v-red-pita"] = {},
                        -- end of nauvis
                        ["vulcanus-rock-decal-large"] = {},
                        ["vulcanus-crack-decal-large"] = {},
                        ["vulcanus-crack-decal-huge-warm"] = {},
                        ["vulcanus-dune-decal"] = {},
                        ["vulcanus-sand-decal"] = {},
                        ["vulcanus-lava-fire"] = {},
                        ["calcite-stain"] = {},
                        ["calcite-stain-small"] = {},
                        ["sulfur-stain"] = {},
                        ["sulfur-stain-small"] = {},
                        ["sulfuric-acid-puddle"] = {},
                        ["sulfuric-acid-puddle-small"] = {},
                        ["crater-small"] = {},
                        ["crater-large"] = {},
                        ["pumice-relief-decal"] = {},
                        ["small-volcanic-rock"] = {},
                        ["medium-volcanic-rock"] = {},
                        ["tiny-volcanic-rock"] = {},
                        ["tiny-rock-cluster"] = {},
                        ["small-sulfur-rock"] = {},
                        ["tiny-sulfur-rock"] = {},
                        ["sulfur-rock-cluster"] = {},
                        ["waves-decal"] = {},
                    }
                },
                ["entity"] =
                {
                    settings =
                    {
                        ["coal"] = {},
                        ["calcite"] = {},
                        ["sulfuric-acid-geyser"] = {},
                        ["tungsten-ore"] = {},
                        ["huge-volcanic-rock"] = {},
                        ["big-volcanic-rock"] = {},
                        ["crater-cliff"] = {},
                        ["vulcanus-chimney"] = {},
                        ["vulcanus-chimney-faded"] = {},
                        ["vulcanus-chimney-cold"] = {},
                        ["vulcanus-chimney-short"] = {},
                        ["vulcanus-chimney-truncated"] = {},
                        ["ashland-lichen-tree"] = {},
                        ["ashland-lichen-tree-flaming"] = {},
                    }
                }
            }
        }
    end

    data:extend({
        --- Planet
        {
            type = "planet",
            name = "char",
            icon = "__space-age__/graphics/icons/vulcanus.png",
            starmap_icon = "__space-age__/graphics/icons/starmap-planet-vulcanus.png",
            starmap_icon_size = 512,
            gravity_pull = 10,
            distance = 12.5,
            orientation = 0.9,
            magnitude = 1,
            order = "b[char]",
            subgroup = "planets",
            map_gen_settings = char_mapgen(),
            pollutant_type = nil,
            solar_power_in_space = 500,
            platform_procession_set =
            {
                arrival = {"planet-to-platform-b"},
                departure = {"platform-to-planet-a"}
            },
            planet_procession_set =
            {
                arrival = {"platform-to-planet-b"},
                departure = {"planet-to-platform-a"}
            },
            procession_graphic_catalogue = planet_catalogue_vulcanus,
            surface_properties =
            {
                ["day-night-cycle"] = 5 * minute,
                ["magnetic-field"] = 25,
                ["solar-power"] = 400,
                pressure = 4000,
                gravity = 40
            },
            asteroid_spawn_influence = 1,
            asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus, 0.9),
            persistent_ambient_sounds =
            {
                base_ambience = {filename = "__space-age__/sound/wind/base-wind-vulcanus.ogg", volume = 0.8},
                wind = {filename = "__space-age__/sound/wind/wind-vulcanus.ogg", volume = 0.8},
                crossfade =
                {
                    order = {"wind", "base_ambience"},
                    curve_type = "cosine",
                    from = {control = 0.35, volume_percentage = 0.0},
                    to = {control = 2, volume_percentage = 100.0}
                },
                semi_persistent =
                {
                    {
                        sound = {variations = sound_variations("__space-age__/sound/world/semi-persistent/distant-rumble", 3, 0.5)},
                        delay_mean_seconds = 10,
                        delay_variance_seconds = 5
                    },
                    {
                        sound = {variations = sound_variations("__space-age__/sound/world/semi-persistent/distant-flames", 5, 0.6)},
                        delay_mean_seconds = 15,
                        delay_variance_seconds = 7.0
                    }
                }
            },
            surface_render_parameters =
            {
                fog = effects.default_fog_effect_properties(),
                -- clouds = effects.default_clouds_effect_properties(),

                -- Should be based on the default day/night times, ie
                -- sun starts to set at 0.25
                -- sun fully set at 0.45
                -- sun starts to rise at 0.55
                -- sun fully risen at 0.75
                day_night_cycle_color_lookup =
                {
                    {0.0, "__space-age__/graphics/lut/vulcanus-1-day.png"},
                    {0.20, "__space-age__/graphics/lut/vulcanus-1-day.png"},
                    {0.45, "__space-age__/graphics/lut/vulcanus-2-night.png"},
                    {0.55, "__space-age__/graphics/lut/vulcanus-2-night.png"},
                    {0.80, "__space-age__/graphics/lut/vulcanus-1-day.png"},
                },

                terrain_tint_effect =
                {
                    noise_texture =
                    {
                        filename = "__space-age__/graphics/terrain/vulcanus/tint-noise.png",
                        size = 4096
                    },

                    offset = { 0.2, 0, 0.4, 0.8 },
                    intensity = { 0.5, 0.2, 0.3, 1.0 },
                    scale_u = { 3, 1, 1, 1 },
                    scale_v = { 1, 1, 1, 1 },

                    global_intensity = 0.3,
                    global_scale = 0.1,
                    zoom_factor = 3,
                    zoom_intensity = 0.6
                }
            }
        },
        --- space connection
        {
            type = "space-connection",
            name = "char-nauvis",
            subgroup = "planet-connections",
            from = "char",
            to = "nauvis",
            order = "char-nauvis",
            length = 30000,
            asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus)
        },
        {
            type = "space-connection",
            name = "char-vulcanus",
            subgroup = "planet-connections",
            from = "char",
            to = "vulcanus",
            order = "vulcanus-char",
            length = 15000,
            asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus)
        },
        --- unlock tech
        {
            type = "technology",
            name = "planet-discovery-char",
            icons = util.technology_icon_constant_planet("__space-age__/graphics/technology/vulcanus.png"),
            icon_size = 256,
            essential = false,
            effects =
            {
                {
                    type = "unlock-space-location",
                    space_location = "char",
                    use_icon_overlay_constant = true
                },
            },
            prerequisites = {"space-platform-thruster", "landfill"},
            unit =
            {
                count = 1000,
                ingredients =
                {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"space-science-pack", 1}
                },
                time = 60
            }
        },
    })

end
