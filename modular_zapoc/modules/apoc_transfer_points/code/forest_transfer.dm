/obj/transfer_point_vamp/forest
	name = "forest transfer point"
	id = "forest_1"

/obj/transfer_point_vamp/forest/Initialize(mapload)
	. = ..()
	if(mapload)
		return INITIALIZE_HINT_LATELOAD

/obj/transfer_point_vamp/forest/LateInitialize()
	. = ..()
	if(src in GLOB.unallocted_transfer_points)
		qdel(src)

/obj/transfer_point_vamp/forest/two
	id = "forest_2"

/obj/transfer_point_vamp/forest/three
	id = "forest_3"

/obj/transfer_point_vamp/forest/four
	id = "forest_4"

/obj/transfer_point_vamp/forest/north // For maps that enter the forest from the south
	id = "forest_north_1"

/obj/transfer_point_vamp/forest/north/two
	id = "forest_north_2"

/obj/transfer_point_vamp/forest/north/three
	id = "forest_north_3"

/obj/transfer_point_vamp/forest/north/four
	id = "forest_north_4"

/obj/transfer_point_vamp/forest/caern
	id = "caern_1"

/obj/transfer_point_vamp/forest/caern/two
	id = "caern_2"

/obj/transfer_point_vamp/forest/caern/three
	id = "caern_3"

/obj/transfer_point_vamp/forest/caern/four
	id = "caern_4"

/obj/transfer_point_vamp/forest/pentex
	id = "pentex_logging"
