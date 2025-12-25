/datum/job/vamp/guardian
	title = "Guardian"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Councillor", "Warder", "Wyrmfoe")

	selection_color = "#69e430"
	faction = "Vampire"
	allowed_species = list("Werewolf")
	allowed_tribes = TRIBE_GAIA

	total_positions = 3
	spawn_positions = 3
	supervisors = "the Litany and the Council" // APOC EDIT CHANGE

	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 50
	exp_type_department = EXP_TYPE_SEPT

	outfit = /datum/outfit/job/guardian

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SEPT

	minimal_masquerade = 3

	known_contacts = null

	v_duty = "You are the bottom of the Sept's pecking order, but also the frontline offense and defense, serving directly under the Warder and Wyrmfoe to ensure the caern's safety and well-being."

/datum/outfit/job/guardian
	name = "City Sept Guardian"
	jobtype = /datum/job/vamp/guardian

	id = /obj/item/card/id/garou/glade/guardian
	uniform =  /obj/item/clothing/under/vampire/biker
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	head = /obj/item/clothing/head/vampire/baseballcap
	belt = /obj/item/melee/classic_baton/vampire
	gloves = /obj/item/clothing/gloves/vampire/leather
	suit = /obj/item/clothing/suit/vampire/jacket
	l_pocket = /obj/item/vamp/phone
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/card/credit=1)


	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/datum/outfit/job/guardian/pre_equip(mob/living/carbon/human/H)
	..()
	if(iswerewolf(H) || isgarou(H))
		if(H.auspice.tribe.name in list(TRIBE_GLASSWALKERS, TRIBE_BONEGNAWERS, TRIBE_SHADOWLORDS, TRIBE_CHILDRENOFGAIA))
			id = /obj/item/card/id/garou/city/guardian

/obj/effect/landmark/start/garou/glade/guardian
	name = "Guardian"
	icon_state = "Hound"
