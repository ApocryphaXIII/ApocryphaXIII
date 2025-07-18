/// Slime Extracts ///

/obj/item/slime_extract
	name = "slime extract"
	desc = "Goo extracted from a slime. Legends claim these to have \"magical powers\"."
	icon = 'icons/mob/slimes.dmi'
	icon_state = "grey slime extract"
	force = 0
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 3
	throw_range = 6
	grind_results = list()
	var/Uses = 1 ///uses before it goes inert
	var/qdel_timer = null ///deletion timer, for delayed reactions
	var/effectmod ///Which type of crossbred
	var/list/activate_reagents = list() ///Reagents required for activation
	var/recurring = FALSE
	/// Research point value for slime cores. These are defines stored in [code/__DEFINES/research.dm] - the actual values are updated there.
	var/research

/obj/item/slime_extract/examine(mob/user)
	. = ..()
	if(Uses > 1)
		. += "It has [Uses] uses remaining."

/obj/item/slime_extract/attackby(obj/item/O, mob/user)
	if(istype(O, /obj/item/slimepotion/enhancer))
		if(Uses >= 5 || recurring)
			to_chat(user, "<span class='warning'>You cannot enhance this extract further!</span>")
			return ..()
		if(O.type == /obj/item/slimepotion/enhancer) //Seriously, why is this defined here...?
			to_chat(user, "<span class='notice'>You apply the enhancer to the slime extract. It may now be reused one more time.</span>")
			Uses++
		if(O.type == /obj/item/slimepotion/enhancer/max)
			to_chat(user, "<span class='notice'>You dump the maximizer on the slime extract. It can now be used a total of 5 times!</span>")
			Uses = 5
		qdel(O)
	..()

/obj/item/slime_extract/Initialize()
	. = ..()
	create_reagents(100, INJECTABLE | DRAWABLE)

/obj/item/slime_extract/on_grind()
	. = ..()
	if(Uses)
		grind_results[/datum/reagent/toxin/slimejelly] = 20

/**
* Core-crossing: Feeding adult slimes extracts to obtain a much more powerful, single extract.
*
* By using a valid core on a living adult slime, then feeding it nine more of the same type, you can mutate it into more useful items. Not every slime type has an implemented core cross.
*/
/obj/item/slime_extract/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!isslime(M))
		return ..()
	if(M.stat)
		to_chat(user, "<span class='warning'>The slime is dead!</span>")
		return
	if(!M.is_adult)
		to_chat(user, "<span class='warning'>The slime must be an adult to cross its core!</span>")
		return
	if(M.effectmod && M.effectmod != effectmod)
		to_chat(user, "<span class='warning'>The slime is already being crossed with a different extract!</span>")
		return

	if(!M.effectmod)
		M.effectmod = effectmod

	M.applied++
	qdel(src)
	to_chat(user, "<span class='notice'>You feed the slime [src], [M.applied == 1 ? "starting to mutate its core." : "further mutating its core."]</span>")
	playsound(M, 'sound/effects/attackblob.ogg', 50, TRUE)

	if(M.applied >= SLIME_EXTRACT_CROSSING_REQUIRED)
		M.spawn_corecross()

/obj/item/slime_extract/grey
	name = "grey slime extract"
	icon_state = "grey slime extract"
	effectmod = "reproductive"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,/datum/reagent/water)
	research = SLIME_RESEARCH_TIER_0

/obj/item/slime_extract/gold
	name = "gold slime extract"
	icon_state = "gold slime extract"
	effectmod = "symbiont"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,/datum/reagent/water)
	research = SLIME_RESEARCH_TIER_4

/obj/item/slime_extract/silver
	name = "silver slime extract"
	icon_state = "silver slime extract"
	effectmod = "consuming"
	activate_reagents = list(/datum/reagent/toxin/plasma,/datum/reagent/water)
	research = SLIME_RESEARCH_TIER_2

/obj/item/slime_extract/metal
	name = "metal slime extract"
	icon_state = "metal slime extract"
	effectmod = "industrial"
	activate_reagents = list(/datum/reagent/toxin/plasma,/datum/reagent/water)
	research = SLIME_RESEARCH_TIER_1

/obj/item/slime_extract/purple
	name = "purple slime extract"
	icon_state = "purple slime extract"
	effectmod = "regenerative"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma)
	research = SLIME_RESEARCH_TIER_1

