/datum/vampire_clan/ravnos
	name = CLAN_RAVNOS
	desc = "Masters of misdirection, the Ravnos prefer not to fight or bleed for something they can obtain through subtler means. They can charm and vanish within the same mortal breath, and those once fooled quickly learn to question their very senses when in the company of Ravens. Always on the move, the Ravnos can never rest in the same place for long lest their curse light them on fire as they slumber."
	curse = "Doomed to wander. Citizen of nowhere."
	clan_disciplines = list(
		/datum/discipline/animalism,
		///datum/discipline/chimerstry // Not directly translatable from tabletop, needs full design later. Ravnos use Obfuscate in V5, so this is fine for now.
		/datum/discipline/obfuscate,
		/datum/discipline/presence
	)
	male_clothes = /obj/item/clothing/under/vampire/gangrel/
	female_clothes = /obj/item/clothing/under/vampire/gothic
	clan_keys = /obj/item/vamp/keys/ravnos

/obj/item/vamp/keys/ravnos
	name = "Nomadic keys"
	accesslocks = list(
		"ravnos",
	)
	color = "#5e0a18"

/datum/vampire_clan/ravnos/post_gain(mob/living/carbon/human/H)
	..()
	var/mob/living/carbon/human/ravnos = H
	var/obj/item/passport/passport = locate() in ravnos // In pockets
	if(!passport && ravnos.back)
		passport = locate() in ravnos.back // In backpack
	if(passport && passport.owner == ravnos.real_name)
		passport.fake = TRUE
		if(ravnos.dna?.species)
			passport.owner = ravnos.dna.species.random_name(ravnos.gender, unique = TRUE)
		else
			passport.owner = random_unique_name(ravnos.gender)
