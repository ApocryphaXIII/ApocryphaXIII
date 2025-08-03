
/datum/job/vamp/bogatyr
	title = "Bogatyr"
	department_head = list("Voivode")
	faction = "Vampire"
	total_positions = 2
	spawn_positions = 2
	supervisors = " the Laws of Hospitality"
	selection_color = "#953d2d"

	outfit = /datum/outfit/job/bogatyr

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_BOGATYR
	exp_type_department = EXP_TYPE_VOIVODATE

	allowed_species = list("Vampire")
	allowed_bloodlines = list(CLAN_TZIMISCE, CLAN_MALKAVIAN, CLAN_TOREADOR, CLAN_OLD_TZIMISCE)
	minimal_generation = 13	//Uncomment when players get exp enough

	v_duty = "You bare the name of the warriors that guarded ancient Dragons, to be a Bogatyr is to serve the Voivodes and the Seer Voivodate. Protect your family and the Sarcophagus of the Voivode-in-Waiting."
	experience_addition = 15
	minimal_masquerade = 2
	known_contacts = list("Prince", "Baron", "Sheriff", "Emissary", "Seneschal", "Zadruga", "Bogatyr Captain")

/datum/outfit/job/bogatyr/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/bogatyr/female


/datum/outfit/job/bogatyr
	name = "Bogatyr"
	jobtype = /datum/job/vamp/bogatyr
	id = /obj/item/card/id/bogatyr
	uniform = /obj/item/clothing/under/vampire/bogatyr
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	l_pocket = /obj/item/vamp/phone/bogatyr
	r_pocket = /obj/item/cockclock
	backpack_contents = list(/obj/item/vamp/keys/voivodate=1, /obj/item/passport=1, /obj/item/flashlight=1, /obj/item/card/credit=1)

/obj/effect/landmark/start/bogatyr
	name = "Bogatyr"

/datum/job/vamp/bogatyr/captain
	title = "Bogatyr Captain"
	total_positions = 2
	spawn_positions = 2
	outfit = /datum/outfit/job/bogatyr/captain
	v_duty = "Captain of the Bogatyri, protectors of the Seer's Voivodate. You lead them in the protection of your family and the Voivode-in-Waiting who sleeps in the basement. Serve the Voivodes, and enforce the Hospitality on your family's lands."

	display_order = JOB_DISPLAY_ORDER_BOGATYR_CAPTAIN
	known_contacts = list("Prince", "Baron", "Sheriff", "Emissary", "Seneschal", "Zadruga", "Bogatyr")

/datum/outfit/job/bogatyr/captain
	name = "Bogatyr Captain"
	jobtype = /datum/job/vamp/bogatyr/captain
	id = /obj/item/card/id/bogatyr/captain

/obj/effect/landmark/start/bogatyr/captain
	name = "Bogatyr Captain"