/obj/item/slime_extract/darkpurple
	name = "dark purple slime extract"
	icon_state = "dark purple slime extract"
	effectmod = "self-sustaining"
	activate_reagents = list(/datum/reagent/toxin/plasma)
	research = SLIME_RESEARCH_TIER_2

/obj/item/slime_extract/orange
	name = "orange slime extract"
	icon_state = "orange slime extract"
	effectmod = "burning"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,/datum/reagent/water)
	research = SLIME_RESEARCH_TIER_1

/obj/item/slime_extract/yellow
	name = "yellow slime extract"
	icon_state = "yellow slime extract"
	effectmod = "charged"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/water)
	research = SLIME_RESEARCH_TIER_2

/obj/item/slime_extract/red
	name = "red slime extract"
	icon_state = "red slime extract"
	effectmod = "sanguine"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,/datum/reagent/water)
	research = SLIME_RESEARCH_TIER_4

/obj/item/slime_extract/blue
	name = "blue slime extract"
	icon_state = "blue slime extract"
	effectmod = "stabilized"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,/datum/reagent/water)
	research = SLIME_RESEARCH_TIER_1

/obj/item/slime_extract/darkblue
	name = "dark blue slime extract"
	icon_state = "dark blue slime extract"
	effectmod = "chilling"
	activate_reagents = list(/datum/reagent/toxin/plasma,/datum/reagent/water)
	research = SLIME_RESEARCH_TIER_2

/obj/item/slime_extract/pink
	name = "pink slime extract"
	icon_state = "pink slime extract"
	effectmod = "gentle"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma)
	research = SLIME_RESEARCH_TIER_4

/obj/item/slime_extract/green
	name = "green slime extract"
	icon_state = "green slime extract"
	effectmod = "mutative"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,/datum/reagent/uranium/radium)
	research = SLIME_RESEARCH_TIER_4

/obj/item/slime_extract/lightpink
	name = "light pink slime extract"
	icon_state = "light pink slime extract"
	effectmod = "loyal"
	activate_reagents = list(/datum/reagent/toxin/plasma)
	research = SLIME_RESEARCH_TIER_5

/obj/item/slime_extract/black
	name = "black slime extract"
	icon_state = "black slime extract"
	effectmod = "transformative"
	activate_reagents = list(/datum/reagent/toxin/plasma)
	research = SLIME_RESEARCH_TIER_5

/obj/item/slime_extract/oil
	name = "oil slime extract"
	icon_state = "oil slime extract"
	effectmod = "detonating"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma)
	research = SLIME_RESEARCH_TIER_5

/obj/item/slime_extract/adamantine
	name = "adamantine slime extract"
	icon_state = "adamantine slime extract"
	effectmod = "crystalline"
	activate_reagents = list(/datum/reagent/toxin/plasma)
	research = SLIME_RESEARCH_TIER_5

/obj/item/slime_extract/bluespace
	name = "bluespace slime extract"
	icon_state = "bluespace slime extract"
	effectmod = "warping"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma)
	var/teleport_ready = FALSE
	var/teleport_x = 0
	var/teleport_y = 0
	var/teleport_z = 0
	research = SLIME_RESEARCH_TIER_3

/obj/item/slime_extract/pyrite
	name = "pyrite slime extract"
	icon_state = "pyrite slime extract"
	effectmod = "prismatic"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma)
	research = SLIME_RESEARCH_TIER_3

/obj/item/slime_extract/cerulean
	name = "cerulean slime extract"
	icon_state = "cerulean slime extract"
	effectmod = "recurring"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma)
	research = SLIME_RESEARCH_TIER_3

/obj/item/slime_extract/sepia
	name = "sepia slime extract"
	icon_state = "sepia slime extract"
	effectmod = "lengthened"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,/datum/reagent/water)
	research = SLIME_RESEARCH_TIER_3

/obj/item/slime_extract/rainbow
	name = "rainbow slime extract"
	icon_state = "rainbow slime extract"
	effectmod = "hyperchromatic"
	activate_reagents = list(/datum/reagent/blood,/datum/reagent/toxin/plasma,"lesser plasma",/datum/reagent/toxin/slimejelly,"holy water and uranium") //Curse this snowflake reagent list.
	research = SLIME_RESEARCH_TIER_RAINBOW

////Slime-derived potions///

