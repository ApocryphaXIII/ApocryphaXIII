/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner/eternal_winter
	name = "Eternal Winter"
	desc = "A terrifying monster that chills you to your very bones."
	health = 3000
	maxHealth = 3000
	icon_state = "eternal_winter"
	icon_living = "eternal_winter"
	icon = 'modular_zapoc/modules/apoc_mobs/icons/eternal_winter.dmi'
	attack_sound = 'sound/weapons/sonic_jackhammer.ogg'
	deathsound = 'sound/magic/demon_dies.ogg'
	light_color = COLOR_CYAN
	pixel_x = -32
	base_pixel_x = -32
	crusher_loot = list(/obj/effect/decal/remains/vomitnebula, /obj/item/resurrection_crystal)
	loot = list(/obj/structure/eternal_winter, /obj/item/resurrection_crystal/eternal_winter = 3, /obj/effect/realistic_fog/dense/extreme)
	achievement_type = /datum/award/achievement/boss/demonic_miner_kill/eternal_winter
	crusher_achievement_type = /datum/award/achievement/boss/demonic_miner_crusher/eternal_winter
	score_achievement_type = /datum/award/score/demonic_miner_score/eternal_winter
	deathmessage = "falls to the ground, decaying into... something. An undissipating cloud of frost lingers in the air."
	projectile_speed_multiplier = 2
	light_range = 20

/obj/effect/decal/remains/vomitnebula
	name = "celestial ejecta"
	desc = "It's cold to the touch. Wait, why are you touching it?"
	icon_state = "vomitnebula_1"

/obj/effect/decal/remains/vomitnebula/Initialize()
	. = ..()
	icon_state = "vomitnebula_[rand(1, 4)]"

/obj/effect/spawner/random/ice_guy
	icon = 'icons/effects/random_spawners.dmi'
	icon_state = "costume"
	loot = list(/mob/living/simple_animal/hostile/asteroid/wolf/demon, /mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow, /mob/living/simple_animal/hostile/asteroid/ice_demon, /mob/living/simple_animal/hostile/asteroid/lobstrosity)

/mob/living/simple_animal/hostile/asteroid/wolf/demon
	name = "spirit wolf"
	desc = "Not the kind of spirit you're normally fond of."
	icon = 'modular_zapoc/modules/apoc_mobs/icons/eternal_winter_adds.dmi'
	mob_biotypes = MOB_SPIRIT
	attack_sound = 'sound/hallucinations/growl1.ogg'
	loot = list(/obj/item/ectoplasm)
	is_flying_animal = TRUE
	light_system = MOVABLE_LIGHT
	light_range = 1 // same glowing as visible player ghosts
	light_power = 2
	bloodpool = 0
	maxbloodpool = 0
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	del_on_death = TRUE
	deathmessage = "lets out an ear-piercing howl, disintegrating into a pile of ectoplasm!"

/obj/structure/spawner/mining/snow_guys
	name = "hole"
	desc = "An inky black hole. Frost spills from it and chills you to the bone."
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/wolf/demon, /mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow, /mob/living/simple_animal/hostile/asteroid/lobstrosity)

/obj/structure/spawner/mining/snow_guys/difficult
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/wolf/demon, /mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow, /mob/living/simple_animal/hostile/asteroid/ice_demon, /mob/living/simple_animal/hostile/asteroid/lobstrosity, /mob/living/simple_animal/hostile/asteroid/ice_whelp/eternal_winter)

/mob/living/simple_animal/hostile/asteroid/ice_whelp/eternal_winter
	desc = "A draconic something that emits a field of cold."

/obj/item/resurrection_crystal/eternal_winter
	name = "permafrost crystal"
	desc = "You don't know what this thing is, but just holding it you feel like you have a second chance at life."
	icon = 'modular_zapoc/modules/apoc_mobs/icons/eternal_winter_items.dmi'
	onflooricon = 'modular_zapoc/modules/apoc_mobs/icons/eternal_winter_items.dmi'
	icon_state = "crystal"

/obj/item/resurrection_crystal/attack_self(mob/living/user)
	to_chat(user, span_boldwarning("You start pressing the crystal into your chest. It begins to melt."))
	if(do_after(user, 10 SECONDS, src))
		if(!iscarbon(user))
			to_chat(user, "<span class='notice'>A dark presence stops you from absorbing the crystal.</span>")
			return
		forceMove(user)
		to_chat(user, "<span class='notice'>You feel a bit safer... but some kind of presence lurks in the back of your head...</span>")
		RegisterSignal(user, COMSIG_LIVING_DEATH, PROC_REF(resurrect))
	else
		to_chat(span_warning("You decide not to play around with unknown crystals."))

/obj/structure/eternal_winter
	name = "horrid snow sculpture"
	desc = "You don't like looking at it. Impressive to look at, though."
	icon = 'modular_zapoc/modules/apoc_mobs/icons/eternal_winter.dmi'
	icon_state = "eternal_winter_crumble"
	max_integrity = 100
	anchored = TRUE
	integrity_failure = 0.01
	pixel_x = -32
	base_pixel_x = -32
	density = TRUE

/obj/structure/eternal_winter/atom_break(damage_flag)
	. = ..()
	icon_state = "crumble2"
	max_integrity = INFINITY
	anchored = FALSE
	update_integrity(max_integrity)

/obj/transfer_point_vamp/eternal_winter
	name = "lake merced transfer point"
	id = "eternal_winter_1"

/obj/transfer_point_vamp/eternal_winter/one
	id = "eternal_winter_2"

/obj/transfer_point_vamp/eternal_winter/two
	id = "eternal_winter_3"

/obj/transfer_point_vamp/eternal_winter/three
	id = "eternal_winter_4"

/obj/transfer_point_vamp/eternal_winter/four
	id = "eternal_winter_5"

/obj/transfer_point_vamp/eternal_winter/exploding/New()
	. = ..()
	var/obj/newguy = new /obj/transfer_point_vamp/eternal_winter/one(get_step(loc, EAST))
	var/obj/newguy2 = new /obj/transfer_point_vamp/eternal_winter/two(get_step(newguy.loc, EAST))
	var/obj/newguy3 = new /obj/transfer_point_vamp/eternal_winter/three(get_step(newguy2.loc, EAST))
	new /obj/transfer_point_vamp/eternal_winter/four(get_step(newguy3.loc, EAST))
