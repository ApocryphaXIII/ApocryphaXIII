
/datum/job/vamp/bruiser
	title = "Bruiser"
	department_head = list("Baron")
	faction = "Vampire"
	total_positions = 7
	spawn_positions = 7
	supervisors = "the Baron"
	selection_color = "#434343"

	outfit = /datum/outfit/job/bruiser

	access = list(ACCESS_LAWYER, ACCESS_COURT, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_LAWYER, ACCESS_COURT, ACCESS_SEC_DOORS)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_BRUISER
	known_contacts = list("Baron","Bouncer","Emissary","Sweeper")
	allowed_species = list("Vampire", "Ghoul")
	allowed_bloodlines = CLAN_ALL //Apoc Edit
	species_slots = list("Ghoul" = 3, "Vampire" = 50)

	v_duty = "You are the enforcer of the Anarchs. The baron is always in need of muscle power. Try not to start an unnecessary war with the Camarilla." //Apoc Edit
	minimal_masquerade = 2
	experience_addition = 15

/datum/outfit/job/bruiser
	name = "Bruiser"
	jobtype = /datum/job/vamp/bruiser

	ears = /obj/item/p25radio
	id = /obj/item/card/id/bruiser
	uniform = /obj/item/clothing/under/vampire/bouncer
	suit = /obj/item/clothing/suit/vampire/jacket
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	r_pocket = /obj/item/vamp/keys/anarch
	l_pocket = /obj/item/vamp/phone/bruiser
	r_hand = /obj/item/melee/vampirearms/baseball
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1, /obj/item/vampire_stake=3, /obj/item/flashlight=1, /obj/item/vamp/keys/hack=1, /obj/item/card/credit=1)


/obj/effect/landmark/start/bruiser
	name = "Bruiser"
	icon_state = "Bouncer"

//Apoc addition start
//This is a bandaid job until the real jobenning with the remap. Remove when that happens.

/datum/job/vamp/bruiser/barkeep
	title = "Barkeep"
	department_head = list("Baron")
	total_positions = 2
	spawn_positions = 2
	allowed_species = list("Human", "Ghoul")
	display_order = JOB_DISPLAY_ORDER_BARKEEP

	v_duty = "You are a human within the Anarchs. If you aren't a ghoul you'll likely rouse suspicion if you don't have connections or protection. Keep your head down, don't rat on your community."

/datum/outfit/job/bruiser/barkeep
	name = "Barkeep"
	jobtype = /datum/job/vamp/bruiser/barkeep

	ears = /obj/item/p25radio
	id = /obj/item/card/id/bruiser/barkeep
	uniform = /obj/item/clothing/under/vampire/bouncer
	suit = /obj/item/clothing/suit/vampire/jacket
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	r_pocket = /obj/item/vamp/keys/anarch
	l_pocket = /obj/item/vamp/phone/bruiser
	r_hand = /obj/item/melee/vampirearms/baseball
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/vamp/keys/hack=1, /obj/item/card/credit=1)


/obj/effect/landmark/start/barkeep
	name = "Barkeep"
	icon_state = "Bouncer"

//Apoc addition end
