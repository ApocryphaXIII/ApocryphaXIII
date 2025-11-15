/obj/effect/realistic_fog
	icon = 'code/modules/wod13/fog.dmi'
	MAP_SWITCH(icon_state = "fog", icon_state = "helper")
	alpha = 0
	plane = GAME_PLANE
	layer = SPACEVINE_LAYER
	anchored = TRUE
	density = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	pixel_w = -112
	pixel_z = -112
	var/min_fog_alpha = 5

/obj/effect/realistic_fog/Initialize(mapload)
	. = ..()
	animate(src, pixel_x = rand(-96, 96), pixel_y = rand(-96, 96), alpha = rand(5, 21), transform = matrix()*rand(1, 3), transform = turn(matrix(), rand(0, 360)), time = rand(100, 200), loop = -1)
	animate(transform = null, pixel_x = 0, pixel_y = 0, alpha = rand(min_fog_alpha, (min(255, min_fog_alpha*4.2))), time = rand(100, 200))

/obj/effect/realistic_fog/dense
	name = "dense fog"
	min_fog_alpha = 20

/obj/effect/realistic_fog/dense/extreme
	min_fog_alpha = 60
