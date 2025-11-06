GLOBAL_LIST_EMPTY(unallocated_agility_shortcuts)

/obj/agility_shortcut
	name = "tunnel"
	desc = "It looks too small to fit through."
	icon = 'modular_zapoc/modules/apoc_decor/icons/agility_shortcut.dmi'
	icon_state = "shortcut"
	var/obj/agility_shortcut/exit
	var/id

/obj/agility_shortcut/Initialize()
	. = ..()
	if(!exit)
		if(isnum(id))
			warning("[src] has a ID of [id]. Numbers are bad practice") // Im considering them bad practice cause you cant fucking tell where the lead - Fallcon
		GLOB.unallocated_agility_shortcuts += src
		for(var/obj/agility_shortcut/T in GLOB.unallocated_agility_shortcuts)
			if(T.id == id && T != src)
				exit = T
				GLOB.unallocated_agility_shortcuts -= T
				T.exit = src
				GLOB.unallocated_agility_shortcuts -= src
				break

/obj/agility_shortcut/attack_hand(mob/living/user)
	var/user_power = user.get_total_athletics()
	var/time = 80 - (user_power*10)
	if(isgarou(user) || iswerewolf(user)) // Snowflaked because this repo DIES soon
		to_chat(user, span_notice("You start crawling through the tunnel..."))
		if(do_after(user, max(3 SECONDS, time), src))
			user.forceMove(get_turf(exit))
		else
			to_chat(user, span_warning("You stop trying to crawl through the tunnel."))
	else
		to_chat(user, span_warning("No way I'm crawling in there."))