/**
* #Slime potions
*
* Feed slimes potions either by hand or using the slime console.
*
* Slime potions either augment the slime's behavior, its extract output, or its intelligence. These all come either from extract effects or cross cores.
* A few of the more powerful ones can modify someone's equipment or gender.
* New ones should probably be accessible only through cross cores as all the normal core types already have uses. Rule of thumb is 'stronger effects go in cross cores'.
*/

/obj/item/slimepotion
	name = "slime potion"
	desc = "A hard yet gelatinous capsule excreted by a slime, containing mysterious substances."
	w_class = WEIGHT_CLASS_TINY

/obj/item/slimepotion/afterattack(obj/item/reagent_containers/target, mob/user , proximity)
	. = ..()
	if(!proximity)
		return
	if (istype(target))
		to_chat(user, "<span class='warning'>You cannot transfer [src] to [target]! It appears the potion must be given directly to a slime to absorb.</span>" )
		return

/obj/item/slimepotion/slime/docility
	name = "docility potion"
	desc = "A potent chemical mix that nullifies a slime's hunger, causing it to become docile and tame."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potsilver"

/obj/item/slimepotion/slime/docility/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!isslime(M))
		to_chat(user, "<span class='warning'>The potion only works on slimes!</span>")
		return ..()
	if(M.stat)
		to_chat(user, "<span class='warning'>The slime is dead!</span>")
		return
	if(M.rabid) //Stops being rabid, but doesn't become truly docile.
		to_chat(M, "<span class='warning'>You absorb the potion, and your rabid hunger finally settles to a normal desire to feed.</span>")
		to_chat(user, "<span class='notice'>You feed the slime the potion, calming its rabid rage.</span>")
		M.rabid = FALSE
		qdel(src)
		return
	M.docile = 1
	M.set_nutrition(700)
	to_chat(M, "<span class='warning'>You absorb the potion and feel your intense desire to feed melt away.</span>")
	to_chat(user, "<span class='notice'>You feed the slime the potion, removing its hunger and calming it.</span>")
	var/newname = sanitize_name(stripped_input(user, "Would you like to give the slime a name?", "Name your new pet", "pet slime", MAX_NAME_LEN))

	if (!newname)
		newname = "pet slime"
	M.name = newname
	M.real_name = newname
	qdel(src)

/obj/item/slimepotion/slime/sentience
	name = "intelligence potion"
	desc = "A miraculous chemical mix that grants human like intelligence to living beings."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potpink"
	var/list/not_interested = list()
	var/being_used = FALSE
	var/sentience_type = SENTIENCE_ORGANIC

/obj/item/slimepotion/slime/sentience/attack(mob/living/M, mob/user)
	if(being_used || !ismob(M))
		return
	if(!isanimal(M) || M.ckey) //only works on animals that aren't player controlled
		to_chat(user, "<span class='warning'>[M] is already too intelligent for this to work!</span>")
		return
	if(M.stat)
		to_chat(user, "<span class='warning'>[M] is dead!</span>")
		return
	var/mob/living/simple_animal/SM = M
	if(SM.sentience_type != sentience_type)
		to_chat(user, "<span class='warning'>[src] won't work on [SM].</span>")
		return

	to_chat(user, "<span class='notice'>You offer [src] to [SM]...</span>")
	being_used = TRUE

	var/list/candidates = pollCandidatesForMob("Do you want to play as [SM.name]?", ROLE_SENTIENCE, null, ROLE_SENTIENCE, 50, SM, POLL_IGNORE_SENTIENCE_POTION) // see poll_ignore.dm
	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		SM.key = C.key
		SM.mind.enslave_mind_to_creator(user)
		if(!SM.tame)
			SM.tamed(user)
		SM.sentience_act()
		to_chat(SM, "<span class='warning'>All at once it makes sense: you know what you are and who you are! Self awareness is yours!</span>")
		to_chat(SM, "<span class='userdanger'>You are grateful to be self aware and owe [user.real_name] a great debt. Serve [user.real_name], and assist [user.p_them()] in completing [user.p_their()] goals at any cost.</span>")
		if(SM.flags_1 & HOLOGRAM_1) //Check to see if it's a holodeck creature
			to_chat(SM, "<span class='userdanger'>You also become depressingly aware that you are not a real creature, but instead a holoform. Your existence is limited to the parameters of the holodeck.</span>")
		to_chat(user, "<span class='notice'>[SM] accepts [src] and suddenly becomes attentive and aware. It worked!</span>")
		SM.copy_languages(user)
		after_success(user, SM)
		qdel(src)
	else
		to_chat(user, "<span class='notice'>[SM] looks interested for a moment, but then looks back down. Maybe you should try again later.</span>")
		being_used = FALSE
		..()

