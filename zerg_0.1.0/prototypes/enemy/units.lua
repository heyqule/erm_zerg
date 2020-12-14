--require ("prototypes.entity.demo-biter-animations")
--require ("prototypes.entity.demo-spitter-animations")
--require ("prototypes.entity.demo-spitter-projectiles")

local corpses_on = settings.startup["zerg-enemy-corpses"].value
local time_before_removed_corpse = 1
if corpses_on then
	time_before_removed_corpse = settings.startup["zerg-enemy-corpse-time"].value
end

local function queen_run_animation(scale)
  return
  {
	filename = "__zerg__/graphics/entity/units/queen/queen-run_01.png",
    width = 96,
    height = 96,
    frame_count = 16,
    axially_symmetrical = false,
    direction_count = 16,
    scale = scale
  }
end

local function queen_attack_animation(scale)
  return
  {
    width = 96,
    height = 96,
    frame_count = 18+17,
    axially_symmetrical = false,
    direction_count = 16,
    animation_speed = 0.4,
    scale = scale,
    stripes =
    {
      {
        filename = "__zerg__/graphics/entity/units/queen/queen-attack_01.png",
        width_in_frames = 18,
        height_in_frames = 16,
      },
      {
        filename = "__zerg__/graphics/entity/units/queen/queen-attack_02.png",
        width_in_frames = 17,
        height_in_frames = 16,
      }
    }
  }
end

local function queen_die_animation(scale)
  return
  {
    filename = "__zerg__/graphics/entity/units/queen/queen-die_01.png",
    width = 96,
    height = 96,
    frame_count = 10,
    axially_symmetrical = false,
    direction_count = 16,
    scale = scale
  }
end

local function tint_11(i)
	return {r=0, g=1.1-i*0.1, b=-0.1+i*0.1, a=0.7}
end

local function tint_shadow(i)
	return {r=0, g=0, b=0, a=0.7}
end

local function defiler_attack()
  return
    {
      category = "biological",
      target_type = "direction",
      action =
      {
        type = "direct",
        action_delivery =
        {
          {
            type = "projectile",
            projectile = "defiler-atk",
            starting_speed = 0.1,
            max_range = 0.2,
          }
        }
      }
    }
end

local unit_scale
local unit_get_run
local collision_size
local selection_size
local sticker_size
local unit_get_shooting_cursor_size
local unit_get_attack_parameters
local unit_get_movement_speed
local unit_get_distance_per_frame
local unit_get_dying_sound
local unit_get_vision_distance
local unit_get_resistances
local unit_get_dying_explosion
local unit_get_collision_mask

