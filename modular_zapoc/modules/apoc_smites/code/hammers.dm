/obj/effect/smitehammer
	name = "hammer"
	desc = "A hammer for killing guys with."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "toyhammer"
	movement_type = PHASING
	var/mob/hammer_target
	var/bonk_played
	var/hammer_damage

/obj/effect/smitehammer/Initialize(mapload)
	. = ..()
	spawn(30)
		qdel(src)

/obj/effect/smitehammer/Move()
	. = ..()
	if(loc == hammer_target.loc)
		if(!bonk_played)
			playsound(src, 'modular_zapoc/modules/apoc_smites/sound/hammer_bonk.ogg', 75)
			bonk_played = 1
			if(hammer_damage && isliving(hammer_target))
				var/mob/living/L = hammer_target
				L.adjustBruteLoss(hammer_damage)
		spawn(1)
			qdel(src)

/datum/smite/hammers
	name = "hammers"

	var/hammer_count
	var/sound_choice
	var/quick_hammers
	var/lethal
	var/hammer_damage
	var/abort

/datum/smite/hammers/configure(client/user)
	quick_hammers = (alert(user, "Skip setup?", "hammers", "Yes", "No", "Cancel"))
	if(quick_hammers == "Yes")
		hammer_count = 5
		sound_choice = "Nearby"
		lethal = "Not really"
		abort = "Go"
	else if(quick_hammers == "No")
		hammer_count = input(user, "How many hammers are we killing this guy with?") as num
		sound_choice = (alert(user, "Play audio?", "hammers", "Target only", "Nearby", "No"))
		lethal = (alert(user, "Kill them?", "hammers", "Not really", "With hammers", "NOW"))
		abort = (alert(user, "Hammers: [hammer_count]. Audio: [sound_choice]. Lethality: [lethal]. Confirm?", "hammers", "Go", "Cancel"))
	else if(quick_hammers == "Cancel")
		abort = "Cancel"


/datum/smite/hammers/effect(client/user, mob/living/target)
	if(abort == "Go")
		target.Stun(hammer_count*3)
		switch(sound_choice)
			if("Target only")
				target.playsound_local(get_turf(target), 'modular_zapoc/modules/apoc_smites/sound/hammers.ogg', 75)
				to_chat(target, span_purple("What the hell are you talkin' about? You've added nothing to the conversation- Get in the- Get in the crystal. Sorry, buddy, get in the crystal. HAH hahahahahahaha. We're going to put you in the crystal, you're gonna be in the crystal for a minute; It's gonna feel like one week. It's only one week, man! Some of the people are in the crystal for like, a century, okay? You're going in- the minute is gonna feel like a week so you have some time to think about what you've done. And then you're going to come out of the crystal."))
			if("Nearby")
				playsound(target, 'modular_zapoc/modules/apoc_smites/sound/hammers.ogg', 75)
				to_chat(target, span_purple("OKAY, OKAY, OKAY! You- Let's kill them! Let's kill this guy. Let's beat them to death with hammers."))
			if("No")
				to_chat(target, span_purple("OKAY, OKAY, OKAY! You- Let's kill them! Let's kill this guy. Let's beat them to death with hammers."))
		switch(lethal)
			if("Not really")
				hammer_damage = 0
			if("With hammers")
				hammer_damage = (10/hammer_count)
			if("NOW")
				hammer_damage = (75/hammer_count)

		var/list/possible_killers = list()
		for(var/mob/living/L in view(7, target))
			if(L != target)
				possible_killers += L

		spawn_hammer(user, target, hammer_damage, possible_killers, max(min(hammer_count, 50), 2))
		var/msg = "[key_name(target)] was killed with [hammer_count] hammers for [hammer_count*hammer_damage] damage."
		message_admins(msg)
		log_admin(msg)
	else
		var/msg = "[key_name(user)] cancelled the hammers before execution."
		message_admins(msg)
		log_admin(msg)


/datum/smite/hammers/proc/compose_killer_name(mob/target)
	var/randname
	var/staticname = safepick(GLOB.player_list)
	if(prob(1)) // 1%
		if(staticname != target) // Make sure we aren't throwing hammers at ourselves
			randname = staticname
	else
		if(prob(50))
			randname = pick(GLOB.first_names_male)
		else
			randname = pick(GLOB.first_names_female)

		randname += " [pick(GLOB.last_names)]"
	return randname

/datum/smite/hammers/proc/spawn_hammer(client/user, mob/target, damage, list/moblist, repeats)
	var/spawnpoint
	var/spawndir = pick(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHWEST, SOUTHEAST)
	var/spawndist = rand(2, 7)

	var/turf/current = target.loc
	for(var/i = 1 to spawndist)
		current = get_step(current, spawndir)

	spawnpoint = current

	var/obj/effect/smitehammer/HAM = new /obj/effect/smitehammer(spawnpoint)
	HAM.hammer_damage = damage
	HAM.hammer_target = target
	HAM.SpinAnimation(5, 1)
	walk(HAM, get_dir(HAM, target))

	target.visible_message(span_danger("[target] is hit by a hammer!"), \
		span_danger("You are hit by a hammer!"))

	if(repeats > 0)
		addtimer(CALLBACK(src, PROC_REF(spawn_hammer), user, target, damage, moblist, repeats-1), 1)
