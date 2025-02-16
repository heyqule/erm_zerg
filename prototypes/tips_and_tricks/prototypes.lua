---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 11/2/2024 7:01 PM
---

local simulations = require("__erm_zerg__/prototypes/tips_and_tricks/simulations")

data:extend(
    {
        {
            type = "tips-and-tricks-item-category",
            name = FORCE_NAME,
            order = "n01-["..FORCE_NAME.."]"
        },
        {
            type = "tips-and-tricks-item",
            name = FORCE_NAME.."-general-info",
            tag = "[entity="..FORCE_NAME.."--zergling--1]",
            category = FORCE_NAME,
            order = "a",
            is_title = true,
            starting_status = "suggested",
            simulation = simulations.general
        },
    }
)

if feature_flags.space_travel then
    data:extend(
        {
            {
                type = "tips-and-tricks-item",
                name = FORCE_NAME.."-nydus_worms",
                tag = "[entity="..FORCE_NAME.."--small-nydusworm]",
                category = FORCE_NAME,
                order = "b",
                indent = 1,
                starting_status = "suggested",
                simulation = simulations.nydus_worms
            },
            {
                type = "tips-and-tricks-item",
                tag = "[planet=char]",
                name = FORCE_NAME.."-planet-char",
                category = FORCE_NAME,
                order = "c",
                indent = 1,
                starting_status = "suggested",
                simulation = simulations.planet_char
            },
        })
end