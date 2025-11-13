/datum/effect_system/smoke_spread/gray_masses
	effect_type = /obj/effect/particle_effect/smoke/gray_masses


/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/death()
	var/datum/effect_system/smoke_spread/gray_masses/s = new /datum/effect_system/smoke_spread/gray_masses
	s.set_up(1, get_turf(src))
	s.start()
	. = ..()


/obj/effect/particle_effect/smoke/gray_masses
	name = "spore cloud"
	icon = 'code/modules/wod13/fog.dmi'
	icon_state = "fog"
	pixel_x = -112
	pixel_y = -112
	opacity = FALSE
	alpha = 64
	color = "#B9BB93"
	layer = FLY_LAYER
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	animate_movement = FALSE
	lifetime = 4
	opaque = 1 //whether the smoke can block the view when in enough amount
	var/min_fog_alpha = 15


/obj/effect/particle_effect/smoke/gray_masses/Initialize(mapload)
	. = ..()
	playsound(src, 'modular_zapoc/modules/apoc_mobs/sounds/spore_poof.ogg', 50)
	animate(src, pixel_x = rand(-96, 96), pixel_y = rand(-96, 96), alpha = rand(5, 21), transform = matrix()*rand(1, 3), transform = turn(matrix(), rand(0, 360)), time = rand(100, 200), loop = -1)
	animate(transform = null, pixel_x = 0, pixel_y = 0, alpha = rand(min_fog_alpha, (min(255, min_fog_alpha*4.2))), time = rand(100, 200))

/obj/effect/particle_effect/smoke/gray_masses/smoke_mob(mob/living/carbon/M)
	if(..())
		M.apply_damage(10, OXY)
		M.apply_damage(10, STAMINA)
		to_chat(M, span_userdanger("The spores fill your lungs!"))

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!istype(H.wear_suit, /obj/item/clothing/suit/hooded/heisenberg))
			H.apply_damage(5, BURN)
			to_chat(H, span_userdanger("The spores burn you!"))
	else
		M.apply_damage(5, BURN)
		to_chat(M, span_userdanger("The spores burn you!"))

		if(prob(50))
			M.emote("scream")
		else
			M.emote("whimper")

		return 1

/obj/effect/particle_effect/smoke/gray_masses/Destroy()
	if(prob(25))
		new /obj/effect/decal/cleanable/ash/gray_masses(get_turf(src))
	. = ..()


/obj/effect/decal/cleanable/ash/gray_masses
	name = "pile of spores"
	desc = "Shrooms, anyone?"
	alpha = 1


/obj/effect/decal/cleanable/ash/gray_masses/Initialize()
	. = ..()
	animate(src, alpha = 255, time = 2 SECONDS, loop = 0)
