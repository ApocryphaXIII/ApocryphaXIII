/turf/open/floor/plating/parquetry
	gender = PLURAL
	name = "parquetry"
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "parquet"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/parquetry/old
	icon_state = "parquet-old"

/turf/open/floor/plating/parquetry/rich
	icon_state = "parquet-rich"

/turf/open/floor/plating/vampgrass
	gender = PLURAL
	name = "grass"
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "grass1"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_TRAVA
	barefootstep = FOOTSTEP_TRAVA
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/vampgrass/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/melee/vampirearms/shovel))
		var/obj/structure/bury_pit/P = locate() in src
		if(P)
			if(!P.burying)
				P.burying = TRUE
				user.visible_message("<span class='warning'>[user] starts to dig [src]</span>", "<span class='warning'>You start to dig [src].</span>")
				if(do_mob(user, src, 10 SECONDS))
					P.burying = FALSE
					if(P.icon_state == "pit0")
						var/dead_amongst = FALSE
						for(var/mob/living/L in src)
							L.forceMove(P)
							if(L.stat == DEAD)
								dead_amongst = TRUE
						P.icon_state = "pit1"
						user.visible_message("<span class='warning'>[user] digs a hole in [src].</span>", "<span class='warning'>You dig a hole in [src].</span>")
						if(dead_amongst)
							call_dharma("respect", user)
					else
						var/dead_amongst = FALSE
						for(var/mob/living/L in P)
							L.forceMove(src)
							if(L.stat == DEAD)
								dead_amongst = TRUE
						P.icon_state = "pit0"
						user.visible_message("<span class='warning'>[user] digs a hole in [src].</span>", "<span class='warning'>You dig a hole in [src].</span>")
						if(dead_amongst)
							call_dharma("disrespect", user)
				else
					P.burying = FALSE
		else
			user.visible_message("<span class='warning'>[user] starts to dig [src]</span>", "<span class='warning'>You start to dig [src].</span>")
			if(do_mob(user, src, 10 SECONDS))
				if(!locate(/obj/structure/bury_pit) in src)
					user.visible_message("<span class='warning'>[user] digs a hole in [src].</span>", "<span class='warning'>You dig a hole in [src].</span>")
					new /obj/structure/bury_pit(src)


/turf/open/floor/plating/vampgrass/Initialize()
	..()
	set_light(1, 0.5, "#a4b7ff")
	icon_state = "grass[rand(1, 3)]"
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "snow[rand(1, 14)]"
				footstep = FOOTSTEP_SNOW
				barefootstep = FOOTSTEP_SNOW
				heavyfootstep = FOOTSTEP_SNOW

/turf/open/floor/plating/vampcarpet
	gender = PLURAL
	name = "carpet"
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "carpet_black"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/vampdirt
	gender = PLURAL
	name = "dirt"
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "dirt"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_ASPHALT
	barefootstep = FOOTSTEP_ASPHALT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/vampdirt/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/melee/vampirearms/shovel))
		var/obj/structure/bury_pit/P = locate() in src
		if(P)
			if(!P.burying)
				P.burying = TRUE
				user.visible_message("<span class='warning'>[user] starts to dig [src]</span>", "<span class='warning'>You start to dig [src].</span>")
				if(do_mob(user, src, 10 SECONDS))
					P.burying = FALSE
					if(P.icon_state == "pit0")
						var/dead_amongst = FALSE
						for(var/mob/living/L in src)
							L.forceMove(P)
							if(L.stat == DEAD)
								dead_amongst = TRUE
						P.icon_state = "pit1"
						user.visible_message("<span class='warning'>[user] digs a hole in [src].</span>", "<span class='warning'>You dig a hole in [src].</span>")
						if(dead_amongst)
							call_dharma("respect", user)
					else
						var/dead_amongst = FALSE
						for(var/mob/living/L in P)
							L.forceMove(src)
							if(L.stat == DEAD)
								dead_amongst = TRUE
						P.icon_state = "pit0"
						user.visible_message("<span class='warning'>[user] digs a hole in [src].</span>", "<span class='warning'>You dig a hole in [src].</span>")
						if(dead_amongst)
							call_dharma("disrespect", user)
				else
					P.burying = FALSE
		else
			user.visible_message("<span class='warning'>[user] starts to dig [src]</span>", "<span class='warning'>You start to dig [src].</span>")
			if(do_mob(user, src, 10 SECONDS))
				if(!locate(/obj/structure/bury_pit) in src)
					user.visible_message("<span class='warning'>[user] digs a hole in [src].</span>", "<span class='warning'>You dig a hole in [src].</span>")
					new /obj/structure/bury_pit(src)

