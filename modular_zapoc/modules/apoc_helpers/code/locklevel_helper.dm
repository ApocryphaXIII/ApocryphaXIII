#define LOCKPICK_DIFFICULTY_TRIVIAL 5
#define LOCKPICK_DIFFICULTY_EASY 6
#define LOCKPICK_DIFFICULTY_MEDIUM 7
#define LOCKPICK_DIFFICULTY_HARD 8
#define LOCKPICK_DIFFICULTY_HARDER 9
#define LOCKPICK_DIFFICULTY_HARDEST 10

/obj/effect/mapping_helpers/apoc
	name = "USE A SUBTYPE"
	icon = 'modular_zapoc/modules/apoc_helpers/icons/mapping_helpers.dmi'
	icon_state = ""

/obj/effect/mapping_helpers/apoc/locklevel_helper
	name = "EASY LOCK"
	icon_state = "locklevel_trivial"
	var/lock_difficulty = LOCKPICK_DIFFICULTY_TRIVIAL


/obj/effect/mapping_helpers/apoc/locklevel_helper/easy
	name = "EASY LOCK"
	lock_difficulty = LOCKPICK_DIFFICULTY_EASY
	icon_state = "locklevel_easy"


/obj/effect/mapping_helpers/apoc/locklevel_helper/medium
	name = "MEDIUM LOCK"
	lock_difficulty = LOCKPICK_DIFFICULTY_MEDIUM
	icon_state = "locklevel_medium"


/obj/effect/mapping_helpers/apoc/locklevel_helper/hard
	name = "HARD LOCK"
	lock_difficulty = LOCKPICK_DIFFICULTY_HARD
	icon_state = "locklevel_hard"


/obj/effect/mapping_helpers/apoc/locklevel_helper/harder
	name = "HARD LOCK"
	lock_difficulty = LOCKPICK_DIFFICULTY_HARDER
	icon_state = "locklevel_harder"


/obj/effect/mapping_helpers/apoc/locklevel_helper/hardest
	name = "HARD LOCK"
	lock_difficulty = LOCKPICK_DIFFICULTY_HARDEST
	icon_state = "locklevel_hardest"
