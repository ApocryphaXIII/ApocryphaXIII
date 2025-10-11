/obj/item/treasure
	name = "treasure"
	var/revealed_name = "treasure but revealed"
	icon_state = "skub"
	desc = "Yarrrrr. If ye' be seein' this, anchor yerself at port an' fill th' ears of a code monkey with yer tale!"
	var/loot_type = LOOT_TYPE_GENERIC
	var/revealed_cost = 0
	var/appraised = FALSE
	var/start_appraised = FALSE
	var/appraisal_difficulty
	var/list/failed_appraisers = list()


/obj/item/treasure/examine(mob/user)
	. = ..()
	. += span_notice("It [appraised ? "has" : "hasn\'t"] been appraised.")
	if(appraised)
		switch(cost)
			if(2500 to INFINITY)
				. += "[span_notice("It looks to be worth a king's ransom. Someone would have to pry it out of your cold dead hands if they didn't fork over ")][span_hypnophrase("$[cost]")]."
			if(1000 to 2499)
				. += "[span_notice("It looks to be worth a fortune. It would be impossible to part with it for less than ")][span_phobia("$[cost]")]."
			if(500 to 999)
				. += "[span_notice("It looks to be worth a ton. It would be unthinkable to part with it for less than ")][span_abductor("$[cost]")]."
			if(250 to 499)
				. += "[span_notice("It looks to be worth a lot. You wouldn't settle for less than ")][span_nicegreen("$[cost]")]."
			if(50 to 249)
				. += "[span_notice("It looks to be worth a pretty penny. You could probably sell it for about ")][span_notice("$[cost]")]."
			if(6 to 49)
				. += "[span_notice("It looks to be worth a bit. Probably around ")]$[cost]."
			if(0 to 5)
				. += "[span_notice("It looks to be worth almost nothing. Couldn't be more than ")][span_danger("$[cost]")]."


/obj/item/treasure/AltClick(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/dummy_idiot = locate(H) in failed_appraisers

		if(dummy_idiot)
			to_chat(H, span_warning("You look at [src] again. Nope. Still don't know what it is."))
			return
		else
			appraise(user)


/obj/item/treasure/proc/appraise(atom/A)
	if(ishuman(A))
		var/mob/living/carbon/human/H = A

		if(appraised)
			to_chat(H, span_warning("[src] is already appraised."))
			return

		if(!do_after(A, 50, src))
			return
		else
			if(SSroll.storyteller_roll(H.get_total_mentality(), appraisal_difficulty, mobs_to_show_output = H) == ROLL_SUCCESS)
				force_appraise()
				to_chat(H, span_nicegreen("You have successfully appraised [src]!"))
			else
				failed_appraisers += H
				to_chat(H, span_danger("You have failed to appraise [src]!"))
	else if(!A)
		force_appraise()
		CRASH("[src]([ADMIN_VERBOSEJMP(src)]) was appraised with no atom argument. Use force_appraise() instead.")


/obj/item/treasure/proc/force_appraise()
	name = revealed_name
	cost = revealed_cost
	appraised = TRUE

/obj/item/treasure/proc/on_unearthed() // Called when the treasure is exposed
	var/random_treasure = generate_treasure_cost()

	if(!random_treasure == "invalid")
		forceMove(get_turf(src))
		return

	switch(loot_type)
		if(LOOT_TYPE_BOOK)
			new /obj/effect/spawner/random/treasure/book(src.loc)
		if(LOOT_TYPE_FOSSIL)
			new /obj/effect/spawner/random/treasure/fossil(src.loc)
		if(LOOT_TYPE_SHERD)
			new /obj/effect/spawner/random/treasure/sherd(src.loc)
		if(LOOT_TYPE_ARCHEO)
			new /obj/effect/spawner/random/treasure/archeo(src.loc)
		if(LOOT_TYPE_SUPERNATURAL_GENERIC)
			new /obj/effect/spawner/random/treasure/supernatural(src.loc)
		if(LOOT_TYPE_KINDRED)
			new /obj/effect/spawner/random/treasure/supernatural/kindred(src.loc)
		if(LOOT_TYPE_ARTIFACT)
			new /obj/effect/spawner/random/occult/artifact(src.loc)
		if(LOOT_TYPE_FERA)
			new /obj/effect/spawner/random/treasure/supernatural/fera(src.loc)
		if(LOOT_TYPE_OMNI)
			new /obj/effect/spawner/random/treasure/treasure_omni(src.loc)

/obj/item/treasure/proc/do_loot_rarity(turf/T)
	if(loot_type == LOOT_TYPE_GENERIC)
		var/rarity_gamble
		if(!T.spawn_rarity)
			rarity_gamble = rand(0, 100)
		else
			rarity_gamble = T.spawn_rarity
		switch(rarity_gamble)
			if(0 to 5)
				loot_type = LOOT_TYPE_FAKE
			if(6 to 20)
				loot_type = LOOT_TYPE_ULTRACHEAP
			if(21 to 50)
				loot_type = LOOT_TYPE_CHEAP
			if(51 to 80)
				loot_type = LOOT_TYPE_MEDIUM
			if(81 to 99)
				loot_type = LOOT_TYPE_RICH
			if(100)
				loot_type = LOOT_TYPE_ULTRARICH

/obj/item/treasure/Initialize()
	. = ..()
	if(isturf(loc))
		var/turf/where_are_we = loc
		do_loot_rarity(where_are_we)
//	generate_treasure_loot()
	revealed_name = generate_treasure_name()
//	desc = generate_treasure_desc() // think Rimworld art desc
//	icon_state = generate_treasure_icon_state()
	revealed_cost = generate_treasure_cost()
	cost = ceil(revealed_cost/5)
	appraisal_difficulty = rand(1,8)

	if(start_appraised)
		force_appraise()


/obj/item/treasure/proc/generate_treasure_name()
	var/t_adj = pick(GLOB.treasure_adjectives)
	var/t_noun = pick(GLOB.treasure_nouns)
	var/t_obj = pick(GLOB.trasure_objects)

	var/generated_name = name

	if(prob(25))
		generated_name = "[t_adj] [t_noun] [t_obj]"
	else if(prob(33))
		generated_name = "[t_adj] [t_obj]"
	else if(prob(50))
		generated_name = "[t_noun] [t_obj]"
	else
		generated_name = "[t_obj]"

	return generated_name


/obj/item/treasure/proc/generate_treasure_cost()
	var/generated_cost = "invalid"
	switch(loot_type)
		if(LOOT_TYPE_GENERIC)
			generated_cost = rand(0, LOOT_TYPE_ULTRARICH_COST_MAX)
		if(LOOT_TYPE_FAKE)
			generated_cost = rand(0, LOOT_TYPE_FAKE_COST_MAX)
		if(LOOT_TYPE_ULTRACHEAP)
			generated_cost = rand(LOOT_TYPE_FAKE_COST_MAX, LOOT_TYPE_ULTRACHEAP_COST_MAX)
		if(LOOT_TYPE_CHEAP)
			generated_cost = rand(LOOT_TYPE_ULTRACHEAP_COST_MAX, LOOT_TYPE_CHEAP_COST_MAX)
		if(LOOT_TYPE_MEDIUM)
			generated_cost = rand(LOOT_TYPE_CHEAP_COST_MAX, LOOT_TYPE_MEDIUM_COST_MAX)
		if(LOOT_TYPE_RICH)
			generated_cost = rand(LOOT_TYPE_MEDIUM_COST_MAX, LOOT_TYPE_RICH_COST_MAX)
		if(LOOT_TYPE_ULTRARICH)
			generated_cost = rand(LOOT_TYPE_RICH_COST_MAX, LOOT_TYPE_ULTRARICH_COST_MAX)

	return generated_cost


/obj/item/treasure/fake
	loot_type = LOOT_TYPE_FAKE

/obj/item/treasure/ultracheap
	loot_type = LOOT_TYPE_ULTRACHEAP

/obj/item/treasure/cheap
	loot_type = LOOT_TYPE_CHEAP

/obj/item/treasure/medium
	loot_type = LOOT_TYPE_MEDIUM

/obj/item/treasure/rich
	loot_type = LOOT_TYPE_RICH

/obj/item/treasure/ultrarich
	loot_type = LOOT_TYPE_ULTRARICH