/obj/item/slimepotion/slime/sentience/proc/after_success(mob/living/user, mob/living/simple_animal/SM)
	return

/obj/item/slimepotion/slime/sentience/nuclear
	name = "syndicate intelligence potion"
	desc = "A miraculous chemical mix that grants human like intelligence to living beings. It has been modified with Syndicate technology to also grant an internal radio implant to the target and authenticate with identification systems."

/obj/item/slimepotion/slime/sentience/nuclear/after_success(mob/living/user, mob/living/simple_animal/SM)
	var/obj/item/implant/radio/syndicate/imp = new(src)
	imp.implant(SM, user)

	SM.access_card = new /obj/item/card/id/syndicate(SM)
	ADD_TRAIT(SM.access_card, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

/obj/item/slimepotion/transference
	name = "consciousness transference potion"
	desc = "A strange slime-based chemical that, when used, allows the user to transfer their consciousness to a lesser being."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potorange"
	var/prompted = 0
	var/animal_type = SENTIENCE_ORGANIC

/obj/item/slimepotion/transference/afterattack(mob/living/M, mob/living/user, proximity)
	if(!proximity)
		return
	if(prompted || !ismob(M))
		return
	if(!isanimal(M) || M.ckey) //much like sentience, these will not work on something that is already player controlled
		to_chat(user, "<span class='warning'>[M] already has a higher consciousness!</span>")
		return ..()
	if(M.stat)
		to_chat(user, "<span class='warning'>[M] is dead!</span>")
		return ..()
	var/mob/living/simple_animal/SM = M
	if(SM.sentience_type != animal_type)
		to_chat(user, "<span class='warning'>You cannot transfer your consciousness to [SM].</span>" )
		return ..()
	var/jb = is_banned_from(user.ckey, ROLE_MIND_TRANSFER)
	if(QDELETED(src) || QDELETED(M) || QDELETED(user))
		return

	if(jb)
		to_chat(user, "<span class='warning'>Your mind goes blank as you attempt to use the potion.</span>")
		return

	prompted = 1
	if(alert("This will permanently transfer your consciousness to [SM]. Are you sure you want to do this?",,"Yes","No")=="No")
		prompted = 0
		return

	to_chat(user, "<span class='notice'>You drink the potion then place your hands on [SM]...</span>")


	user.mind.transfer_to(SM)
	SM.faction = user.faction.Copy()
	SM.sentience_act() //Same deal here as with sentience
	user.death()
	to_chat(SM, "<span class='notice'>In a quick flash, you feel your consciousness flow into [SM]!</span>")
	to_chat(SM, "<span class='warning'>You are now [SM]. Your allegiances, alliances, and role is still the same as it was prior to consciousness transfer!</span>")
	SM.name = "[user.real_name]"
	qdel(src)

/obj/item/slimepotion/slime/steroid
	name = "slime steroid"
	desc = "A potent chemical mix that will cause a baby slime to generate more extract."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potred"

/obj/item/slimepotion/slime/steroid/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!isslime(M))//If target is not a slime.
		to_chat(user, "<span class='warning'>The steroid only works on baby slimes!</span>")
		return ..()
	if(M.is_adult) //Can't steroidify adults
		to_chat(user, "<span class='warning'>Only baby slimes can use the steroid!</span>")
		return
	if(M.stat)
		to_chat(user, "<span class='warning'>The slime is dead!</span>")
		return
	if(M.cores >= 5)
		to_chat(user, "<span class='warning'>The slime already has the maximum amount of extract!</span>")
		return

	to_chat(user, "<span class='notice'>You feed the slime the steroid. It will now produce one more extract.</span>")
	M.cores++
	qdel(src)

/obj/item/slimepotion/enhancer
	name = "extract enhancer"
	desc = "A potent chemical mix that will give a slime extract an additional use."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potpurple"

/obj/item/slimepotion/slime/stabilizer
	name = "slime stabilizer"
	desc = "A potent chemical mix that will reduce the chance of a slime mutating."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potcyan"

