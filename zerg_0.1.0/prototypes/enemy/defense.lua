local function tint_21(i)
	return {r=0, g=1.05-i*0.05, b=-0.05+i*0.05, a=0.7}
end

local function buildings_data_extend_stats(name,i)
  if name == "su0" then
    defense_get_iddle = { layers = {
      {filename = "__zerg__/graphics/entity/enemy-base/colony-idle.png", width = 96, height = 80, scale = 1, shift = { -0.3, -0.3 }, frame_count = 6, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"},
      {filename = "__zerg__/graphics/entity/enemy-base/colony-idle-mask.png", width = 96, height = 80, scale = 1, shift = { -0.3, -0.3 }, tint = tint_21(i), frame_count = 6, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"}}}
    function defense_get_attack(run_mode) 
      return { layers = {
      {filename = "__zerg__/graphics/entity/enemy-base/colony-attack.png", width = 96, height = 80, scale = 1, shift = { -0.3, -0.3 }, frame_count = 10, direction_count = 12, axially_symmetrical = false, run_mode = run_mode},
      {filename = "__zerg__/graphics/entity/enemy-base/colony-attack-mask.png", width = 96, height = 80, scale = 1, shift = { -0.3, -0.3 }, tint = tint_21(i), frame_count = 10, direction_count = 12, axially_symmetrical = false, run_mode = run_mode}}}
	end
    defense_get_attack2 =
    {
      type = "projectile",
      ammo_category = "biological",
      cooldown = 1220-20*i,
      range = 29+ i,
      ammo_type =
      {
        category = "biological",
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            target_effects =
            {
              {
                type = "nested-result",
                action =
                {
                  {
                    type = "area",
                    radius = 3.5,
                    entity_flags = {"player-creation", "placeable-player", "placeable-neutral"},
					collision_mask = {"player-layer", "floor-layer"},
                    action_delivery =
                    {
                      type = "instant",
                      target_effects =
                      {
                        {
                          type = "damage",
                          damage = { amount = 8.5+1.5*i, type = "claw" }
                        }
                      }
                    }
                  },
                  {
                    type = "area",
                    radius = 1.5,
                    entity_flags = {"player-creation"},
					collision_mask = {"player-layer", "floor-layer"},
                    action_delivery =
                    {
                      type = "instant",
                      target_effects =
                      {
                        type = "damage",
                        damage = { amount = 8.5+1.5*i, type = "claw" }
                      }
                    }
                  }
                }
              },
              {
                type = "damage",
                damage = {amount = 8.5+1.5*i, type = "explosion"}
              },
              {
                type = "create-entity", entity_name = "spike" 
              }
            }
          }
        }
      }
    }
    defense_get_size = {{ -0.9, -0.7}, {0.9, 0.7}}
    defense_get_starting_attack_sound ={filename = "__zerg__/sound/enemies/sunken-atk.wav", volume = 0.6}
  elseif name == "co0" then
    defense_get_iddle = { layers = {
      {filename = "__zerg__/graphics/entity/enemy-base/colony2-idle.png", width = 96, height = 80, scale = 1, shift = { -0.2, -0.2 }, frame_count = 6, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"},
      {filename = "__zerg__/graphics/entity/enemy-base/colony2-idle-mask.png", width = 96, height = 80, scale = 1, shift = { -0.2, -0.2 }, tint = tint_21(i), frame_count = 6, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"}}}
    defense_get_size = {{ -0.9, -0.9}, {0.9, 0.9}}
  end
end

local evo_count = 20
for i = 1,evo_count do
  data:extend({
    {
      type = "turret",
      name = "ex0"..i,
      icon = "__zerg__/graphics/entity/enemy-base/icons/ex0.png",
      icon_size = 32,
      flags = {"placeable-enemy", "placeable-off-grid"},
      subgroup = "enemies",
      order="b-a",
      max_health = 1100+900*i,
      healing_per_tick = 0.05+0.05*i,
      collision_box = {{-0.5, -0.5}, {0.5, 0.5}},
      selection_box = {{-1, -1}, {1, 1}},
      shooting_cursor_size = 0,
      dying_explosion = "blood-explosion-big",
      corpse = "egg-corpse",
      folded_speed = 0.015,
      folded_animation =
      {
        layers=
        {
          {
            filename = "__zerg__/graphics/entity/enemy-base/extractor-idle.png",
            width = 640 / 5,
            height = 120,
            frame_count = 5,
            direction_count = 1,
            axially_symmetrical = false,
            shift = { -0.3, -0.1 },
            run_mode = "forward-then-backward"
          },
          {
            filename = "__zerg__/graphics/entity/enemy-base/extractor-idle-mask.png",
            width = 640 / 5,
            height = 120,
            frame_count = 5,
            direction_count = 1,
            axially_symmetrical = false,
            tint = tint_21(i),
            shift = { -0.3, -0.1 },
            run_mode = "forward-then-backward"
          },
        }
      },
      attack_parameters = {type = "projectile", range = 0, cooldown = 999, ammo_type = {category = "biological"}},
      call_for_help_radius = 40
    }
  })
  
  buildings_data_extend_stats("su0",i)
  data:extend({
    {
      type = "turret",
      name = "su0"..i,
      icon = "__zerg__/graphics/entity/enemy-base/icons/su0.png",
      icon_size = 32,
      flags = {"placeable-enemy", "placeable-off-grid"},
      order = "zsu0"..i,
      max_health = 800+800*0.45*(i-1),
      subgroup = "enemies",
      healing_per_tick = 0.1+0.1*i,
      collision_box = defense_get_size,
      selection_box = defense_get_size,
      shooting_cursor_size = 0,
      resistances = {{ type = "acid", percent = 90 },{ type = "claw", percent = 90 },{ type = "physical", percent = -2.5+2.5*i },{ type = "fire", percent = -2.5+2.5*i},{ type = "piercing", percent = 100 },{ type = "explosion", decrease = -9.9-3.1*i}},
      rotation_speed = 1,
      dying_explosion = "blood-explosion-huge",
      folded_speed = 0.015,
      folded_animation = defense_get_iddle,
      prepared_speed = 0.015,
      prepared_animation = defense_get_iddle,
      starting_attack_speed = 0.015,
      starting_attack_animation = defense_get_attack("forward"),
      starting_attack_sound = defense_get_starting_attack_sound,
      ending_attack_speed = 0.015,
      ending_attack_animation = defense_get_attack("backward"),
      attack_parameters = defense_get_attack2,
      call_for_help_radius = 40
    }
  })
  
  buildings_data_extend_stats("co0",i)
  data:extend({
    {
      type = "turret",
      name = "co0"..i,
      icon = "__zerg__/graphics/entity/enemy-base/icons/co0.png",
      icon_size = 32,
      flags = {"placeable-enemy", "placeable-off-grid"},
      order = "zco0"..i,
      max_health = 1000+1000*0.45*(i-1),
      subgroup = "enemies",
      healing_per_tick = 0.1+0.1*i,
      collision_box = defense_get_size,
      selection_box = defense_get_size,
      shooting_cursor_size = 0,
      resistances = {{ type = "acid", percent = 90 },{ type = "claw", percent = 90 },{ type = "physical", percent = -2.5+2.5*i },{ type = "fire", percent = -2.5+2.5*i},{ type = "piercing", percent = 100 },{ type = "explosion", decrease = -9.9-3.1*i}},
      dying_explosion = "blood-explosion-huge",
      folded_speed = 0.015,
      folded_animation = defense_get_iddle,
      attack_parameters = {type = "projectile", range = 0, cooldown = 999, ammo_type = {category = "biological"}},
      call_for_help_radius = 40
    }
  })
end