/obj/effect/realistic_fog
    icon = 'modular_darkpack/modules/weather/icons/fog.dmi'
    icon_state = "fog"
    alpha = 0
    plane = GAME_PLANE
    layer = SPACEVINE_LAYER
    anchored = TRUE
    density = FALSE
    mouse_opacity = MOUSE_OPACITY_TRANSPARENT
    pixel_w = -96
    pixel_z = -96

/obj/effect/realistic_fog/Initialize(mapload)
    . = ..()
    animate(src, pixel_x = rand(-96, 96), pixel_y = rand(-96, 96), alpha = rand(5, 21), transform = matrix()*rand(1, 3), transform = turn(matrix(), rand(0, 360)), time = rand(100, 200), loop = -1)
    animate(transform = null, pixel_x = 0, pixel_y = 0, alpha = rand(5, 21), time = rand(100, 200))
