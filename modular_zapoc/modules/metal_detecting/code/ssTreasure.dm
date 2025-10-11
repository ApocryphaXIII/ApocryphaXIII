#define TREASURE_BASE_CHANCE 1 // if(prob(TREASURE_BASE_CHANCE))
#define TREASURE_BASE_PERCENT TREASURE_BASE_CHANCE/100 // N/TREASURE_BASE_PERCENT

SUBSYSTEM_DEF(treasure)
	name = "Pirate's Booty"
	init_order = INIT_ORDER_DEFAULT
	wait = 1 MINUTES
	priority = FIRE_PRIORITY_VERYLOW

	var/list/treasure_turfs = list() // All turfs that are elligible to spawn treasure
	var/list/treasure_turfs_spawned = list() // All turfs that currently have treasure in them

/datum/controller/subsystem/treasure/Initialize()
	for(var/turf/T in world) // ALL TURFS. BURN IT ALL DOWN!!!
		if(T.can_spawn_treasure)
			treasure_turfs += T

	for(var/turf/TT in shuffle(treasure_turfs))
		if(treasure_turfs_spawned.len <= treasure_turfs.len*TREASURE_BASE_PERCENT)
			if(TT.spawn_treasure())
				TT.has_loot = TRUE
		else
			break

/datum/controller/subsystem/treasure/fire()
	if(treasure_turfs_spawned.len <= treasure_turfs.len*TREASURE_BASE_PERCENT)
		var/iterations
		for(var/turf/T in shuffle(treasure_turfs))
			iterations++
			if(T.spawn_treasure() || iterations > 100)
				T.has_loot = TRUE
				iterations = 0
				break

/turf/proc/spawn_treasure()
	if(!has_loot)
		return FALSE
	else
		var/obj/item/treasure/phat_loot = new /obj/item/treasure(loot)
		phat_loot.loot_type = loot_type
		return FALSE
