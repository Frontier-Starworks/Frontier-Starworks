//Parent types

/area/ruin
	name = "unexplored location"
	icon_state = "away"
	has_gravity = STANDARD_GRAVITY
	area_flags = HIDDEN_AREA
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	ambience_index = AMBIENCE_RUINS
	flags_1 = CAN_BE_DIRTY_1
	sound_environment = SOUND_ENVIRONMENT_STONEROOM


/area/ruin/unpowered
	always_unpowered = FALSE

/area/ruin/unpowered/no_grav
	has_gravity = FALSE

/area/ruin/powered
	requires_power = FALSE
