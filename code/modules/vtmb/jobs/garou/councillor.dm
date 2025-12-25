/datum/job/vamp/councillor
	title = "Councillor"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	department_head = list("the Litany")

	selection_color = "#69e430"
	faction = "Vampire"
	allowed_species = list("Werewolf")
	allowed_tribes = TRIBE_GAIA
	minimal_renownrank = 4

	total_positions = 3
	spawn_positions = 3
	supervisors = "the Litany and Yourself" // APOC EDIT CHANGE

	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 180
	exp_type_department = EXP_TYPE_SEPT

	outfit = /datum/outfit/job/councillor

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SEPT

	minimal_masquerade = 5

	known_contacts = null

	v_duty = "Veterans of the Fera Council with the highest esteem, your word within the " + SEPT_NAME + " is law. Make sure the Litany is upheld, and that your caern does not fall prey to the Wyrm."
	experience_addition = 25

/datum/outfit/job/councillor
	name = "Councillor"
	jobtype = /datum/job/vamp/councillor

	id = /obj/item/card/id/garou/glade/council
	uniform =  /obj/item/clothing/under/vampire/turtleneck_white
	suit = /obj/item/clothing/suit/vampire/coat/winter/alt
	shoes = /obj/item/clothing/shoes/vampire/jackboots/work
	l_pocket = /obj/item/vamp/phone
	backpack_contents = list(/obj/item/gun/ballistic/automatic/vampire/deagle=1, /obj/item/phone_book=1, /obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/card/credit/rich=1)


	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/datum/outfit/job/councillor/pre_equip(mob/living/carbon/human/H)
	..()
	if(iswerewolf(H) || isgarou(H))
		if(H.auspice.tribe.name in list(TRIBE_GLASSWALKERS, TRIBE_BONEGNAWERS, TRIBE_SHADOWLORDS, TRIBE_CHILDRENOFGAIA))
			id = /obj/item/card/id/garou/city/council

/obj/effect/landmark/start/garou/glade/council
	name = "Councillor"
	icon_state = "Prince"
