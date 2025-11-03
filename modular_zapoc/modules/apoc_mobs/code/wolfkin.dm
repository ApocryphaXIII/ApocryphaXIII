/mob/living/simple_animal/pet/dog/wolfkin
	name = "wolf"
	desc = "It's an actual wolf."
	icon = 'code/modules/wod13/tfn_lupus.dmi'
	icon_state = "white"
	butcher_results = list(/obj/item/food/meat/slab = 5)
	limb_destroyer = 1

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

/mob/living/simple_animal/pet/dog/wolfkin/ginger
	icon_state = "ginger"
	base_icon_state = "ginger"
	icon_dead = "ginger_rest"

/mob/living/simple_animal/pet/dog/wolfkin/gray
	icon_state = "gray"
	base_icon_state = "gray"
	icon_dead = "gray_rest"

/mob/living/simple_animal/pet/dog/wolfkin/white
	icon_state = "white"
	base_icon_state = "white"
	icon_dead = "white_rest"

/mob/living/simple_animal/pet/dog/wolfkin/brown
	icon_state = "brown"
	base_icon_state = "brown"
	icon_dead = "brown_rest"

/mob/living/simple_animal/pet/dog/wolfkin/black
	icon_state = "black"
	base_icon_state = "black"
	icon_dead = "black_rest"


/mob/living/simple_animal/pet/dog/wolfkin/random

/mob/living/simple_animal/pet/dog/wolfkin/random/Initialize()
	. = ..()
	var/coat = pick("red", "ginger", "gray", "white", "brown", "black")
	icon_state = coat
	base_icon_state = coat
	icon_dead = "[coat]_rest"
