/datum/job/vamp/truthcatcher
	title = "Truthcatcher"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("Councillor")

	selection_color = "#69e430"
	faction = "Vampire"
	allowed_species = list("Werewolf")
	allowed_tribes = TRIBE_GAIA
	allowed_auspice = "Philodox"

	total_positions = 1
	spawn_positions = 1
	supervisors = "the Litany and the Council" // APOC EDIT CHANGE
	minimal_renownrank = 2

	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 100
	exp_type_department = EXP_TYPE_SEPT

	outfit = /datum/outfit/job/truthcatcher

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SEPT

	minimal_masquerade = 5

	known_contacts = null

	v_duty = "You are the most highly regarded Philodox within the Sept, granted the honor of being the ultimate arbitrator. It is your duty to meditate matters within the Sept. Enact your judgement upon anyone who violates the Litany."

/datum/outfit/job/truthcatcher
	name = "Truthcatcher"
	jobtype = /datum/job/vamp/truthcatcher

	id = /obj/item/card/id/garou/glade/truthcatcher
	uniform =  /obj/item/clothing/under/vampire/office
	suit = /obj/item/clothing/suit/vampire/coat/winter/alt
	gloves = /obj/item/clothing/gloves/vampire/work
	shoes = /obj/item/clothing/shoes/vampire/jackboots/work
	l_pocket = /obj/item/vamp/phone
	backpack_contents = list(/obj/item/phone_book=1, /obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/masquerade_contract/veil, /obj/item/card/credit/rich=1)


	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/datum/outfit/job/truthcatcher/pre_equip(mob/living/carbon/human/H)
	..()
	if(iswerewolf(H) || isgarou(H))
		if(H.auspice.tribe.name in list(TRIBE_GLASSWALKERS, TRIBE_BONEGNAWERS, TRIBE_SHADOWLORDS, TRIBE_CHILDRENOFGAIA))
			id = /obj/item/card/id/garou/city/truthcatcher

/obj/effect/landmark/start/garou/glade/catcher
	name = "Truthcatcher"
	icon_state = "Clerk"
