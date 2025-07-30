/turf/open/floor/plating/parquetry
	icon = 'modular_zapoc/tiles.dmi'

/turf/open/floor/plating/parquetry/old

/turf/open/floor/plating/parquetry/rich

/turf/open/floor/plating/vampgrass
	icon = 'modular_zapoc/tiles.dmi'

/turf/open/floor/plating/vampcarpet
	icon = 'modular_zapoc/tiles.dmi'

/turf/open/floor/plating/vampdirt
	icon = 'modular_zapoc/tiles.dmi'

/turf/open/floor/plating/vampdirt/rails

/turf/open/floor/plating/vampplating
	icon = 'modular_zapoc/tiles.dmi'

/turf/open/floor/plating/vampplating/mono

/turf/open/floor/plating/vampplating/stone

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
