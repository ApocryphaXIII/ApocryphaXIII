SUBSYSTEM_DEF(blackout)
	name = "Blackout"
	init_order = INIT_ORDER_DEFAULT
	wait = 10 MINUTES
	priority = FIRE_PRIORITY_VERYLOW

/datum/controller/subsystem/blackout/fire()
	for(var/obj/warehouse_generator/G in GLOB.generators) // APOC EDIT START
		if(G.on)
			if(prob(5))
				G.brek()
//			G.fuel_remain = max(0, G.fuel_remain-10)
//			if(G.fuel_remain == 0)
//				G.brek() // APOC EDIT END
