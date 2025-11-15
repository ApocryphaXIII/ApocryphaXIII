/mob/living/simple_animal/pet/dog/wolfkin
	name = "wolf"
	desc = "It's an actual wolf."
	icon = 'code/modules/wod13/tfn_lupus.dmi'
	icon_state = "white"
	butcher_results = list(/obj/item/food/meat/slab = 5)
	limb_destroyer = 1
	var/random = TRUE
	var/spiral = FALSE

/mob/living/simple_animal/pet/dog/wolfkin/update_stat()
	. = ..()
	update_icons()

/mob/living/simple_animal/pet/dog/wolfkin/update_icons()
	cut_overlays()

	var/laid_down = FALSE

	if(stat == UNCONSCIOUS || IsSleeping() || stat == HARD_CRIT || stat == SOFT_CRIT || IsParalyzed() || stat == DEAD || body_position == LYING_DOWN)
		icon_state = "[base_icon_state]_rest"
		laid_down = TRUE
	else
		icon_state = "[base_icon_state]"

	switch(getFireLoss()+getBruteLoss())
		if(5 to 10)
			var/mutable_appearance/damage_overlay = mutable_appearance(icon, "damage1[laid_down ? "_rest" : ""]")
			add_overlay(damage_overlay)
		if(10 to 15)
			var/mutable_appearance/damage_overlay = mutable_appearance(icon, "damage2[laid_down ? "_rest" : ""]")
			add_overlay(damage_overlay)
		if(15 to INFINITY)
			var/mutable_appearance/damage_overlay = mutable_appearance(icon, "damage3[laid_down ? "_rest" : ""]")
			add_overlay(damage_overlay)

	var/mutable_appearance/eye_overlay = mutable_appearance(icon, "eyes[laid_down ? "_rest" : ""]")
	eye_overlay.plane = ABOVE_LIGHTING_PLANE
	eye_overlay.layer = ABOVE_LIGHTING_LAYER
	add_overlay(eye_overlay)

/mob/living/simple_animal/pet/dog/wolfkin/red
	icon_state = "red"
	base_icon_state = "red"
	icon_dead = "red_rest"
	random = FALSE

/mob/living/simple_animal/pet/dog/wolfkin/ginger
	icon_state = "ginger"
	base_icon_state = "ginger"
	icon_dead = "ginger_rest"
	random = FALSE

/mob/living/simple_animal/pet/dog/wolfkin/gray
	icon_state = "gray"
	base_icon_state = "gray"
	icon_dead = "gray_rest"
	random = FALSE

/mob/living/simple_animal/pet/dog/wolfkin/white
	icon_state = "white"
	base_icon_state = "white"
	icon_dead = "white_rest"
	random = FALSE

/mob/living/simple_animal/pet/dog/wolfkin/brown
	icon_state = "brown"
	base_icon_state = "brown"
	icon_dead = "brown_rest"
	random = FALSE

/mob/living/simple_animal/pet/dog/wolfkin/black
	icon_state = "black"
	base_icon_state = "black"
	icon_dead = "black_rest"
	random = FALSE


/mob/living/simple_animal/pet/dog/wolfkin/Initialize()
	. = ..()
	if(random)
		var/coat = pick("red", "ginger", "gray", "white", "brown", "black")
		if(!spiral)
			icon_state = coat
			base_icon_state = coat
			icon_dead = "[coat]_rest"
		else
			icon_state = "spiral[coat]"
			base_icon_state = "spiral[coat]"
			icon_dead = "spiral[coat]_rest"

/mob/living/simple_animal/pet/dog/wolfkin/spiral
	spiral = TRUE

/mob/living/simple_animal/pet/dog/wolfkin/spiral/red
	icon_state = "spiralred"
	base_icon_state = "spiralred"
	icon_dead = "spiralred_rest"

/mob/living/simple_animal/pet/dog/wolfkin/spiral/ginger
	icon_state = "spiralginger"
	base_icon_state = "ginger"
	icon_dead = "spiralginger_rest"

/mob/living/simple_animal/pet/dog/wolfkin/spiral/gray
	icon_state = "spiralgray"
	base_icon_state = "gspiralray"
	icon_dead = "spiralgray_rest"

/mob/living/simple_animal/pet/dog/wolfkin/spiral/white
	icon_state = "spiralwhite"
	base_icon_state = "spiralwhite"
	icon_dead = "spiralwhite_rest"

/mob/living/simple_animal/pet/dog/wolfkin/spiral/brown
	icon_state = "spiralbrown"
	base_icon_state = "spiralbrown"
	icon_dead = "spiralbrown_rest"

/mob/living/simple_animal/pet/dog/wolfkin/spiral/black
	icon_state = "spiralblack"
	base_icon_state = "spiralblack"
	icon_dead = "spiralblack_rest"

/mob/living/simple_animal/pet/dog/wolfkin/spiral
	name = "rotten wolf"
	desc = "It's a horrifying rotting wolf."
	spiral = TRUE
