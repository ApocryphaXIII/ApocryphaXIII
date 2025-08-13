/datum/job/vamp/voivode
	title = "Voivode"
	department_head = list("Eldest")
	faction = "Vampire"
	total_positions = 2 //Apoc Edit
	spawn_positions = 2 //Apoc Edits
	supervisors = " the Laws of Hospitality"
	selection_color = "#953d2d"

	outfit = /datum/outfit/job/voivode

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_VOIVODE
	exp_type_department = EXP_TYPE_VOIVODATE //Apoc Edit

	allowed_species = list("Vampire")
	allowed_bloodlines = list(CLAN_TZIMISCE, CLAN_MALKAVIAN, CLAN_TOREADOR, CLAN_OLD_TZIMISCE) //Apoc Edit
	minimal_generation = 10
//	minimum_character_age = 150 //Uncomment if age-restriction wanted
	minimum_vampire_age = 75

	v_duty = "You are a leader of the Seer's Voivodate. A congregation of Seer clans, leading the new Voivodate in the face of near systemic Collapse. Oversee the Hospitality on your lands, and guard the Sarcophagus of the Voivode-in-Waiting in Waiting kept in your basement." //Apoc Edit
	experience_addition = 20
	minimal_masquerade = 2
	known_contacts = list("Prince", "Baron", "Sheriff", "Emissary", "Seneschal", "Zadruga", "Bogatyr", "Bogatyr Captain")

/datum/outfit/job/voivode
	name = "Voivode"
	jobtype = /datum/job/vamp/voivode
	id = /obj/item/card/id/voivode
	uniform = /obj/item/clothing/under/vampire/voivode
	suit = /obj/item/clothing/suit/vampire/trench/voivode
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	l_pocket = /obj/item/vamp/phone/voivode
	backpack_contents = list(/obj/item/vamp/keys/voivodate/master=1, /obj/item/passport=1, /obj/item/flashlight=1, /obj/item/card/credit/elder=1) //Apoc Edit

/obj/effect/landmark/start/voivode
	name = "Voivode"

//Apoc Addition Start
/datum/job/vamp/voivode/after_spawn(mob/living/H, mob/M, latejoin)
	. = ..()
	var/clan_name = M.client.prefs.clan.name
	if(clan_name)
		allowed_bloodlines -= clan_name
//Apoc Addition End
