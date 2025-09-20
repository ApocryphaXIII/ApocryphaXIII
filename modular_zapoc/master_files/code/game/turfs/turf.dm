/turf
	// Metal detecting mini-game vars // modular_zapoc/modules/metal_detecting/code/treasure.dm
	var/can_spawn_treasure = FALSE // Are we detected by get_treasure_turfs()?
	var/must_dig_with_tool = TRUE // Do we need a tool to get the treasure?
	var/required_tool = TOOL_SHOVEL // If yes, what tool do we need?
	var/spawn_rarity = 0 // What tier of loot can we spawn? Refer to do_loot_rarity() in treasure.dm
	var/has_loot = 0 // Do we already have loot?
	var/loot_type = LOOT_TYPE_GENERIC // What kind of loot do we have? Check treasure_turfs.dm for valid types. Invalid types will be treated as generic.
	var/list/loot = list() // Loot storage
