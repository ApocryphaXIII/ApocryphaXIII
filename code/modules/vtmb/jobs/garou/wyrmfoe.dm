/datum/job/vamp/wyrmfoe
	title = "Wyrmfoe"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("Councillor", "Warder")

	selection_color = "#69e430"
	faction = "Vampire"
	allowed_species = list("Werewolf")
	allowed_tribes = TRIBE_GAIA

	minimal_renownrank = 3
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Litany and the Council" // APOC EDIT CHANGE

	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 100
	exp_type_department = EXP_TYPE_SEPT

	outfit = /datum/outfit/job/wyrmfoe

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SEPT

	minimal_masquerade = 5

	known_contacts = null

	v_duty = "You are the Warder's right hand, a promising tactician in your own right, granted the honor of coordinating the Sept's more offensive actions. "

/datum/outfit/job/wyrmfoe
	name = "Wyrmfoe"
	jobtype = /datum/job/vamp/wyrmfoe

	id = /obj/item/card/id/garou/glade/keeper
	uniform =  /obj/item/clothing/under/vampire/mechanic
	suit = /obj/item/clothing/suit/vampire/labcoat
	gloves = /obj/item/clothing/gloves/vampire/work
	shoes = /obj/item/clothing/shoes/vampire/jackboots/work
	l_pocket = /obj/item/vamp/phone
	backpack_contents = list(/obj/item/phone_book=1, /obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/card/credit/rich=1)


	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/datum/outfit/job/wyrmfoe/pre_equip(mob/living/carbon/human/H)
	..()
	if(iswerewolf(H) || isgarou(H))
		if(H.auspice.tribe.name in list(TRIBE_GLASSWALKERS, TRIBE_BONEGNAWERS, TRIBE_SHADOWLORDS, TRIBE_CHILDRENOFGAIA))
			id = /obj/item/card/id/garou/city/keeper

/obj/effect/landmark/start/garou/glade/keeper
	name = "Wyrmfoe"
	icon_state = "Clerk"