local function units_data_extend_stats(name,i)
	if name == "zrlg" then
		unit_scale = 1
		unit_get_run = {
			layers={
				{
					filename = "__zerg__/graphics/entity/units/zerling/zergling-run.png",
					width = 128,
					height = 128,
					frame_count = 5,
					axially_symmetrical = false,
					direction_count = 16,
					scale = unit_scale,
					animation_speed = 0.6
				},
				{
					filename = "__zerg__/graphics/entity/units/zerling/zergling-run-mask.png",
					width = 128,
					height = 128,
					frame_count = 5,
					axially_symmetrical = false,
					direction_count = 16,
					flags = {"mask"},
					scale = unit_scale,
					tint = tint_shadow(i),
					animation_speed = 0.6
				}
			}
		}
		unit_get_attack = {
			layers={
				{
					filename = "__zerg__/graphics/entity/units/zerling/zergling-attack.png",
					width = 128,
					height = 128,
					frame_count = 5,
					axially_symmetrical = false,
					direction_count = 16,
					scale = unit_scale,
					animation_speed = 0.6
				},
				{
					filename = "__zerg__/graphics/entity/units/zerling/zergling-attack-mask.png",
					width = 128,
					height = 128,
					frame_count = 5,
					axially_symmetrical = false,
					direction_count = 16,
					flags = {"mask"},
					scale = unit_scale,
					tint = tint_shadow(i),
					animation_speed = 0.6
				}
			}
		}
		unit_get_die = {
			filename = "__zerg__/graphics/entity/units/zerling/zergling-death.png",
			width = 128,
			height = 128,
			frame_count = 7,
			direction_count = 1,
			scale = unit_scale,
			axially_symmetrical = false
		}
		collision_size = {{-0.3, -0.3}, {0.3, 0.3}}
		selection_size = {{-0.3, -0.3}, {0.3, 0.3}}
		sticker_size = {{-0.2, -0.3}, {0.2, 0.1}}
		unit_get_shooting_cursor_size = 1
		unit_get_attack_parameters = { type = "projectile", range = 1.5, cooldown = 25, ammo_type = make_unit_melee_ammo_type(5.4+0.6*i), sound = {filename = "__zerg__/sound/enemies/zerling-atk.wav", volume = 0.5}, animation = unit_get_attack}
		unit_get_movement_speed = 0.1+0.02*i
		unit_get_distance_per_frame = 0.22
		unit_get_dying_sound = {filename = "__zerg__/sound/enemies/zerling-dth.wav", volume = 0.5}
		unit_get_vision_distance  = 29+i
		unit_get_resistances =
		{
			{ type = "acid", percent = 95 },
			{ type = "claw", percent = 90 },
			{ type = "physical", percent = 19+1*i },
			{ type = "fire", percent = -38-2*i },
			{ type = "piercing", percent = 100 },
			{ type = "explosion", decrease = -2 }
		}
		unit_get_dying_explosion = "blood-explosion-small"
		unit_get_collision_mask = {"player-layer"}
	elseif name == "bnlg" then
		unit_scale = 1
		unit_get_run = {filename = "__zerg__/graphics/entity/units/baneling/baneling-run_01.png", width = 48, height = 48, frame_count = 15, axially_symmetrical = false, direction_count = 16,scale = unit_scale}
		unit_get_die = nil
		collision_size = {{-0.3, -0.3}, {0.3, 0.3}}
		selection_size = {{-0.3, -0.3}, {0.3, 0.3}}
		sticker_size = {{-0.2, -0.3}, {0.3, 0.3}}
		unit_get_shooting_cursor_size = 1
		unit_get_attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 100,
			ammo_type =
			{
				category = "biological",
				target_type = "direction",
				action =
				{
					type = "direct",
					action_delivery =
					{
						type = "instant",
						target_effects =
						{
							{
								type = "damage",
								collision_mask = {"not-colliding-with-itself"},
								damage = { amount = 16+4*i, type = "acid"}
							}
						},
						source_effects =
						{
							{
								type = "damage",
								damage = { amount = 1000, type = "self"}
							}
						}
					}
				}
			},
			sound = {filename = "__zerg__/sound/enemies/baneling-atk.wav", volume = 1},
			animation = unit_get_run
		}
		unit_get_movement_speed = 0.08+0.02*i
		unit_get_distance_per_frame = 0.17
		unit_get_dying_sound = {filename = "__zerg__/sound/enemies/baneling-dth.wav", volume = 0.5}
		unit_get_vision_distance  = 29+i
		unit_get_resistances =
		{
			{ type = "acid", percent = 95 },
			{ type = "claw", percent = 90 },
			{ type = "physical", percent = -39-1*i },
			{ type = "fire", percent = 19+1*i },
			{ type = "piercing", percent = 100 }, 
			{ type = "explosion", decrease = -2 }
		}
		unit_get_dying_explosion = "blood-explosion-small"
		unit_get_collision_mask = {"player-layer"}
	elseif name == "scrg" then
		unit_scale = 0.7
		unit_have_tint = true
		unit_get_run = {
			layers={
				{filename = "__zerg__/graphics/entity/units/defiler/defiler-run.png",
					width = 69,
					height = 59,
					frame_count = 8,
					axially_symmetrical = false,
					direction_count = 16,
					scale = unit_scale,
					shift = { -0.08, -0.1
					}},
				{filename = "__zerg__/graphics/entity/units/defiler/defiler-run-mask.png",
					width = 69,
					height = 59,
					frame_count = 8,
					axially_symmetrical = false,
					direction_count = 16,
        			flags = {"mask"},
					scale = unit_scale,
					tint = tint_11(i),
					shift = { -0.08, -0.1 }
				}
			}
		}
		unit_get_die = nil
		collision_size = {{-0.4, -0.4}, {0.4, 0.4}}
		selection_size = {{-0.4, -0.4}, {0.4, 0.4}}
		sticker_size = {{-0.2, -0.3}, {0.2, 0.2}}
		unit_get_shooting_cursor_size = 2
		unit_get_attack_parameters =
		{
			type = "projectile",
			range = 0.5,
			cooldown = 100,
			ammo_type =
			{
				category = "biological",
				target_type = "direction",
				action =
				{
					type = "direct",
					action_delivery =
					{
						type = "instant",
						target_effects =
						{
							{
								type = "damage",
								collision_mask = {"not-colliding-with-itself"},
								damage = { amount = 13.5+1.5*i, type = "acid"}
							}
						},
						source_effects =
						{
							{
								type = "damage",
								damage = { amount = 1000, type = "self"}
							}
						}
					}
				}
			},
			sound ={filename = "__zerg__/sound/enemies/baneling-atk.wav",volume = 0.5},
			animation = unit_get_run
		}
		unit_get_movement_speed = 0.115+0.015*i
		unit_get_distance_per_frame = 0.17
		unit_get_dying_sound = {filename = "__zerg__/sound/enemies/baneling-dth.wav", volume = 0.3}
		unit_get_vision_distance  = 38+2*i
		unit_get_resistances =
		{
			{ type = "acid", percent = 100 },
			{ type = "claw", percent = 90 }
		}
		unit_get_dying_explosion = "blood-explosion-small"
		unit_get_collision_mask = {"layer-11"}
	elseif name == "sclg" then
		unit_scale = small_biter_scale
		unit_have_tint = true
		unit_get_run = biterrunanimation(unit_scale, small_biter_tint1, tint_11(i))
		unit_get_attack = biterattackanimation(unit_scale, small_biter_tint1, tint_11(i))
		unit_get_die = biterdieanimation(unit_scale, small_biter_tint1, tint_11(i))
		collision_size = {{-0.3, -0.3}, {0.3, 0.3}}
		selection_size = {{-0.3, -0.3}, {0.3, 0.3}}
		sticker_size = {{-0.3, -0.4}, {0.3, 0.1}}
		unit_get_shooting_cursor_size = 1.5
		unit_get_attack_parameters = { type = "projectile", range = 1.5, cooldown = 30, ammo_type = make_unit_melee_ammo_type(3.6+0.4*i), sound = {filename = "__zerg__/sound/enemies/zerling-atk.wav", volume = 0.5}, animation = unit_get_attack}
		unit_get_movement_speed = 0.12+0.01*i
		unit_get_distance_per_frame = 0.1
		unit_get_dying_sound = {filename = "__zerg__/sound/enemies/zerling-dth.wav", volume = 0.5}
		unit_get_vision_distance  = 29+i
		unit_get_resistances =
		{
			{ type = "acid", percent = 95 },
			{ type = "claw", percent = 90 },
			{ type = "physical", percent = 57+3*i },
			{ type = "fire", percent = -39-1*i },
			{ type = "piercing", percent = -19-1*i },
			{ type = "explosion", decrease = -2 }
		}
		unit_get_dying_explosion = "blood-explosion-small"
		unit_get_collision_mask = {"player-layer"}
	elseif name == "hdsk" then
		unit_scale = 1.3
		unit_get_run = {
			layers={
				{
					filename = "__zerg__/graphics/entity/units/hydralisk/hydralisk-run.png",
					width = 128,
					height = 128,
					frame_count = 5,
					axially_symmetrical = false,
					direction_count = 16,
					scale = unit_scale,
					animation_speed = 0.6,
				},
				{
					filename = "__zerg__/graphics/entity/units/hydralisk/hydralisk-run-mask.png",
					width = 128,
					height = 128,
					frame_count = 5,
					axially_symmetrical = false,
					direction_count = 16,
					flags = {"mask"},
					scale = unit_scale,
					tint = tint_shadow(i),
					animation_speed = 0.6,
				}
			}
		}
		unit_get_attack = {
			layers={
				{
					filename = "__zerg__/graphics/entity/units/hydralisk/hydralisk-attack.png",
					width = 128,
					height = 128,
					frame_count = 5,
					axially_symmetrical = false,
					direction_count = 16,
					scale = unit_scale,
					animation_speed = 0.6,
				},
				{
					filename = "__zerg__/graphics/entity/units/hydralisk/hydralisk-attack-mask.png",
					width = 128,
					height = 128,
					frame_count = 5,
					axially_symmetrical = false,
					direction_count = 16,
					flags = {"mask"},
					scale = unit_scale,
					tint = tint_shadow(i),
					animation_speed = 0.6,
				}
			}
		}
		unit_get_die = {
			filename = "__zerg__/graphics/entity/units/hydralisk/hydralisk-death.png",
			width = 128,
			height = 128,
			frame_count = 7,
			axially_symmetrical = false,
			direction_count = 1,
			scale = unit_scale,
			animation_speed = 0.6
		}
		collision_size = {{-0.4, -0.4}, {0.4, 0.4}}
		selection_size = {{-0.4, -0.4}, {0.4, 0.4}}
		sticker_size = {{-0.3, -0.6}, {0.3, 0.1}}
		unit_get_shooting_cursor_size = 1.5
		unit_get_attack_parameters = { type = "projectile", range = math.floor(13.5+0.5*i), cooldown = 85-5*i, warmup = 10, ammo_type = {category = "biological", target_type = "direction", action = {type = "direct", action_delivery = {type = "projectile", projectile = "hydralisk-atk", starting_speed = 1.5}}},sound = {filename = "__zerg__/sound/enemies/hydralisk-atk.wav", volume = 0.7}, animation = unit_get_attack}
		unit_get_movement_speed = 0.095+0.015*i
		unit_get_distance_per_frame = 0.17
		unit_get_dying_sound = {filename = "__zerg__/sound/enemies/hydralisk-dth.wav", volume = 0.6}
		unit_get_vision_distance  = 29+i
		unit_get_resistances =
		{
			{ type = "acid", percent = 95 },
			{ type = "claw", percent = 90 },
			{ type = "physical", percent = 29+1*i },
			{ type = "fire", percent = -19-1*i },
			{ type = "piercing", percent = 80 },
			{ type = "explosion", decrease = -2 }
		}
		unit_get_dying_explosion = "blood-explosion-big"
		unit_get_collision_mask = {"player-layer"}
	elseif name == "roch" then
		unit_scale = 1.25
		unit_get_run = {filename = "__zerg__/graphics/entity/units/roach/roach-run_01.png", width = 64, height = 64, frame_count = 11, axially_symmetrical = false, direction_count = 16, scale = unit_scale, shift = {0, -0.05}}
		unit_get_attack = {filename = "__zerg__/graphics/entity/units/roach/roach-attack_01.png",width = 64,height = 64,frame_count = 10,axially_symmetrical = false,direction_count = 16,animation_speed = 0.5,scale = unit_scale, shift = {0, -0.05}}
		unit_get_die = {filename = "__zerg__/graphics/entity/units/roach/roach-die_01.png",width = 64,height = 64,frame_count = 10,axially_symmetrical = false,direction_count = 16,scale = unit_scale, shift = {0, -0.05}}
		collision_size = {{-0.4, -0.4}, {0.4, 0.4}}
		selection_size = {{-0.4, -0.4}, {0.4, 0.4}}
		sticker_size = {{-0.35, -0.35}, {0.35, 0.35}}
		unit_get_shooting_cursor_size = 2
		unit_get_attack_parameters =
		{
			type = "stream",
			ammo_category = "biological",
			range = 15,
			min_attack_distance=12,
			projectile_creation_parameters = spitter_shoot_shiftings(0.6, 0.3),
			cooldown = 90,
			warmup = 30,
			use_shooter_direction = true,
			lead_target_for_projectile_speed = 0.2* 0.75 * 1.5 *1.5,
			ammo_type =
			{
				category = "biological",
				target_type = "direction",
				action =
				{
					type = "direct",
					action_delivery =
					{
						type = "stream",
						stream = "devourer-acid"..i,
					}
				}
			},
			sound = {filename = "__zerg__/sound/enemies/devourer-atk.wav",volume = 0.7},
			animation = unit_get_attack
		}
		unit_get_movement_speed = 0.066+0.014*i
		unit_get_distance_per_frame = 0.16
		unit_get_dying_sound = {filename = "__zerg__/sound/enemies/hydralisk-dth.wav", volume = 0.5}
		unit_get_vision_distance  = 29+i
		unit_get_resistances =
		{
			{ type = "acid", percent = 95 },
			{ type = "claw", percent = 90 },
			{ type = "physical", percent = 59+1*i },
			{ type = "fire", percent = 19+1*i },
			{ type = "piercing", -28-2*i },
			{ type = "explosion", decrease = -2 }
		}
		unit_get_dying_explosion = "blood-explosion-big"
		unit_get_collision_mask = {"player-layer"}
	elseif name == "lrkr" then
		unit_scale = 1.25
		unit_get_run = {filename = "__zerg__/graphics/entity/units/lurker/lurker-run_01.png",width = 64,height = 64,frame_count = 21,axially_symmetrical = false,direction_count = 16,scale = unit_scale}
		unit_get_attack = {width = 64,height = 64,frame_count = 12+16,axially_symmetrical = false,direction_count = 16,animation_speed = 0.26,scale = unit_scale,stripes ={{filename = "__zerg__/graphics/entity/units/lurker/lurker-attack_01.png",width_in_frames = 12,height_in_frames = 16,},{filename = "__zerg__/graphics/entity/units/lurker/lurker-attack_02.png",width_in_frames = 16,height_in_frames = 16}}}
		unit_get_die = {filename = "__zerg__/graphics/entity/units/lurker/lurker-die_01.png",width = 64,height = 64,frame_count = 14,axially_symmetrical = false,direction_count = 16,scale = unit_scale}
		collision_size = {{-0.4, -0.4}, {0.4, 0.4}}
		selection_size = {{-0.4, -0.4}, {0.4, 0.4}}
		sticker_size = {{-0.35, -0.35}, {0.35, 0.35}}
		unit_get_shooting_cursor_size = 1.7
		unit_get_attack_parameters = 
		{ 
		  type = "projectile",
		  ammo_category = "biological",
		  cooldown = 40,
		  range = math.floor(22.3+0.7*i),
		  min_attack_distance= math.floor(14.3+0.7*i),
		  warmup = 35,
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
							  damage = { amount = 9+1*i, type = "claw" }
							}
						  }
						}
					  },
					  {
					    type = "area",
						radius = 1.5,
						entity_flags = {"player-creation", "placeable-player", "placeable-neutral"},
						collision_mask = {"player-layer", "floor-layer"},
						action_delivery =
						{
						  type = "instant",
						  target_effects =
						  {
						    type = "damage",
							damage = { amount = 9+1*i, type = "claw" }
						  }
						}
					  }
					}
				  },
				  {
				    type = "damage",
					damage = {amount = 9+1*i, type = "explosion"},
				  },
				  {
				    type = "create-entity",
					entity_name = "spike" 
				  }
				}
			  }
			}
		  },
		  sound ={filename = "__zerg__/sound/enemies/lurker-atk.wav",volume = 0.6},
		  animation = unit_get_attack
		}
		unit_get_movement_speed = 0.11+0.01*i
		unit_get_distance_per_frame = 0.16
		unit_get_dying_sound = {filename = "__zerg__/sound/enemies/lurker-dth.wav", volume = 0.8}
		unit_get_vision_distance  = 29+i
		unit_get_resistances =
		{
			{ type = "acid", percent = 95 },
			{ type = "claw", percent = 90 },
			{ type = "physical", percent = 28+2*i },
			{ type = "fire", percent = 28+2*i },
			{ type = "piercing", percent = -28-2*i },
			{ type = "explosion", decrease = -2 }
		}
		unit_get_dying_explosion = "blood-explosion-big"
		unit_get_collision_mask = {"player-layer"}
	elseif name == "dvur" then
		unit_scale = 1
		unit_have_tint = true
		unit_get_run = spitterrunanimation(unit_scale,tint_11(i))
		unit_get_attack = spitterattackanimation(unit_scale,tint_11(i))
		unit_get_die = spitterdyinganimation(unit_scale,tint_11(i))
		collision_size = {{-0.4, -0.4}, {0.4, 0.4}}
		selection_size = {{-0.5, -0.5}, {0.5, 0.5}}
		sticker_size = {{-0.4, -0.7}, {0.4, 0.2}}
		unit_get_shooting_cursor_size = 2
		unit_get_attack_parameters =
		{
			type = "stream",
			ammo_category = "biological",
			range = 17,
			min_attack_distance=14,
			projectile_creation_parameters = spitter_shoot_shiftings(1, 0.5),
			cooldown = 50,
			warmup = 30,
			use_shooter_direction = true,
			lead_target_for_projectile_speed = 0.2* 0.75 * 1.5 *1.5,
			ammo_type =
			{
				category = "biological",
				target_type = "direction",
				action =
				{
					type = "direct",
					action_delivery =
					{
						type = "stream",
						stream = "devourer-acid"..i,
					}
				}
			},
			cyclic_sound =
			{
				begin_sound =
				{
					{
						filename = "__base__/sound/creatures/spitter-spit-start-1.ogg",
						volume = 0.3
					},
					{
						filename = "__base__/sound/creatures/spitter-spit-start-2.ogg",
						volume = 0.3
					},
					{
						filename = "__base__/sound/creatures/spitter-spit-start-3.ogg",
						volume = 0.3
					},
					{
						filename = "__base__/sound/creatures/spitter-spit-start-4.ogg",
						volume = 0.3
					}
				},
				middle_sound =
				{
					{
						filename = "__base__/sound/fight/flamethrower-mid.ogg",
						volume = 0
					}
				},
				end_sound =
				{
					{
						filename = "__base__/sound/creatures/spitter-spit-end-1.ogg",
						volume = 0
					}
				}
			},
			animation = unit_get_attack
		}
		unit_get_movement_speed = 0.095+0.015*i
		unit_get_distance_per_frame = 0.1
		unit_get_dying_sound = {filename = "__zerg__/sound/enemies/devourer-dth.wav", volume = 0.7}
		unit_get_vision_distance  = 29+i
		unit_get_resistances =
		{
			{ type = "acid", percent = 95 },
			{ type = "claw", percent = 90 },
			{ type = "physical", percent = 29+1*i },
			{ type = "fire", percent = -19-1*i },
			{ type = "piercing", percent = 80, },
			{ type = "explosion", decrease = -2 }
		}
		unit_get_dying_explosion = "blood-explosion-big"
		unit_get_collision_mask = {"player-layer"}
	elseif name == "utsk" then
		unit_scale = 1.7
		unit_get_run = {
			layers={
				{
					filename = "__zerg__/graphics/entity/units/ultralisk/ultralisk-run.png",
					width = 128,
					height = 128,
					frame_count = 5,
					axially_symmetrical = false,
					direction_count = 16,
					scale = unit_scale,
					animation_speed = 0.4
				},
				{
					filename = "__zerg__/graphics/entity/units/ultralisk/ultralisk-run-mask.png",
					width = 128,
					height = 128,
					frame_count = 5,
					axially_symmetrical = false,
					direction_count = 16,
					flags = {"mask"},
					scale = unit_scale,
					tint = tint_shadow(i),
					animation_speed = 0.4
				}
			}
		}
		unit_get_attack = {
			layers={
				{
					filename = "__zerg__/graphics/entity/units/ultralisk/ultralisk-attack.png",
					width = 128,
					height = 128,
					frame_count = 5,
					axially_symmetrical = false,
					direction_count = 16,
					scale = unit_scale,
					animation_speed = 0.25
				},
				{
					filename = "__zerg__/graphics/entity/units/ultralisk/ultralisk-attack-mask.png",
					width = 128,
					height = 128,
					frame_count = 5,
					axially_symmetrical = false,
					direction_count = 16,
					flags = {"mask"},
					scale = unit_scale,
					tint = tint_shadow(i),
					animation_speed = 0.25
				}
			}
		}
		unit_get_die = {
			filename = "__zerg__/graphics/entity/units/ultralisk/ultralisk-death.png",
			width = 128,
			height = 128,
			frame_count = 10,
			axially_symmetrical = false,
			direction_count = 1,
			scale = unit_scale,
			animation_speed = 0.25
		}
		collision_size = {{-0.4, -0.4}, {0.4, 0.4}}
		selection_size = {{-0.6, -0.6}, {0.6, 0.6}}
		sticker_size = {{-0.5, -0.5}, {0.5, 0.5}}
		unit_get_shooting_cursor_size = 2
		unit_get_attack_parameters = { type = "projectile", range = 1.5, cooldown = 50, ammo_type = make_unit_melee_ammo_type(27+3*i), sound = {filename = "__zerg__/sound/enemies/ultralisk-atk.wav", volume = 0.7}, animation = unit_get_attack}
		unit_get_movement_speed = 0.066+0.014*i
		unit_get_distance_per_frame = 0.15
		unit_get_dying_sound = {filename = "__zerg__/sound/enemies/ultralisk-dth.wav", volume = 0.8}
		unit_get_vision_distance  = 29+i
		unit_get_resistances =
		{
			{ type = "acid", percent = 95 },
			{ type = "claw", percent = 90 },
			{ type = "physical", percent = 65+5*i },
			{ type = "fire", percent = 49+1*i },
			{ type = "piercing", percent = -300 },
			{ type = "explosion", decrease = -2 }
		}
		unit_get_dying_explosion = "blood-explosion-big"
		unit_get_collision_mask = {"player-layer"}
	elseif name == "dflr" then
		unit_scale = 1.25
		unit_get_run = {filename = "__zerg__/graphics/entity/units/defiler/defiler-run_01.png",width = 64,height = 64,frame_count = 14,axially_symmetrical = false,direction_count = 16,scale = unit_scale,shift = { -0.08, -0.1 },animation_speed = 0.26, render_layer = "air-object"}
		unit_get_attack = unit_get_run
		unit_get_die = {filename = "__zerg__/graphics/entity/units/defiler/defiler-die.png",width = 67,height = 44,frame_count = 20,line_length = 10,axially_symmetrical = false,direction_count = 1,scale = unit_scale,shift = { -0.08, -0.1 }}
		collision_size = {{-0.4, -0.4}, {0.4, 0.4}}
		selection_size = {{-0.7, -0.7}, {0.7, 0.7}}
		sticker_size = {{-0.3, -0.5}, {0.3, 0.1}}
		unit_get_shooting_cursor_size = 2
		unit_get_attack_parameters = { type = "projectile", range = math.floor(19.2+0.8*i),cooldown = 170-10*i,ammo_category = "melee",ammo_type = defiler_attack(),animation = unit_get_attack}
		unit_get_movement_speed = 0.08+0.01*i
		unit_get_distance_per_frame = 0.17
		unit_get_dying_sound = {filename = "__zerg__/sound/enemies/defiler-dth.wav", volume = 0.8}
		unit_get_vision_distance  = 29+i
		unit_get_resistances =
		{
			{ type = "acid", percent = 95 },
			{ type = "claw", percent = 90 },
			{ type = "physical", percent = -28-2*i },
			{ type = "fire", percent = 45+5*i },
			{ type = "piercing", percent = 40 },
			{ type = "explosion", percent = -200 }
		}
		unit_get_dying_explosion = "blood-explosion-big"
		unit_get_collision_mask = {"layer-12"}
	end
