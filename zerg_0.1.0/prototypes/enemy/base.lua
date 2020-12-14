local function tint_21(i)
	return {r=0, g=1.05-i*0.05, b=-0.05+i*0.05, a=0.7}
end

local function buildings_data_extend_stats(name,i)
	if name == "po0" then
		spawner_get_animation = { layers = {
			{filename = "__zerg__/graphics/entity/enemy-base/pool-idle.png", width = 768 / 6, height = 136, scale = 1, shift = { 0, -0.8 }, frame_count = 6, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"},
			{filename = "__zerg__/graphics/entity/enemy-base/pool-idle-mask.png", width = 768 / 6, height = 136, scale = 1, shift = { 0, -0.8 }, tint = tint_21(i), frame_count = 6, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"}}}
		selection_size = {{-1.4, -1}, {1.4, 1}}
		collision_size = {{-1.4, -1}, {1.4, 1}}
	elseif name == "nu0" then
		spawner_get_animation = { layers = {
			{filename = "__zerg__/graphics/entity/enemy-base/nursery-idle.png", width = 600 / 5, height = 96, scale = 1, shift = { 0.4, -0.3 }, frame_count = 5, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"},
			{filename = "__zerg__/graphics/entity/enemy-base/nursery-idle-mask.png", width = 600 / 5, height = 96, scale = 1, shift = { 0.4, -0.3 }, tint = tint_21(i), frame_count = 5, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"}}}
		selection_size = {{-1.2, -1}, {1.2, 1}}
		collision_size = {{-1.2, -1}, {1.2, 1}}
	elseif name == "de0" then
		spawner_get_animation = { layers = {
			{filename = "__zerg__/graphics/entity/enemy-base/den-idle.png", width = 600 / 5, height = 104, scale = 1, shift = { 0, -0.3 }, frame_count = 5, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"},
			{filename = "__zerg__/graphics/entity/enemy-base/den-idle-mask.png", width = 600 / 5, height = 104, scale = 1, shift = { 0, -0.3 }, tint = tint_21(i), frame_count = 5, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"}}}
		selection_size = {{-1.4, -1}, {1.4, 1}}
		collision_size = {{-1.4, -1}, {1.4, 1}}
	elseif name == "mo0" then
		spawner_get_animation = { layers = {
			{filename = "__zerg__/graphics/entity/enemy-base/mound-idle.png", width = 600 / 5, height = 96, scale = 1, shift = { 0, -0.3 }, frame_count = 5, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"},
			{filename = "__zerg__/graphics/entity/enemy-base/mound-idle-mask.png", width = 600 / 5, height = 96, scale = 1, shift = { 0, -0.3 }, tint = tint_21(i), frame_count = 5, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"}}}
		selection_size = {{-1.7, -1}, {1.7, 1}}
		collision_size = {{-1.7, -1}, {1.7, 1}}
	elseif name == "ca0" then
		spawner_get_animation = { layers = {
			{filename = "__zerg__/graphics/entity/enemy-base/cavern-idle.png", width = 600 / 5, height = 104, scale = 1.5, shift = { 0, -0.3 }, frame_count = 5, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"},
			{filename = "__zerg__/graphics/entity/enemy-base/cavern-idle-mask.png", width = 600 / 5, height = 104, scale = 1.5, shift = { 0, -0.3 }, tint = tint_21(i), frame_count = 5, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"}}}
		selection_size = {{-2.1, -1.5}, {2.1, 1.5}}
		collision_size = {{-2.1, -1}, {2.1, 1}}
	elseif name == "ch0" then
		spawner_get_animation = { layers = {
			{filename = "__zerg__/graphics/entity/enemy-base/chamber-idle.png", width = 600 / 5, height = 96, scale = 1.5, shift = { 0, -0.3 }, frame_count = 5, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"},
			{filename = "__zerg__/graphics/entity/enemy-base/chamber-idle-mask.png", width = 600 / 5, height = 96, scale = 1.5, shift = { 0, -0.3 }, tint = tint_21(i), frame_count = 5, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"}}}
		selection_size = {{-2.1, -1.5}, {2.1, 1.5}}
		collision_size = {{-2.1, -1}, {2.1, 1}}
	elseif name == "sp0" then
		spawner_get_animation = { layers = {
			{filename = "__zerg__/graphics/entity/enemy-base/spire-idle.png", width = 600 / 5, height = 104, scale = 1.5, shift = { -0.1, -1 }, frame_count = 5, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"},
			{filename = "__zerg__/graphics/entity/enemy-base/spire-idle-mask.png", width = 600 / 5, height = 104, scale = 1.5, shift = { -0.1, -1 }, tint = tint_21(i), frame_count = 5, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"}}}
		selection_size = {{-1.4, -2}, {1.4, 1}}
		collision_size = {{-1.4, -1}, {1.4, 1}}
	elseif name == "ne0" then
		spawner_get_animation = { layers = {
			{filename = "__zerg__/graphics/entity/enemy-base/nest-idle.png", width = 144, height = 136, scale = 2, shift = { -0.3, -1.5 }, frame_count = 6, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"},
			{filename = "__zerg__/graphics/entity/enemy-base/nest-idle-mask.png", width = 144, height = 136, scale = 2, shift = { -0.3, -1.5 }, tint = tint_21(i), frame_count = 6, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"}}}
		selection_size = {{-3, -2.3}, {3, 2.3}}
		collision_size = {{-2.8, -2}, {2.8, 2}}
	elseif name == "la0" then
		spawner_get_animation = { layers = {
			{filename = "__zerg__/graphics/entity/enemy-base/lair-idle.png", width = 144, height = 136, scale = 2, shift = { -0.8, -1.5 }, frame_count = 6, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"},
			{filename = "__zerg__/graphics/entity/enemy-base/lair-idle-mask.png", width = 144, height = 136, scale = 2, shift = { -0.8, -1.5 }, tint = tint_21(i), frame_count = 6, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"}}}
		selection_size = {{-3, -2.3}, {3, 2.3}}
		collision_size = {{-2.8, -2}, {2.8, 2}}
	elseif name == "hi0" then
		spawner_get_animation = { layers = {
			{filename = "__zerg__/graphics/entity/enemy-base/hive-idle.png", width = 144, height = 136, scale = 2, shift = { -0.3, -1.5 }, frame_count = 6, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"},
			{filename = "__zerg__/graphics/entity/enemy-base/hive-idle-mask.png", width = 144, height = 136, scale = 2, shift = { -0.3, -1.5 }, tint = tint_21(i), frame_count = 6, direction_count = 1, axially_symmetrical = false, run_mode = "forward-then-backward"}}}
		selection_size = {{-3, -2.3}, {2.8, 2.3}}
		collision_size = {{-2.8, -2}, {2.8, 2}}
	end
end

local function buildings_data_extend(name,hp,help_radius,lcmn,lcmx,prab)
  local evo_count = 20
  for i = 1,evo_count do
    buildings_data_extend_stats(name,i)
    data:extend({
    {
      type = "turret",
      name = name..i,
      icon = "__zerg__/graphics/entity/enemy-base/icons/"..name..".png",
      icon_size = 32,
      flags = {"placeable-enemy", "placeable-off-grid"},
      subgroup = "enemies",
      order = "z"..name..i,
      max_health = hp+hp*0.45*(i-1),
      healing_per_tick = 0.01+0.01*i,
      collision_box = collision_size,
      selection_box = selection_size,
      shooting_cursor_size = 0,
      resistances = {{ type = "acid", percent = 90 },{ type = "claw", percent = 90 },{ type = "physical", percent = -2.5+2.5*i },{ type = "fire", percent = -2.5+2.5*i},{ type = "piercing", percent = 100 },{ type = "explosion", decrease = -9.9-3.1*i}},
      dying_explosion = "blood-explosion-huge",
      folded_speed = 0.015,
      folded_animation = spawner_get_animation,
      prepared_speed = 0.015,
      prepared_animation = spawner_get_animation,
      attack_parameters =
      {
        type = "projectile",
        range = 100,
        cooldown = 3600,
        ammo_category = "biological",
        ammo_type =
        {
          category = "biological",
          action =
          {
            type = "direct",
            action_delivery =
            {
              type = "instant",
              source_effects =
              {
                  type = "create-entity",
                  entity_name = "base-check",
                  trigger_created_entity="true"
              }
            }
          }
        }
      },
      call_for_help_radius = help_radius
    }
    })
  end
end

buildings_data_extend("po0",1500,40,1,1,0.3)
buildings_data_extend("nu0",1500,40,1,1,0.3)
buildings_data_extend("de0",2000,40,1,1,0.5)
buildings_data_extend("mo0",2000,40,1,1,0.5)
buildings_data_extend("ch0",2500,40,1,1,0.7)
buildings_data_extend("ca0",2500,40,1,1,0.7)
buildings_data_extend("sp0",2500,40,1,1,0.7)

buildings_data_extend("ne0",5000,80,1,3,1)
buildings_data_extend("la0",10000,80,2,6,1)
buildings_data_extend("hi0",15000,80,3,9,1)
