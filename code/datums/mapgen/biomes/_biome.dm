///This datum handles the transitioning from a turf to a specific biome, and handles spawning decorative structures and mobs.
/datum/biome
	///Type of turf this biome creates
	var/turf_type
	///Chance of having a structure from the flora types list spawn
	var/flora_density = 0
	///Chance of having a mob from the fauna types list spawn
	var/fauna_density = 0
	///list of type paths of objects that can be spawned when the turf spawns flora
	var/list/flora_types = list(/obj/structure/flora/grass/jungle)
	///list of type paths of mobs that can be spawned when the turf spawns fauna
	var/list/fauna_types = list()

///This proc handles the creation of a turf of a specific biome type
/datum/biome/proc/generate_turf(turf/gen_turf)
	gen_turf.ChangeTurf(turf_type, null, CHANGETURF_DEFER_CHANGE)
	if(length(fauna_types) && prob(fauna_density))
		var/mob/fauna = pick(fauna_types)
		new fauna(gen_turf)

	if(length(flora_types) && prob(flora_density))
		var/obj/structure/flora = pick(flora_types)
		new flora(gen_turf)

// DARKPACK EDIT CHANGE START
/datum/biome/mudlands
	turf_type = /turf/open/floor/plating/vampdirt
	flora_types = list(
		/obj/structure/small_vamprocks = 2,
		/obj/structure/vamprocks = 1,
		/obj/structure/big_vamprocks = 1,
	)
	flora_density = 3

/datum/biome/plains
	turf_type = /turf/open/floor/plating/vampgrass
	flora_types = list(
		/obj/structure/flora/ausbushes/sparsegrass = 5,
		/obj/structure/vamptree/pine = 1,
		/obj/structure/small_vamprocks = 1,
		/obj/structure/vamprocks = 1,
	)
	flora_density = 50
	fauna_types = list(
	/mob/living/simple_animal/butterfly = 2,
	/mob/living/simple_animal/deer = 2,
	/mob/living/simple_animal/pet/fox = 1,
	)
	fauna_density = 5

/datum/biome/jungle
	turf_type = /turf/open/floor/plating/vampgrass
	flora_types = list(
		/obj/structure/flora/ausbushes/sparsegrass = 1,
		/obj/structure/vamptree/pine = 2,
		/obj/structure/small_vamprocks = 1,
		/obj/structure/vamprocks = 1,
	)
	flora_density = 40
	fauna_types = list(
	/mob/living/simple_animal/butterfly = 2,
	/mob/living/simple_animal/deer = 2,
	/mob/living/simple_animal/pet/fox = 1,
	)
	fauna_density = 5

/datum/biome/jungle/deep
	flora_density = 65

/datum/biome/wasteland
	turf_type = /turf/open/floor/plating/vampdirt
	flora_types = list(
		/obj/structure/small_vamprocks = 10,
		/obj/structure/vamprocks = 2,
		/obj/structure/big_vamprocks = 1,
	)
	flora_density = 5

/datum/biome/mountain
	turf_type = /turf/closed/wall/vampwall/rock
// DARKPACK EDIT CHANGE END