end

local function buildings_data_extend(name,hp)
	local evo_count = 10
	for i = 1,evo_count do
		local health_points = hp+hp*0.9*(i-1)
		units_data_extend_stats(name,i)
		local corpse
		if corpses_on and unit_get_die then
			corpse = name.."-corpse"
			if unit_have_tint then corpse = name.."-corpse-"..i end
		end
		data:extend({
			{
				type = "unit",
				name = name..i,
				icon = "__zerg__/graphics/entity/units/icons/"..name..".png",
				icon_size = 32,
				flags = {"placeable-enemy", "placeable-off-grid", "breaths-air"},
				max_health = health_points,
				order = "x"..name..i,
				subgroup="enemies",
				shooting_cursor_size = unit_get_shooting_cursor_size,
				resistances = unit_get_resistances,
				healing_per_tick = (health_points)/(3600),
				collision_mask = unit_get_collision_mask,
				collision_box = collision_size,
				selection_box = selection_size,
				sticker_box = sticker_size,
				attack_parameters = unit_get_attack_parameters,
				vision_distance = unit_get_vision_distance,
				movement_speed = unit_get_movement_speed,
				distance_per_frame = unit_get_distance_per_frame,
				pollution_to_join_attack = 0,
				distraction_cooldown = 20,
				dying_explosion = unit_get_dying_explosion,
				dying_sound = unit_get_dying_sound,
				run_animation = unit_get_run,
				corpse = corpse,
				ai_settings = biter_ai_settings
			}
		})
		if corpses_on and unit_get_die and (i == 1 or unit_have_tint) then
			data:extend({
				{
					type = "corpse",
					name = corpse,
					icon = "__zerg__/graphics/entity/units/icons/"..name..".png",
					icon_size = 32,
					flags = {"placeable-off-grid", "building-direction-8-way", "not-on-map"},
					selection_box = selection_size,
					selectable_in_game = false,
					dying_speed = 0.04,
					time_before_removed = time_before_removed_corpse * 60 * 60,
					subgroup="corpses",
					order = "x"..name..i,
					animation = unit_get_die,
					final_render_layer = "lower-object-above-shadow"
				}
			})
		end
	end
