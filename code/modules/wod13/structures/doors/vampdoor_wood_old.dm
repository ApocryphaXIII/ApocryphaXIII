/obj/structure/vampdoor/wood/old
	icon_state = "oldwood-1"
	baseicon = "oldwood"

/obj/structure/vampdoor/wood/old/chantry
	lock_id = "chantry"
	lockpick_difficulty = 12
	locked = TRUE

//Change type to of objects below to be a child of wood/old post mapping freeze:
/obj/structure/vampdoor/baali
	icon_state = "oldwood-1"
	baseicon = "oldwood"
	locked = TRUE
	lock_id = "baali"
	burnable = FALSE
	lockpick_difficulty = 8

/obj/structure/vampdoor/salubri
	icon_state = "oldwood-1"
	baseicon = "oldwood"
	locked = TRUE
	lock_id = "salubri"
	burnable = FALSE
	lockpick_difficulty = 8

/obj/structure/vampdoor/old_clan_tzimisce
	icon_state = "oldwood-1"
	baseicon = "oldwood"
	locked = TRUE
	lock_id = "old_clan_tzimisce"
	burnable = FALSE
	lockpick_difficulty = 8

//Apoc Addition Start
/obj/structure/vampdoor/wood/old/voivodate
	lock_id = "seer_voivodate"
	locked = TRUE
	lockpick_difficulty = 8

/obj/structure/vampdoor/wood/old/voivodate/unlocked
	locked = FALSE

/obj/structure/vampdoor/wood/old/voivodate_citizen
	lock_id = "voivodate_citizen"
	locked = TRUE
	lockpick_difficulty = 6

/obj/structure/vampdoor/wood/old/voivodate_citizen/unlocked
	locked = FALSE
//Apoc Addition End