/turf/open/floor/plating/vampdirt/Initialize()
	. = ..()
	set_light(1, 0.5, "#a4b7ff")
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "snow[rand(1, 14)]"
				footstep = FOOTSTEP_SNOW
				barefootstep = FOOTSTEP_SNOW
				heavyfootstep = FOOTSTEP_SNOW

/turf/open/floor/plating/vampdirt/rails
	name = "rails"
	icon_state = "dirt_rails"

/turf/open/floor/plating/vampdirt/rails/Initialize()
	. = ..()
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "snow_rails"
				footstep = FOOTSTEP_SNOW
				barefootstep = FOOTSTEP_SNOW
				heavyfootstep = FOOTSTEP_SNOW

/turf/open/floor/plating/vampplating
	gender = PLURAL
	name = "plating"
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "plating"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_TROTUAR
	barefootstep = FOOTSTEP_TROTUAR
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/vampplating/mono
	icon_state = "plating-mono"

/turf/open/floor/plating/vampplating/stone
	icon_state = "plating-stone"

/turf/open/floor/plating/stone
	icon_state = "stone1"

/turf/open/floor/plating/stone/Initialize()
	.=..()
	icon_state = "cave[rand(1, 7)]"

/turf/open/floor/plating/toilet
	gender = PLURAL
	name = "plating"
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "toilet1"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/toilet/Initialize()
	..()
	icon_state = "toilet[rand(1, 9)]"

/turf/open/floor/plating/toilet/clinic
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "clinic1"

/turf/open/floor/plating/toilet/clinic/Initialize()
	..()
	icon_state = "clinic[rand(1, 9)]"

/turf/open/floor/plating/industrial
	gender = PLURAL
	name = "plating"
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "industrial1"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/industrial/Initialize()
	..()
	icon_state = "industrial[rand(1, 9)]"

/turf/open/floor/plating/industrial/factory
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "factory1"

/turf/open/floor/plating/industrial/factory/Initialize()
	..()
	icon_state = "factory[rand(1, 9)]"

/turf/open/floor/plating/circled
	gender = PLURAL
	name = "fancy plating"
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "circle1"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/church
	gender = PLURAL
	name = "fancy plating"
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "church1"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/church/Initialize()
	..()
	icon_state = "church[rand(1, 4)]"

/turf/open/floor/plating/saint
	gender = PLURAL
	name = "fancy plating"
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "saint1"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/saint/Initialize()
	..()
	icon_state = "saint[rand(1, 2)]"

/turf/open/floor/plating/vampwood
	gender = PLURAL
	name = "wood"
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "bwood"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_PARKET
	barefootstep = FOOTSTEP_PARKET
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/vampwood/Initialize()
	..()
	set_light(1, 0.5, "#a4b7ff")
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "snow[rand(1, 14)]"
				footstep = FOOTSTEP_SNOW
				barefootstep = FOOTSTEP_SNOW
				heavyfootstep = FOOTSTEP_SNOW

/turf/open/floor/plating/bacotell
	gender = PLURAL
	name = "plating"
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "bacotell"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_TROTUAR
	barefootstep = FOOTSTEP_TROTUAR
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/gummaguts
	gender = PLURAL
	name = "plating"
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "gummaguts"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_TROTUAR
	barefootstep = FOOTSTEP_TROTUAR
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

//solving anime in a messy way.

/turf/open/floor/plating/Initialize()
	..()
	base_icon_state = icon_state