end

data:extend({
  {
    type = "unit",
    name = "queen",
    icon = "__base__/graphics/icons/medium-biter-corpse.png",
    icon_size = 32,
    flags = {"placeable-enemy", "placeable-off-grid", "breaths-air", "not-on-map"},
    max_health = 3000,
    order = "queen",
    subgroup="enemies",
    shooting_cursor_size = 3,
    healing_per_tick = 0.02,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
    sticker_box = {{-0.5, -0.6}, {0.5, 0.5}},
    attack_parameters = { type = "projectile", range = 3, cooldown = 40, ammo_type = make_unit_melee_ammo_type(30), sound = {filename = "__zerg__/sound/enemies/ultralisk-atk.wav", volume = 0.7}, animation = queen_attack_animation(2)},
    vision_distance = 30,
    movement_speed = 0.15,
    distance_per_frame = 0.25,
    pollution_to_join_attack = 1,
    distraction_cooldown = 10,
    dying_explosion = "blood-explosion-huge",
    dying_sound =
    {
        filename = "__zerg__/sound/enemies/broodling-dth.wav",
        volume = 0.7
    },
    run_animation = queen_run_animation(2),
    corpse = "queen-corpse",
  },
  
  {
    type = "corpse",
    name = "queen-corpse",
    icon = "__base__/graphics/icons/medium-biter-corpse.png",
    icon_size = 32,
    selectable_in_game = false,
    selection_box = {{-1, -1}, {1, 1}},
    flags = {"placeable-off-grid", "building-direction-8-way", "not-on-map"},
    subgroup="corpses",
    order = "c[corpse]-a[biter]-b[medium]",
    selectable_in_game = false,
    dying_speed = 0.04,
    time_before_removed = time_before_removed_corpse * 60 * 60,
	final_render_layer = "lower-object-above-shadow",
    animation = queen_die_animation(2)
  }
})

buildings_data_extend("zrlg",20)
buildings_data_extend("bnlg",15)
buildings_data_extend("scrg",5)
buildings_data_extend("sclg",35)
buildings_data_extend("hdsk",75)
buildings_data_extend("roch",125)
buildings_data_extend("lrkr",125)
buildings_data_extend("dvur",275)
buildings_data_extend("utsk",350)
buildings_data_extend("dflr",100)