/obj/item/slimepotion/slime/stabilizer/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!isslime(M))
		to_chat(user, "<span class='warning'>The stabilizer only works on slimes!</span>")
		return ..()
	if(M.stat)
		to_chat(user, "<span class='warning'>The slime is dead!</span>")
		return
	if(M.mutation_chance == 0)
		to_chat(user, "<span class='warning'>The slime already has no chance of mutating!</span>")
		return

	to_chat(user, "<span class='notice'>You feed the slime the stabilizer. It is now less likely to mutate.</span>")
	M.mutation_chance = clamp(M.mutation_chance-15,0,100)
	qdel(src)

/obj/item/slimepotion/slime/mutator
	name = "slime mutator"
	desc = "A potent chemical mix that will increase the chance of a slime mutating."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potgreen"

/obj/item/slimepotion/slime/mutator/attack(mob/living/simple_animal/slime/M, mob/user)
	if(!isslime(M))
		to_chat(user, "<span class='warning'>The mutator only works on slimes!</span>")
		return ..()
	if(M.stat)
		to_chat(user, "<span class='warning'>The slime is dead!</span>")
		return
	if(M.mutator_used)
		to_chat(user, "<span class='warning'>This slime has already consumed a mutator, any more would be far too unstable!</span>")
		return
	if(M.mutation_chance == 100)
		to_chat(user, "<span class='warning'>The slime is already guaranteed to mutate!</span>")
		return

	to_chat(user, "<span class='notice'>You feed the slime the mutator. It is now more likely to mutate.</span>")
	M.mutation_chance = clamp(M.mutation_chance+12,0,100)
	M.mutator_used = TRUE
	qdel(src)

/obj/item/slimepotion/speed
	name = "slime speed potion"
	desc = "A potent chemical mix that will remove the slowdown from any item."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potyellow"

