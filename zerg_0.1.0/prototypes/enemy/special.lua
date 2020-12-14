
local function larva_egg_die_animation(scale)
  return
  {
    layers=
    {
      {
        width = 39,
        height = 30,
        frame_count = 1,
        axially_symmetrical = false,
        direction_count = 1,
		animation_speed = 0.7,
        shift = {0, 0},
        scale = scale,
        stripes =
        {
          {
            filename = "__zerg__/graphics/entity/units/larva/egg-die.png",
            width_in_frames = 1,
            height_in_frames = 1,
          },

        }
      },

    }
  }
end

local abomb_animation =
{
  width = 16,
  height = 18,
  frame_count = 33,
  line_length = 5,
  axially_symmetrical = false,
  direction_count = 1,
  scale = 2,
  animation_speed = 0.26,
  filename = "__zerg__/graphics/entity/acid-projectile-purple/acid-projectile-purple.png",
  render_layer = "air-object"
}

data:extend({
  {
    type = "unit",
    name = "abomb",
    icon = "__zerg__/graphics/entity/units/icons/zrlg.png",
    icon_size = 32,
    flags = {"placeable-enemy", "placeable-off-grid", "breaths-air", "not-on-map"},
    max_health = 1,
    order = "x".."name",
    subgroup="enemies",
    shooting_cursor_size = 2,
    collision_mask = {"layer-12"},
    attack_parameters = 
	{
		type = "projectile",
		range = 0.5,
		cooldown = 15,
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
		animation = abomb_animation
	},
    vision_distance = 30,
    movement_speed = 0.2,
    distance_per_frame = 0.1,
    pollution_to_join_attack = 0,
    distraction_cooldown = 20,
    dying_explosion = "blood-explosion-big",
    run_animation = abomb_animation
  },
  
  {
    type = "turret",
    name = "egg",
    icon = "__base__/graphics/icons/small-worm.png",
    icon_size = 32,
    flags = {"placeable-enemy", "placeable-off-grid", "breaths-air", "not-on-map"},
    subgroup = "enemies",
    order="b-a",
    max_health = 100,
    healing_per_tick = 0.1,
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.7, -0.5}, {0.5, 0.5}},
    shooting_cursor_size = 1,
    dying_explosion = "blood-explosion-big",
    corpse = "egg-corpse",
    folded_speed = 0.03,
    folded_animation =
    {
      layers=
      {
        {
          filename = "__zerg__/graphics/entity/units/larva/baneling-egg-idle_01.png",
          width = 48,
          height = 47,
          frame_count = 18,
          direction_count = 1,
          axially_symmetrical = false,
          shift = { 0, -0.1 },
          animation_speed = 0.1,
        }
      }
    },
    attack_parameters = {type = "projectile", range = 0, cooldown = 999, ammo_type = {category = "biological"}},
    call_for_help_radius = 0
  },
  
  {
    type = "corpse",
    name = "egg-corpse",
    icon = "__base__/graphics/icons/medium-biter-corpse.png",
    icon_size = 32,
    selectable_in_game = false,
    selection_box = {{-1, -1}, {1, 1}},
    flags = {"placeable-off-grid", "building-direction-8-way"},
    subgroup="corpses",
    order = "c[corpse]-a[biter]-b[medium]",
    dying_speed = 0.02,
    final_render_layer = "corpse",
    animation = larva_egg_die_animation(1)
  },
  
  {
    type = "simple-entity",
	name = "check-place",
    collision_box = {{-6, -6}, {6, 6}},
    render_layer = "object",
    picture = { filename = "__core__/graphics/empty.png", width = 1, height = 1 }
  },
  {
    type = "simple-entity",
	name = "check-place2",
    collision_box = {{-10, -10}, {10, 10}},
    render_layer = "object",
    picture = { filename = "__core__/graphics/empty.png", width = 1, height = 1 }
  },

  {
    type = "explosion",
    name = "base-check",
    flags = {"not-on-map"},
    animations =
	{
      {
        filename = "__core__/graphics/empty.png",
        frame_count = 1,
        width = 1,
        height = 1
	  }
    }
  },

  {
    type = "explosion",
    name = "event-detonator",
    flags = {"not-on-map"},
    animations =
	{
      {
        filename = "__core__/graphics/empty.png",
        frame_count = 1,
        width = 1,
        height = 1
	  }
    }
  },

  {
    type = "explosion",
    name = "event-explosion-cancel",
    flags = {"not-on-map"},
    animations =
	{
      {
        filename = "__zerg__/graphics/entity/light-alarm.png",
        frame_count = 32,
        line_length = 16,
        width = 75,
        height = 75,
        priority = "high",
		shift = {0.1, 1.1},
        animation_speed = 1
	  }
    },
	sound = {{ filename = "__zerg__/sound/exp-cancel.wav", volume = 0.6 }}
  },

  {
    type = "explosion",
    name = "base-scream",
    flags = {"not-on-map"},
    animations =
	{
      {
        filename = "__core__/graphics/empty.png",
        frame_count = 1,
        width = 1,
        height = 1
	  }
    },
	sound =
    {
      { filename = "__zerg__/sound/enemies/base-1.wav", volume = 1 },
      { filename = "__zerg__/sound/enemies/base-2.wav", volume = 1 },
      { filename = "__zerg__/sound/enemies/base-3.wav", volume = 1 },
      { filename = "__zerg__/sound/enemies/base-4.wav", volume = 1 },
      { filename = "__zerg__/sound/enemies/base-5.wav", volume = 1 },
      { filename = "__zerg__/sound/enemies/base-6.wav", volume = 1 },
    },
    max_sounds_per_type = 1
  },
  
  {
    type = "explosion",
    name = "spike",
    flags = {"not-on-map"},
    animations =
    {
      {
        filename = "__zerg__/graphics/entity/enemy-base/spike.png",
        priority = "extra-high",
        width = 26,
        height = 36,
		scale = 1,
        frame_count = 11,
		shift = {0, 0.5},
        animation_speed = 0.27
      },
	  {
        filename = "__zerg__/graphics/entity/enemy-base/spike.png",
        priority = "extra-high",
        width = 26,
        height = 36,
		scale = 1.1,
        frame_count = 11,
		shift = {0, 0.5},
        animation_speed = 0.27
      },
	  {
        filename = "__zerg__/graphics/entity/enemy-base/spike.png",
        priority = "extra-high",
        width = 26,
        height = 36,
		scale = 1.2,
        frame_count = 11,
		shift = {0, 0.5},
        animation_speed = 0.27
      },
	  {
        filename = "__zerg__/graphics/entity/enemy-base/spike.png",
        priority = "extra-high",
        width = 26,
        height = 36,
		scale = 1.3,
        frame_count = 11,
		shift = {0, 0.5},
        animation_speed = 0.27
      },
	  {
        filename = "__zerg__/graphics/entity/enemy-base/spike.png",
        priority = "extra-high",
        width = 26,
        height = 36,
		scale = 1.4,
        frame_count = 11,
		shift = {0, 0.5},
        animation_speed = 0.27
      },
	  {
        filename = "__zerg__/graphics/entity/enemy-base/spike.png",
        priority = "extra-high",
        width = 26,
        height = 36,
		scale = 1.5,
        frame_count = 11,
		shift = {0, 0.5},
        animation_speed = 0.27
      },
	  {
        filename = "__zerg__/graphics/entity/enemy-base/spike.png",
        priority = "extra-high",
        width = 26,
        height = 36,
		scale = 1.6,
        frame_count = 11,
		shift = {0, 0.5},
        animation_speed = 0.27
      },
	  {
        filename = "__zerg__/graphics/entity/enemy-base/spike.png",
        priority = "extra-high",
        width = 26,
        height = 36,
		scale = 1.7,
        frame_count = 11,
		shift = {0, 0.5},
        animation_speed = 0.27
      },
	  {
        filename = "__zerg__/graphics/entity/enemy-base/spike.png",
        priority = "extra-high",
        width = 26,
        height = 36,
		scale = 1.8,
        frame_count = 11,
		shift = {0, 0.5},
        animation_speed = 0.27
      },
	  {
        filename = "__zerg__/graphics/entity/enemy-base/spike.png",
        priority = "extra-high",
        width = 26,
        height = 36,
		scale = 1.9,
        frame_count = 11,
		shift = {0, 0.5},
        animation_speed = 0.27
      },
	  {
        filename = "__zerg__/graphics/entity/enemy-base/spike.png",
        priority = "extra-high",
        width = 26,
        height = 36,
		scale = 2,
        frame_count = 11,
		shift = {0, 0.5},
        animation_speed = 0.27
      },
    },
	sound =
    {
      {
        filename = "__zerg__/sound/enemies/spike.wav",
        volume = 0.6
      }
    }
  },
  {
    type = "explosion",
    name = "acid-splash",
    flags = {"not-on-map"},
	animations =
    {
      {
        filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
        priority = "extra-high",
        width = 64,
        height = 64,
		scale = 3.2,
		tint = {r=0, g=0.6, b=0, a=1},
        frame_count = 64,
        line_length = 8,
		animation_speed = 0.7,
      },
	  {
        filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
        priority = "extra-high",
        width = 64,
        height = 64,
		scale = 3.4,
		tint = {r=0.15, g=0.7, b=0, a=1},
        frame_count = 64,
        line_length = 8,
		animation_speed = 0.7,
      },
	  {
        filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
        priority = "extra-high",
        width = 64,
        height = 64,
		scale = 3.6,
		tint = {r=0.3, g=0.8, b=0, a=1},
        frame_count = 64,
        line_length = 8,
		animation_speed = 0.7,
      },
	  {
        filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
        priority = "extra-high",
        width = 64,
        height = 64,
		scale = 3.8,
		tint = {r=0.45, g=0.9, b=0, a=1},
        frame_count = 64,
        line_length = 8,
		animation_speed = 0.7,
      },
	  {
        filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
        priority = "extra-high",
        width = 64,
        height = 64,
		scale = 4,
		tint = {r=0.6, g=1, b=0, a=1},
        frame_count = 64,
        line_length = 8,
		animation_speed = 1,
      },
    },
  },
  
  {
    type = "projectile",
    name = "defiler-atk",
    flags = {"not-on-map"},
    acceleration = 0.1,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "defiler-trigger",
            trigger_created_entity="true"
          },
        }
      }
    },
    animation =
    {
      filename = "__zerg__/graphics/entity/empty.png",
      frame_count = 1,
      width = 1,
      height = 1,
      priority = "low"
    },
  },

  {
    type = "explosion",
    name = "defiler-trigger",
    flags = {"not-on-map"},
    animations =
	{
      {
        filename = "__core__/graphics/empty.png",
        frame_count = 1,
        width = 1,
        height = 1,
	  }
    }
  },
  
  {
    type = "explosion",
    name = "acid-splash-scourge",
    flags = {"not-on-map"},
	animations =
    {
      {
        filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
        priority = "extra-high",
        width = 64,
        height = 64,
		scale = 1.4,
		tint = {r=0, g=0.6, b=0.6, a=1},
        frame_count = 64,
        line_length = 8,
		animation_speed = 0.7,
      },
	  {
        filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
        priority = "extra-high",
        width = 64,
        height = 64,
		scale = 1.6,
		tint = {r=0, g=0.7, b=0.5, a=1},
        frame_count = 64,
        line_length = 8,
		animation_speed = 0.7,
      },
	  {
        filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
        priority = "extra-high",
        width = 64,
        height = 64,
		scale = 1.8,
		tint = {r=0.3, g=0.8, b=0.4, a=1},
        frame_count = 64,
        line_length = 8,
		animation_speed = 0.7,
      },
	  {
        filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
        priority = "extra-high",
        width = 64,
        height = 64,
		scale = 2,
		tint = {r=0, g=0.9, b=0.3, a=1},
        frame_count = 64,
        line_length = 8,
		animation_speed = 0.7,
      },
	  {
        filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
        priority = "extra-high",
        width = 64,
        height = 64,
		scale = 2.2,
		tint = {r=0, g=1, b=0.2, a=1},
        frame_count = 64,
        line_length = 8,
		animation_speed = 1,
      },
    },
  },
  {
    type = "explosion",
    name = "devourer-acid-explosion",
    flags = {"not-on-map"},
    animations =
    {
      {
        filename = "__zerg__/graphics/entity/units/devourer/devourer-acid-explosion.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        frame_count = 14,
        shift = {-0.1, 0.7 },
        animation_speed = 0.5
      }
    }
  },
  
  {
    type = "projectile",
    name = "hydralisk-atk",
    flags = {"not-on-map"},
    acceleration = 0.005,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "acid-explosion-small"
          },
          {
            type = "damage",
            damage = {amount = 20, type = "acid"}
          }
        }
      }
    },
    animation =
    {
      filename = "__zerg__/graphics/entity/units/hydralisk/hydralisk-pr.png",
      frame_count = 1,
      width = 21,
      height = 49,
      priority = "high"
    }
  },

  {
    type = "explosion",
    name = "acid-explosion-small",
    flags = {"not-on-map"},
    animations =
    {
      {
        filename = "__zerg__/graphics/entity/units/hydralisk/acid-explosion-small.png",
        priority = "extra-high",
        width = 31,
        height = 32,
        line_length = 8,
        frame_count = 8,
        animation_speed = 0.2
      }
    }
  },
})

