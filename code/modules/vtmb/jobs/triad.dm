
/datum/job/vamp/triad_soldier
	title = "Ocean 76er"
	department_head = list("Ocean 76 gang bosses")
	faction = "Vampire"
	total_positions = 8
	spawn_positions = 8
	supervisors = "the Arch"
	selection_color = "#bb9d3d"

	outfit = /datum/outfit/job/triad_soldier

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_TRIAD_GANGSTER
	exp_type_department = EXP_TYPE_GANG

	allowed_species = list("Human", "Werewolf", "Kuei-Jin")
	minimal_generation = 13

	v_duty = "This city should belong to those who live in it. Your family in the 76 got your back, you should have theirs."
	experience_addition = 10
	minimal_masquerade = 0

/datum/outfit/job/triad_soldier/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/suit/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/datum/outfit/job/triad_soldier
	name = "Ocean 76er"
	jobtype = /datum/job/vamp/triad_soldier
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/cockclock
	l_pocket = /obj/item/vamp/phone/triads_soldier
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/triads
	backpack_contents = list(/obj/item/passport=1, /obj/item/card/credit=1, /obj/item/clothing/mask/vampire/balaclava =1, /obj/item/gun/ballistic/automatic/vampire/beretta=2,/obj/item/ammo_box/magazine/semi9mm=2, /obj/item/melee/vampirearms/knife)
