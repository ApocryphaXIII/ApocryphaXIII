/mob/living/carbon/proc/update_second_sight()
	var/datum/atom_hud/second_sight/hud = GLOB.huds[DATA_HUD_SECOND_SIGHT]
	hud.add_to_hud(src)

	var/image/holder = hud_list[SECOND_SIGHT_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.pixel_y = I.Height() - world.icon_size
	holder.icon = 'modular_zapoc/modules/imbued/icons/second_sight.dmi'
	if(!ishumanbasic(src))
		holder.icon_state = "monster"
	else
		holder.icon_state = ""

/obj/effect/the_word
	name = "The Word"

/obj/effect/the_word/Initialize(mapload)
	. = ..()
	particles = new /particles/the_word/monster

/particles/the_word
	icon = 'modular_zapoc/modules/imbued/icons/the_word_small.dmi'
	width = 32
	height = 48
	count = 10
	spawning = 0.5
	lifespan = 2 SECONDS
	fade = 2 SECONDS
	//grow = -0.025
	gravity = list(0, 0.15)
	position = generator(GEN_SPHERE, 0, 16, NORMAL_RAND)
	spin = generator(GEN_NUM, -15, 15, NORMAL_RAND)

/particles/the_word/monster
	icon_state = list("danger" = 1, "humanity" = 1)
