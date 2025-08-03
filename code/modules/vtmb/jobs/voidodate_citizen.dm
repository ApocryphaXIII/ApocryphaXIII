/datum/job/vamp/voivodate_citizen
	title = "Voivodate Citizen"
	department_head = list("Voivode")
	faction = "Vampire"
	total_positions = 5
	spawn_positions = 5
	supervisors = " the Laws of Hospitality"
	selection_color = "#953d2d"

	outfit = /datum/outfit/job/voivodate_citizen

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_VOIVODATE
	exp_type_department = EXP_TYPE_VOIVODATE

	allowed_species = list("Vampire", "Ghoul")
	allowed_bloodlines = list(CLAN_TZIMISCE, CLAN_MALKAVIAN, CLAN_TOREADOR, CLAN_OLD_TZIMISCE, CLAN_SALUBRI, CLAN_SALUBRI_WARRIOR)

	v_duty = "You belong to the Seer's Voivodate, a resurgance of the pre-existing California Voivodate. Above all you must respect the Hospitality, and the Voivodes."
	known_contacts = list("Voivode", "Zadruga", "Bogatyr", "Bogatyr Captain")



/datum/outfit/job/voivodate_citizen
	name = "Voivode citizen"
	jobtype = /datum/job/vamp/voivodate_citizen
	uniform = /obj/item/clothing/under/vampire/punk
	suit = /obj/item/clothing/suit/vampire/trench/voivode
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	l_pocket = /obj/item/vamp/phone/voivodate
	backpack_contents = list(/obj/item/vamp/keys/voivodate=1, /obj/item/passport=1, /obj/item/flashlight=1, /obj/item/card/credit/elder=1)

/obj/effect/landmark/start/voivode
	name = "Voivode"
