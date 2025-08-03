/turf/open/floor/plating/parquetry
	icon = 'modular_zapoc/tiles.dmi'

/turf/open/floor/plating/parquetry/old

/turf/open/floor/plating/parquetry/rich

/turf/open/floor/plating/vampgrass
	icon = 'modular_zapoc/tiles.dmi'

/turf/open/floor/plating/vampcarpet
	icon = 'modular_zapoc/tiles.dmi'
	footstep = FOOTSTEP_CARPET
	barefootstep = FOOTSTEP_CARPET

/turf/open/floor/plating/vampdirt
	icon = 'modular_zapoc/tiles.dmi'

/turf/open/floor/plating/vampdirt/rails

/turf/open/floor/plating/vampplating
	icon = 'modular_zapoc/tiles.dmi'

/turf/open/floor/plating/vampplating/mono

/turf/open/floor/plating/vampplating/stone

//stairs!!!

/turf/open/floor/plating/vampplating/stairs
	icon_state = "stairs"

/turf/open/floor/plating/vampplating/stairs/left
	icon_state = "stairs-l"

/turf/open/floor/plating/vampplating/stairs/middle
	icon_state = "stairs-m"

/turf/open/floor/plating/vampplating/stairs/right
	icon_state = "stairs-r"

/turf/open/floor/plating/vampplating/stairs/black
	icon_state = "stairs_black"

/turf/open/floor/plating/vampplating/stairs/black/left
	icon_state = "stairs_black-l"

/turf/open/floor/plating/vampplating/stairs/black/middle
	icon_state = "stairs_black-m"

/turf/open/floor/plating/vampplating/stairs/black/right
	icon_state = "stairs_black-r"

/turf/open/floor/plating/rough
	icon = 'modular_zapoc/tiles.dmi'

/turf/open/floor/plating/stone

/turf/open/floor/plating/toilet
	icon = 'modular_zapoc/tiles.dmi'

/turf/open/floor/plating/toilet/clinic
	icon_state = "clinic1"
	base_icon_state = "clinic"

/turf/open/floor/plating/toilet/clinic/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state][rand(1, 9)]"

/turf/open/floor/plating/industrial
	icon = 'modular_zapoc/tiles.dmi'

/turf/open/floor/plating/industrial/factory
	icon_state = "factory1"
	base_icon_state = "factory"

/turf/open/floor/plating/industrial/factory/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state][rand(1, 9)]"

/turf/open/floor/plating/circled
	icon = 'modular_zapoc/tiles.dmi'

/turf/open/floor/plating/church
	icon = 'modular_zapoc/tiles.dmi'

/turf/open/floor/plating/saint
	icon = 'modular_zapoc/tiles.dmi'

/turf/open/floor/plating/vampwood
	icon = 'modular_zapoc/tiles.dmi'

/turf/open/floor/plating/bacotell
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "bacotell1"
	base_icon_state = "bacotell"

/turf/open/floor/plating/bacotell/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state][rand(1, 4)]"

/turf/open/floor/plating/gummaguts
	icon = 'modular_zapoc/tiles.dmi'
	icon_state = "gummaguts1"
	base_icon_state = "gummaguts"

/turf/open/floor/plating/gummaguts/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state][rand(1, 4)]"
