/datum/outfit/prisoner
	name = "Prison Escapee"
	uniform = /obj/item/clothing/under/rank/prisoner
	shoes = /obj/item/clothing/shoes/sneakers/orange
	r_pocket = /obj/item/kitchen/knife/shiv

/datum/outfit/prisoner/post_equip(mob/living/carbon/human/H, visualsOnly=FALSE)
	if(visualsOnly)
		return
	H.fully_replace_character_name(null,"NTP #CC-0[rand(111,999)]") //same as the lavaland prisoner transport, but this time they are from CC, or CentCom

/datum/outfit/yalp_cultist
	name = "Cultist of Yalp Elor"
	uniform = /obj/item/clothing/under/rank/civilian/chaplain
	suit = /obj/item/clothing/suit/chaplainsuit/holidaypriest
	gloves = /obj/item/clothing/gloves/color/red
	shoes = /obj/item/clothing/shoes/sneakers/black
	mask = /obj/item/clothing/mask/gas/tiki_mask/yalp_elor

/datum/outfit/waldo
	name = "Waldo"
	uniform = /obj/item/clothing/under/pants/jeans
	suit = /obj/item/clothing/suit/costume
	head = /obj/item/clothing/head/waldo
	shoes = /obj/item/clothing/shoes/sneakers/brown
	ears = /obj/item/radio/headset
	glasses = /obj/item/clothing/glasses/regular/circle


/datum/outfit/synthetic
	name = "Factory Error Synth"
	uniform = /obj/item/clothing/under/color/white
	ears = /obj/item/radio/headset

/datum/outfit/synthetic/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return
	var/obj/item/organ/eyes/robotic/glow/eyes = new()
	eyes.Insert(H, drop_if_replaced = FALSE)

/datum/outfit/spacepol
	name = "Spacepol Officer"
	uniform = /obj/item/clothing/under/rank/security/officer/spacepol
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	belt = /obj/item/gun/ballistic/automatic/pistol/m1911
	head = /obj/item/clothing/head/helmet/police
	gloves = /obj/item/clothing/gloves/tackler/combat
	shoes = /obj/item/clothing/shoes/jackboots
	mask = /obj/item/clothing/mask/gas/sechailer/swat/spacepol
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset
	l_pocket = /obj/item/ammo_box/magazine/m45
	r_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id

/datum/outfit/spacepol/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return
	var/obj/item/card/id/W = H.wear_id
	W.assignment = "Police Officer"
	W.registered_name = H.real_name
	W.update_label()

/datum/outfit/russiancorpse/hunter
	ears = /obj/item/radio/headset
	r_hand = /obj/item/gun/ballistic/rifle/boltaction/brand_new

/datum/outfit/russiancorpse/hunter/pre_equip(mob/living/carbon/human/H)
	if(prob(50))
		head = /obj/item/clothing/head/ushanka

/datum/outfit/bountyarmor
	name = "Bounty Hunter - Armored"
	uniform = /obj/item/clothing/under/rank/prisoner
	back = /obj/item/storage/backpack
	head = /obj/item/clothing/head/hunter
	suit = /obj/item/clothing/suit/space/hunter
	gloves = /obj/item/clothing/gloves/tackler/combat
	shoes = /obj/item/clothing/shoes/jackboots
	mask = /obj/item/clothing/mask/gas/hunter
	glasses = /obj/item/clothing/glasses/sunglasses/garb
	ears = /obj/item/radio/headset
	r_pocket = /obj/item/restraints/handcuffs/cable
	id = /obj/item/card/id

/datum/outfit/bountyarmor/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return
	var/obj/item/card/id/W = H.wear_id
	W.assignment = "Bounty Hunter"
	W.registered_name = H.real_name
	W.update_label()

/datum/outfit/bountyhook
	name = "Bounty Hunter - Hook"
	uniform = /obj/item/clothing/under/rank/prisoner
	back = /obj/item/storage/backpack
	head = /obj/item/clothing/head/scarecrow_hat
	gloves = /obj/item/clothing/gloves/botanic_leather
	ears = /obj/item/radio/headset
	shoes = /obj/item/clothing/shoes/jackboots
	mask = /obj/item/clothing/mask/scarecrow
	r_pocket = /obj/item/restraints/handcuffs/cable
	id = /obj/item/card/id
	r_hand = /obj/item/gun/ballistic/shotgun/doublebarrel/hook

	backpack_contents = list(
		/obj/item/ammo_casing/shotgun/incapacitate = 6
		)

/datum/outfit/bountyhook/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return
	var/obj/item/card/id/W = H.wear_id
	W.assignment = "Bounty Hunter"
	W.registered_name = H.real_name
	W.update_label()