local evo_count = 10
for i = 1,evo_count do
data:extend({
  {
    type = "explosion",
    name = "baneling-boom-explosion"..i,
    flags = {"not-on-map"},
    acceleration = 0.005,
    created_effect =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "acid-explosion-huge"
          },
		  {
            type = "create-entity",
            entity_name = "acid-splash"
          },
          {
            type = "nested-result",
            action =
            {
				{
				type = "area",
				radius = 2,
                entity_flags = {"player-creation", "placeable-player", "placeable-neutral"},
				action_delivery = { type = "instant", target_effects = { type = "damage", damage = { amount = 27+3*i, type = "acid" }}}
				},
				{
				type = "area",
				radius = 2,
                entity_flags = {"placeable-enemy"},
				action_delivery = { type = "instant", target_effects = { type = "damage", damage = { amount = -270-30*i, type = "self" }}}
				},
				{
				type = "area",
				radius = 4,
                entity_flags = {"player-creation", "placeable-player", "placeable-neutral"},
				collision_mask = {"player-layer", "floor-layer"},
				action_delivery = { type = "instant", target_effects = { type = "damage", damage = { amount = 18+2*i, type = "acid" }}}
				},
				{
				type = "area",
				radius = 4,
                entity_flags = {"placeable-enemy"},
				action_delivery = { type = "instant", target_effects = { type = "damage", damage = { amount = -180-20*i, type = "self" }}}
				},
				{
				type = "area",
				radius = 6,
                entity_flags = {"player-creation", "placeable-player", "placeable-neutral"},
				collision_mask = {"player-layer", "floor-layer"},
				action_delivery = { type = "instant", target_effects = { type = "damage", damage = { amount = 9+1*i, type = "acid" }}}
				},
				{
				type = "area",
				radius = 6,
                entity_flags = {"placeable-enemy"},
				action_delivery = { type = "instant", target_effects = { type = "damage", damage = { amount = -90-10*i, type = "self" }}}
				}
            }
          }
        }
      }
    },
    light = {intensity = 0.5, size = 5},
    animations =
    {{
      filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
      frame_count = 1,
      width = 1,
      height = 1,
      priority = "low"
    }}
  },
  
  {
    type = "explosion",
    name = "scourge-boom-explosion"..i,
    flags = {"not-on-map"},
    acceleration = 0.005,
    created_effect =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "blood-explosion-small"
          },
		  {
            type = "create-entity",
            entity_name = "acid-splash-scourge"
          },
          {
            type = "nested-result",
            action =
            {
				{
				type = "area",
				radius = 2,
                entity_flags = {"player-creation", "placeable-player", "placeable-neutral"},
				collision_mask = {"player-layer", "floor-layer"},
				action_delivery = { type = "instant", target_effects = { type = "damage", damage = { amount = 9+1*i, type = "acid" }}}
				},
				{
				type = "area",
				radius = 2,
                entity_flags = {"placeable-enemy"},
				action_delivery = { type = "instant", target_effects = { type = "damage", damage = { amount = -90-10*i, type = "self" }}}
				},
				{
				type = "area",
				radius = 3,
                entity_flags = {"player-creation", "placeable-player", "placeable-neutral"},
				collision_mask = {"player-layer", "floor-layer"},
				action_delivery = { type = "instant", target_effects = { type = "damage", damage = { amount = 4.5+0.5*i, type = "acid" }}}
				},
				{
				type = "area",
				radius = 3,
                entity_flags = {"placeable-enemy"},
				action_delivery = { type = "instant", target_effects = { type = "damage", damage = { amount = -45-5*i, type = "self" }}}
				},
            },
          }
        }
      }
    },
    light = {intensity = 0.5, size = 3},
    animations =
    {{
      filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
      frame_count = 1,
      width = 1,
      height = 1,
      priority = "low"
    }}
  },
  
  {
    type = "stream",
    name = "devourer-acid"..i,
    flags = {"not-on-map"},
    particle_buffer_size = 90,
    particle_spawn_interval = 1,
    particle_spawn_timeout = 6,
    particle_vertical_acceleration = 0.005 * 0.60 *1.5, --x
    particle_horizontal_speed = 0.2* 0.75 * 1.5 * 1.5, --x
    particle_horizontal_speed_deviation = 0.005 * 0.70,
    particle_start_alpha = 0.5,
    particle_end_alpha = 1,
    particle_alpha_per_part = 0.8,
    particle_scale_per_part = 0.8,
    particle_loop_frame_count = 15,
    --particle_fade_out_threshold = 0.95,
    particle_fade_out_duration = 2,
    particle_loop_exit_threshold = 0.25,
    initial_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
		  {
            type = "create-entity",
            entity_name = "devourer-acid-explosion"
          },
          {
			type = "damage",
			collision_mask = {"not-colliding-with-itself"},
			damage = { amount = 13.5+1.5*i, type = "acid"}
          },
          {
            type = "nested-result",
            action =
            {
              {
                type = "area",
                radius = 2,
                entity_flags = {"player-creation", "placeable-player", "placeable-neutral"},
				collision_mask = {"player-layer", "floor-layer"},
                action_delivery = { type = "instant", target_effects = { type = "damage", damage = { amount = 9+1*i, type = "acid" }}}
              },
              {
                type = "area",
                radius = 2,
                entity_flags = {"placeable-enemy"},
                action_delivery = { type = "instant", target_effects = { type = "damage", damage = { amount = -90-10*i, type = "self" }}}
              },
              {
                type = "area",
                radius = 3,
                entity_flags = {"player-creation", "placeable-player", "placeable-neutral"},
				collision_mask = {"player-layer", "floor-layer"},
                action_delivery = { type = "instant", target_effects = { type = "damage", damage = { amount = 9+1*i, type = "acid" }}}
              },
              {
                type = "area",
                radius = 3,
                entity_flags = {"placeable-enemy"},
                action_delivery = { type = "instant", target_effects = { type = "damage", damage = { amount = -90-10*i, type = "self" }}}
              },
            },
          }
        }
      }
    },
    particle = {
      filename = "__base__/graphics/entity/acid-projectile/acid-projectile-head.png",
      line_length = 5,
      width = 22,
      height = 84,
      frame_count = 15,
      shift = util.mul_shift(util.by_pixel(-2, 30), 1),
      tint = {r=0, g=1, b=0.2, a=1},
      priority = "high",
      scale = 0.5,
      animation_speed = 1,
      hr_version =
      {
        filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-head.png",
        line_length = 5,
        width = 42,
        height = 164,
        frame_count = 15,
        shift = util.mul_shift(util.by_pixel(-2, 31), 1),
        tint = {r=0, g=1, b=0.2, a=1},
        priority = "high",
        scale = 0.5 * 0.5,
        animation_speed = 1,
      }
    },
    spine_animation = {
      filename = "__base__/graphics/entity/acid-projectile/acid-projectile-tail.png",
      line_length = 5,
      width = 66,
      height = 12,
      frame_count = 15,
      shift = util.mul_shift(util.by_pixel(0, -2), 1),
      tint = {r=0, g=1, b=0.2, a=1},
      priority = "high",
      scale = 0.5,
      animation_speed = 1,
      hr_version =
      {
        filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-tail.png",
        line_length = 5,
        width = 132,
        height = 20,
        frame_count = 15,
        shift = util.mul_shift(util.by_pixel(0, -1), 1),
        tint = {r=0, g=1, b=0.2, a=1},
        priority = "high",
        scale = 0.5 * 0.5,
        animation_speed = 1,
      }
    },
    shadow = {
      filename = "__base__/graphics/entity/acid-projectile/acid-projectile-shadow.png",
      line_length = 15,
      width = 22,
      height = 84,
      frame_count = 15,
      priority = "high",
      shift = util.mul_shift(util.by_pixel(-2, 30), 1),
      draw_as_shadow = true,
      scale = 0.5,
      animation_speed = 1,
      hr_version =
      {
        filename = "__base__/graphics/entity/acid-projectile/hr-acid-projectile-shadow.png",
        line_length = 15,
        width = 42,
        height = 164,
        frame_count = 15,
        shift = util.mul_shift(util.by_pixel(-2, 31), 1),
        draw_as_shadow = true,
        priority = "high",
        scale = 0.5 * 0.5,
        animation_speed = 1,
      }
    },

    oriented_particle = true,
    shadow_scale_enabled = true,
  }
})
end