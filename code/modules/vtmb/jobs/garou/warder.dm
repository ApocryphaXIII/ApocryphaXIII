/datum/job/vamp/warder
	title = "Warder"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("Councillor")

	selection_color = "#69e430"
	faction = "Vampire"
	allowed_species = list("Werewolf")
	allowed_tribes = TRIBE_GAIA
	allowed_auspice = "Ahroun"

	minimal_renownrank = 3
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Litany and the Council" // APOC EDIT CHANGE

	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 100
	exp_type_department = EXP_TYPE_SEPT

	outfit = /datum/outfit/job/warder

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SEPT

	minimal_masquerade = 5

	known_contacts = null

	v_duty = "You are the most respected Ahroun within the Sept, granted the honor of coordinating the caern's security. The Wyrmfoe and Guardians answer to you."

/datum/outfit/job/warder
	name = "Warder"
	jobtype = /datum/job/vamp/warder

	id = /obj/item/card/id/garou/glade/warder
	uniform =  /obj/item/clothing/under/vampire/biker
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	gloves = /obj/item/clothing/gloves/vampire/work
	head = /obj/item/clothing/head/vampire/cowboy
	belt = /obj/item/storage/belt/vampire/sheathe/sabre
	suit = /obj/item/clothing/suit/vampire/vest/medieval
	glasses = /obj/item/clothing/glasses/vampire/sun
	l_pocket = /obj/item/vamp/phone
	backpack_contents = list(/obj/item/gun/ballistic/automatic/vampire/deagle=1, /obj/item/passport=1, /obj/item/masquerade_contract/veil, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/card/credit/rich=1)


	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/datum/outfit/job/warder/pre_equip(mob/living/carbon/human/H)
	..()
	if(iswerewolf(H) || isgarou(H))
		if(H.auspice.tribe.name in list(TRIBE_GLASSWALKERS, TRIBE_BONEGNAWERS, TRIBE_SHADOWLORDS, TRIBE_CHILDRENOFGAIA))
			id = /obj/item/card/id/garou/city/warder

/obj/effect/landmark/start/garou/glade/warder
	name = "Warder"
	icon_state = "Sheriff"
