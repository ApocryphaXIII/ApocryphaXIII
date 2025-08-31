/datum/smite/isekai
	name = "isekai"

	var/spawndir
	var/spawndist
	var/quick_truck

/datum/smite/isekai/configure(client/user)
	quick_truck = (alert(user, "Skip setup?", "the crystal", "Yes", "No", "Cancel"))
	if(quick_truck == "No")
		spawndir = input(L, "Choose a direction for the truck to come from.") in list(GLOB.alldirs)
		sound_choice = (alert(user, "Play audio?", "the crystal", "Target only", "Nearby", "No"))
		abort = (alert(user, "Charge: [charge]. Sentence: [sentence_choice]. Audio: [sound_choice]. Confirm?", "the crystal", "Go", "Cancel"))
	else if(quick_truck == "Yes")
		spawndir = EAST
		spawndist = 7
		sound_choice = "Nearby"
	else if(quick_truck == "Cancel")
		abort = "Cancel"


/datum/smite/isekai/effect(client/user, mob/living/target)

get_farthest_open_chain_turf(turf/start, dir = EAST, distance = 20)