/obj/item/slimepotion/speed/afterattack(obj/C, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!istype(C))
		// applying this to vehicles is handled in the ridable element, see [/datum/element/ridable/proc/check_potion]
		to_chat(user, "<span class='warning'>The potion can only be used on items or vehicles!</span>")
		return
	if(isitem(C))
		var/obj/item/I = C
		if(I.slowdown <= 0 || I.obj_flags & IMMUTABLE_SLOW)
			to_chat(user, "<span class='warning'>The [C] can't be made any faster!</span>")
			return ..()
		I.slowdown = 0

	to_chat(user, span_notice("You slather the red gunk over the [C], making it faster."))
	C.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	C.add_atom_colour(color_transition_filter(COLOR_RED, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	qdel(src)

/obj/item/slimepotion/fireproof
	name = "slime chill potion"
	desc = "A potent chemical mix that will fireproof any article of clothing. Has three uses."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potblue"
	resistance_flags = FIRE_PROOF
	var/uses = 3

/obj/item/slimepotion/fireproof/afterattack(obj/item/clothing/C, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!uses)
		qdel(src)
		return
	if(!istype(C))
		to_chat(user, "<span class='warning'>The potion can only be used on clothing!</span>")
		return
	if(C.max_heat_protection_temperature >= FIRE_IMMUNITY_MAX_TEMP_PROTECT)
		to_chat(user, "<span class='warning'>The [C] is already fireproof!</span>")
		return
	to_chat(user, "<span class='notice'>You slather the blue gunk over the [C], fireproofing it.</span>")
	C.name = "fireproofed [C.name]"
	C.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	C.add_atom_colour("#000080", FIXED_COLOUR_PRIORITY)
	C.max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	C.heat_protection = C.body_parts_covered
	C.resistance_flags |= FIRE_PROOF
	uses --
	if(!uses)
		qdel(src)

/obj/item/slimepotion/genderchange
	name = "gender change potion"
	desc = "An interesting chemical mix that changes the biological gender of what its applied to. Cannot be used on things that lack gender entirely."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potlightpink"

/obj/item/slimepotion/genderchange/attack(mob/living/L, mob/user)
	if(!istype(L) || L.stat == DEAD)
		to_chat(user, "<span class='warning'>The potion can only be used on living things!</span>")
		return

	if(L.gender != MALE && L.gender != FEMALE)
		to_chat(user, "<span class='warning'>The potion can only be used on gendered things!</span>")
		return

	if(L.gender == MALE)
		L.gender = FEMALE
		L.visible_message("<span class='boldnotice'>[L] suddenly looks more feminine!</span>", "<span class='boldwarning'>You suddenly feel more feminine!</span>")
	else
		L.gender = MALE
		L.visible_message("<span class='boldnotice'>[L] suddenly looks more masculine!</span>", "<span class='boldwarning'>You suddenly feel more masculine!</span>")
	L.regenerate_icons()
	qdel(src)

/obj/item/slimepotion/slime/renaming
	name = "renaming potion"
	desc = "A potion that allows a self-aware being to change what name it subconciously presents to the world."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potgreen"

	var/being_used = FALSE

/obj/item/slimepotion/slime/renaming/attack(mob/living/M, mob/user)
	if(being_used || !ismob(M))
		return
	if(!M.ckey) //only works on animals that aren't player controlled
		to_chat(user, "<span class='warning'>[M] is not self aware, and cannot pick its own name.</span>")
		return

	being_used = TRUE

	to_chat(user, "<span class='notice'>You offer [src] to [user]...</span>")

	var/new_name = sanitize_name(stripped_input(M, "What would you like your name to be?", "Input a name", M.real_name, MAX_NAME_LEN))

	if(!new_name || QDELETED(src) || QDELETED(M) || new_name == M.real_name || !M.Adjacent(user))
		being_used = FALSE
		return

	M.visible_message("<span class='notice'><span class='name'>[M]</span> has a new name, <span class='name'>[new_name]</span>.</span>", "<span class='notice'>Your old name of <span class='name'>[M.real_name]</span> fades away, and your new name <span class='name'>[new_name]</span> anchors itself in your mind.</span>")
	message_admins("[ADMIN_LOOKUPFLW(user)] used [src] on [ADMIN_LOOKUPFLW(M)], letting them rename themselves into [new_name].")

	// pass null as first arg to not update records or ID/PDA
	M.fully_replace_character_name(null, new_name)

	qdel(src)

/obj/item/slimepotion/slime/slimeradio
	name = "bluespace radio potion"
	desc = "A strange chemical that grants those who ingest it the ability to broadcast and receive subscape radio waves."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "potgrey"

/obj/item/slimepotion/slime/slimeradio/attack(mob/living/M, mob/user)
	if(!ismob(M))
		return
	if(!isanimal(M))
		to_chat(user, "<span class='warning'>[M] is too complex for the potion!</span>")
		return
	if(M.stat)
		to_chat(user, "<span class='warning'>[M] is dead!</span>")
		return

	to_chat(user, "<span class='notice'>You feed the potion to [M].</span>")
	to_chat(M, "<span class='notice'>Your mind tingles as you are fed the potion. You can hear radio waves now!</span>")
	var/obj/item/implant/radio/slime/imp = new(src)
	imp.implant(M, user)
	qdel(src)

///Definitions for slime products that don't have anywhere else to go (Floor tiles, blueprints).

/obj/item/stack/tile/bluespace
	name = "bluespace floor tile"
	singular_name = "floor tile"
	desc = "Through a series of micro-teleports these tiles let people move at incredible speeds."
	icon_state = "tile-bluespace"
	inhand_icon_state = "tile-bluespace"
	w_class = WEIGHT_CLASS_NORMAL
	force = 6
	mats_per_unit = list(/datum/material/iron=500)
	throwforce = 10
	throw_speed = 3
	throw_range = 7
	flags_1 = CONDUCT_1
	max_amount = 60
	turf_type = /turf/open/floor/bluespace
	merge_type = /obj/item/stack/tile/bluespace

/obj/item/stack/tile/sepia
	name = "sepia floor tile"
	singular_name = "floor tile"
	desc = "Time seems to flow very slowly around these tiles."
	icon_state = "tile-sepia"
	inhand_icon_state = "tile-sepia"
	w_class = WEIGHT_CLASS_NORMAL
	force = 6
	mats_per_unit = list(/datum/material/iron=500)
	throwforce = 10
	throw_speed = 0.1
	throw_range = 28
	flags_1 = CONDUCT_1
	max_amount = 60
	turf_type = /turf/open/floor/sepia
	merge_type = /obj/item/stack/tile/sepia

/obj/item/areaeditor/blueprints/slime
	name = "cerulean prints"
	desc = "A one use yet of blueprints made of jelly like organic material. Extends the reach of the management console."
	color = "#2956B2"

/obj/item/areaeditor/blueprints/slime/edit_area()
	..()
	var/area/A = get_area(src)
	for(var/turf/T in A)
		T.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
		T.add_atom_colour("#2956B2", FIXED_COLOUR_PRIORITY)
	A.area_flags |= XENOBIOLOGY_COMPATIBLE
	qdel(src)
