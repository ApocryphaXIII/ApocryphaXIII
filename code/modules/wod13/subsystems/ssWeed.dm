SUBSYSTEM_DEF(weed)
	name = "Weed Growth"
	init_order = INIT_ORDER_DEFAULT
	wait = 1800
	priority = FIRE_PRIORITY_VERYLOW

/datum/controller/subsystem/weed/fire()
	for(var/obj/structure/weedshit/W in GLOB.weed_list) // APOC EDIT START
		if(W.growth_stage == 0)
			W.wet = FALSE

		if(W.growth_stage && (!W.wet && prob(50))) // Unwatered weed takes roughly twice as long to grow
			W.growth_stage = max(1, W.growth_stage-1) // Cancelled out by next if()

		if(W.growth_stage && W.growth_stage < 4) // If plant exists and not fully grown
			W.growth_stage++
			if(W.wet)
				W.wet = FALSE

		else if(W.growth_stage == 4) // Fully grown
			W.weed_health--

		if(!W.weed_health) // DIE
			W.growth_stage = 5

		W.update_weed_icon() // APOC EDIT END

/*/datum/controller/subsystem/weed/fire() // APOC EDIT REMOVE START
	for(var/obj/structure/weedshit/W in GLOB.weed_list)
		if(W)
			if(W.growth_stage != 0 && W.growth_stage != 5)
				if(!W.wet)
					if(W.health)
						W.health = max(0, W.health-1)
					else
						W.growth_stage = 5
				else if(W.health)
					if(prob(33))
						W.wet = FALSE
					W.health = min(3, W.health+1)
					W.growth_stage = min(4, W.growth_stage+1)
			W.update_weed_icon()
*/ // APOC EDIT REMOVE END
