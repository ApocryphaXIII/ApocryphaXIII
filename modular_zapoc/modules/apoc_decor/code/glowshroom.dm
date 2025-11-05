/obj/structure/glowshroom/Initialize(mapload)
. = ..()
	set_light(G.glow_range(myseed), G.glow_power(myseed), G.glow_color)
