/obj/smite_crystal
	name = "crystal"
	desc = "What the hell are you talkin' about? You've added nothing to the conversation- Get in the- Get in the crystal. Sorry, buddy, get in the crystal. HAH hahahahahahaha. We're going to put you in the crystal, you're gonna be in the crystal for a minute; It's gonna feel like one week. It's only one week, man! Some of the people are in the crystal for like, a century, okay? You're going in- the minute is gonna feel like a week so you have some time to think about what you've done. And then you're going to come out of the crystal."
	icon = 'icons/effects/64x64.dmi'
	icon_state = "curse"
	pixel_x = -16
	pixel_y = -16

/// To be deployed after typos and blunders.
/datum/smite/crystal
	name = "the crystal"

	var/charge = "Added nothing to the conversation." // Why are they going in the crystal?
	var/static/list/sentence = list("Just a second", "Only one week", "Like a century") // How long should they be in the crystal?
	var/sentence_choice
	var/jailtime // Timer
	var/felt_time // What did it feel like?
	var/static/list/sound = list("Yes", "Nearby", "No")
	var/sound_choice


/datum/smite/crystal/configure(client/user)
	charge = input(user, "What are they charged with?") as null|text
	sentence_choice = (alert(user, "How long will they spend in the crystal?", "the crystal", "Just a second", "Only one week", "Like a century"))
	sound_choice = (alert(user, "Play audio?", "the crystal", "Yes", "Nearby", "No"))


/// The effect of the smite, make sure to call this in your own smites
/datum/smite/crystal/effect(client/user, mob/living/target)
	. = ..()

	var/obj/smite_crystal/crystal = new /obj/smite_crystal(get_turf(target))
	target.forceMove(crystal)
	target.Stun(jailtime)

	to_chat(target, span_phobia(("YOUR CHARGE: [span_colossus("[charge]")]")))

	switch(sentence_choice)
		if("Just a second")
			jailtime = 30 SECONDS
			felt_time = span_notice("You spend three hours in the crystal, but only a second has passed back in reality.")
		if("Only one week")
			jailtime = 1 MINUTES
			felt_time = span_notice("You spend a week in the crystal, but only a minute has passed back in reality.")
		if("Like a century")
			jailtime = 30 SECONDS
			felt_time = span_notice("You spend a century in the crystal, but only two minutes have passed back in reality. Wait, what is this place?")
			target.move_to_error_room()

	switch(sound_choice)
		if("Yes")
			target.playsound_local(get_turf(target), 'modular_zapoc/modules/crystal/sound/crystal.ogg', 25)
			to_chat(target, span_purple("What the hell are you talkin' about? You've added nothing to the conversation- Get in the- Get in the crystal. Sorry, buddy, get in the crystal. HAH hahahahahahaha. We're going to put you in the crystal, you're gonna be in the crystal for a minute; It's gonna feel like one week. It's only one week, man! Some of the people are in the crystal for like, a century, okay? You're going in- the minute is gonna feel like a week so you have some time to think about what you've done. And then you're going to come out of the crystal."))

		if("Nearby")
			playsound(target, 'modular_zapoc/modules/crystal/sound/crystal.ogg', 25)
			to_chat(target, span_purple("What the hell are you talkin' about? You've added nothing to the conversation- Get in the- Get in the crystal. Sorry, buddy, get in the crystal. HAH hahahahahahaha. We're going to put you in the crystal, you're gonna be in the crystal for a minute; It's gonna feel like one week. It's only one week, man! Some of the people are in the crystal for like, a century, okay? You're going in- the minute is gonna feel like a week so you have some time to think about what you've done. And then you're going to come out of the crystal."))

		if("No")
			to_chat(target, span_purple("What the hell are you talkin' about? You've added nothing to the conversation- Get in the- Get in the crystal. Sorry, buddy, get in the crystal. HAH hahahahahahaha. We're going to put you in the crystal, you're gonna be in the crystal for a minute; It's gonna feel like one week. It's only one week, man! Some of the people are in the crystal for like, a century, okay? You're going in- the minute is gonna feel like a week so you have some time to think about what you've done. And then you're going to come out of the crystal."))

	crystal.freedom_timer(jailtime, felt_time)


/obj/smite_crystal/attack_hand(mob/user)
	var/sacrifice_mob = (alert(user, "Get in the crystal?", "the crystal", "Yes", "No"))

	switch(sacrifice_mob)
		if("Yes")
			user.forceMove(src)
			user.visible_message("<span class='notice'>[user] gets in [src].</span>", \
				"<span class='notice'>You get in [src].</span>")
		if("No")
			user.visible_message("<span class='notice'>[user] thinks better of getting in [src].</span>", \
			"<span class='notice'>You think better of getting in [src].</span>")

/obj/smite_crystal/attackby(obj/item/I, mob/user)
	var/sacrifice = (alert(user, "Place [I] to the crystal? You might not get it back!", "the crystal", "Yes", "No"))

	switch(sacrifice)
		if("Yes")
			I.forceMove(src)
			user.visible_message("<span class='notice'>[user] places [I] into [src].</span>", \
			"<span class='notice'>You place [I] into [src].</span>")
		if("No")
			user.visible_message("<span class='notice'>[user] thinks better of placing [I] into [src].</span>", \
				"<span class='notice'>You think better of placing [I] into [src].</span>")


/obj/smite_crystal/proc/freedom_timer(duration, freedom_text)
	addtimer(CALLBACK(src, PROC_REF(freedom), freedom_text), duration)


/obj/smite_crystal/proc/freedom(freedom_text)
	for(var/mob/i in contents)
		i.forceMove(get_turf(src))
		to_chat(i, "[freedom_text]")

	animate(src, alpha = 0, time = 1 SECONDS)
	spawn(1 SECONDS)
		qdel(src)

/mob/verb/ufonttest()
	set name = "AAAFonttest"
	set category = "Debug"

// Sorted alphabetically
	to_chat(src, span_deconversion_message("Hello, World!")) // "<span class='deconversion_message'>" + str + "</span>")
	to_chat(src, span_drone("Hello, World!")) // "<span class='drone'>" + str + "</span>")
	to_chat(src, span_engradio("Hello, World!")) // "<span class='engradio'>" + str + "</span>")
	to_chat(src, span_extremelybig("Hello, World!")) // "<span class='extremelybig'>" + str + "</span>")
	to_chat(src, span_ghostalert("Hello, World!")) // "<span class='ghostalert'>" + str + "</span>")
	to_chat(src, span_gargoylealert("Hello, World!")) // "<span class = 'gargoylealert'>" + str + "</span>")
	to_chat(src, span_green("Hello, World!")) // "<span class='green'>" + str + "</span>")
	to_chat(src, span_greenannounce("Hello, World!")) // "<span class='greenannounce'>" + str + "</span>")
	to_chat(src, span_greenteamradio("Hello, World!")) // "<span class='greenteamradio'>" + str + "</span>")
	to_chat(src, span_greentext("Hello, World!")) // "<span class='greentext'>" + str + "</span>")
	to_chat(src, span_grey("Hello, World!")) // "<span class='grey'>" + str + "</span>")
	to_chat(src, span_hear("Hello, World!")) // "<span class='hear'>" + str + "</span>")
	to_chat(src, span_hidden("Hello, World!")) // "<span class='hidden'>" + str + "</span>")
	to_chat(src, span_hierophant("Hello, World!")) // "<span class='hierophant'>" + str + "</span>")
	to_chat(src, span_hierophant_warning("Hello, World!")) // "<span class='hierophant_warning'>" + str + "</span>")
	to_chat(src, span_highlight("Hello, World!")) // "<span class='highlight'>" + str + "</span>")
	to_chat(src, span_his_grace("Hello, World!")) // "<span class='his_grace'>" + str + "</span>")
	to_chat(src, span_holoparasite("Hello, World!")) // "<span class='holoparasite'>" + str + "</span>")
	to_chat(src, span_hypnophrase("Hello, World!")) // "<span class='hypnophrase'>" + str + "</span>")
	to_chat(src, span_icon("Hello, World!")) // "<span class='icon'>" + str + "</span>")
	to_chat(src, span_info("Hello, World!")) // "<span class='info'>" + str + "</span>")
	to_chat(src, span_infoplain("Hello, World!")) // "<span class='infoplain'>" + str + "</span>")
	to_chat(src, span_interface("Hello, World!")) // "<span class='interface'>" + str + "</span>")
	to_chat(src, span_linkify("Hello, World!")) // "<span class='linkify'>" + str + "</span>")
	to_chat(src, span_userlove("Hello, World!")) // "<span class='userlove'>" + str + "</span>")
	to_chat(src, span_looc("Hello, World!")) // "<span class='looc'>" + str + "</span>")
	to_chat(src, span_medal("Hello, World!")) // "<span class='medal'>" + str + "</span>")
	to_chat(src, span_medradio("Hello, World!")) // "<span class='medradio'>" + str + "</span>")
	to_chat(src, span_memo("Hello, World!")) // "<span class='memo'>" + str + "</span>")
	to_chat(src, span_memoedit("Hello, World!")) // "<span class='memoedit'>" + str + "</span>")
	to_chat(src, span_mentor("Hello, World!")) // "<span class='mentor'>" + str + "</span>")
	to_chat(src, span_mentorfrom("Hello, World!")) // "<span class='mentorfrom'>" + str + "</span>")
	to_chat(src, span_mentorhelp("Hello, World!")) // "<span class='mentorhelp'>" + str + "</span>")
	to_chat(src, span_mentornotice("Hello, World!")) // "<span class='mentornotice'>" + str + "</span>")
	to_chat(src, span_mentorsay("Hello, World!")) // "<span class='mentorsay'>" + str + "</span>")
	to_chat(src, span_mentorto("Hello, World!")) // "<span class='mentorto'>" + str + "</span>")
	to_chat(src, span_message("Hello, World!")) // "<span class='message'>" + str + "</span>")
	to_chat(src, span_mind_control("Hello, World!")) // "<span class='mind_control'>" + str + "</span>")
	to_chat(src, span_minorannounce("Hello, World!")) // "<span class='minorannounce'>" + str + "</span>")
	to_chat(src, span_monkey("Hello, World!")) // "<span class='monkey'>" + str + "</span>")
	to_chat(src, span_monkeyhive("Hello, World!")) // "<span class='monkeyhive'>" + str + "</span>")
	to_chat(src, span_monkeylead("Hello, World!")) // "<span class='monkeylead'>" + str + "</span>")
	to_chat(src, span_name("Hello, World!")) // "<span class='name'>" + str + "</span>")
	to_chat(src, span_narsie("Hello, World!")) // "<span class='narsie'>" + str + "</span>")
	to_chat(src, span_narsiesmall("Hello, World!")) // "<span class='narsiesmall'>" + str + "</span>")
	to_chat(src, span_nicegreen("Hello, World!")) // "<span class='nicegreen'>" + str + "</span>")
	to_chat(src, span_notice("Hello, World!")) // "<span class='notice'>" + str + "</span>")
	to_chat(src, span_noticealien("Hello, World!")) // "<span class='noticealien'>" + str + "</span>")
	to_chat(src, span_ooc("Hello, World!")) // "<span class='ooc'>" + str + "</span>")
	to_chat(src, span_papyrus("Hello, World!")) // "<span class='papyrus'>" + str + "</span>")
	to_chat(src, span_purple("Hello, World!")) // "<span class='phobia'>" + str + "</span>")
	to_chat(src, span_prefix("Hello, World!")) // "<span class='prefix'>" + str + "</span>")
	to_chat(src, span_purple("Hello, World!")) // "<span class='purple'>" + str + "</span>")
	to_chat(src, span_radio("Hello, World!")) // "<span class='radio'>" + str + "</span>")
	to_chat(src, span_reallybig("Hello, World!")) // "<span class='reallybig'>" + str + "</span>")
	to_chat(src, span_red("Hello, World!")) // "<span class='red'>" + str + "</span>")
	to_chat(src, span_redteamradio("Hello, World!")) // "<span class='redteamradio'>" + str + "</span>")
	to_chat(src, span_redtext("Hello, World!")) // "<span class='redtext'>" + str + "</span>")
	to_chat(src, span_resonate("Hello, World!")) // "<span class='resonate'>" + str + "</span>")
	to_chat(src, span_revenbignotice("Hello, World!")) // "<span class='revenbignotice'>" + str + "</span>")
	to_chat(src, span_revenboldnotice("Hello, World!")) // "<span class='revenboldnotice'>" + str + "</span>")
	to_chat(src, span_revendanger("Hello, World!")) // "<span class='revendanger'>" + str + "</span>")
	to_chat(src, span_revenminor("Hello, World!")) // "<span class='revenminor'>" + str + "</span>")
	to_chat(src, span_revennotice("Hello, World!")) // "<span class='revennotice'>" + str + "</span>")
	to_chat(src, span_purple("Hello, World!")) // "<span class='revenwarning'>" + str + "</span>")
	to_chat(src, span_robot("Hello, World!")) // "<span class='robot'>" + str + "</span>")
	to_chat(src, span_rose("Hello, World!")) // "<span class='rose'>" + str + "</span>")
	to_chat(src, span_sans("Hello, World!")) // "<span class='sans'>" + str + "</span>")
	to_chat(src, span_sciradio("Hello, World!")) // "<span class='sciradio'>" + str + "</span>")
	to_chat(src, span_secradio("Hello, World!")) // "<span class='secradio'>" + str + "</span>")
	to_chat(src, span_servradio("Hello, World!")) // "<span class='servradio'>" + str + "</span>")
	to_chat(src, span_singing("Hello, World!")) // "<span class='singing'>" + str + "</span>")
	to_chat(src, span_slime("Hello, World!")) // "<span class='slime'>" + str + "</span>")
	to_chat(src, span_small("Hello, World!")) // "<span class='small'>" + str + "</span>")
	to_chat(src, span_smallnotice("Hello, World!")) // "<span class='smallnotice'>" + str + "</span>")
	to_chat(src, span_smallnoticeital("Hello, World!")) // "<span class='smallnoticeital'>" + str + "</span>")
	to_chat(src, span_spider("Hello, World!")) // "<span class='spider'>" + str + "</span>")
	to_chat(src, span_suicide("Hello, World!")) // "<span class='suicide'>" + str + "</span>")
	to_chat(src, span_suppradio("Hello, World!")) // "<span class='suppradio'>" + str + "</span>")
	to_chat(src, span_syndradio("Hello, World!")) // "<span class='syndradio'>" + str + "</span>")
	to_chat(src, span_tape_recorder("Hello, World!")) // "<span class='tape_recorder'>" + str + "</span>")
	to_chat(src, span_tinynotice("Hello, World!")) // "<span class='tinynotice'>" + str + "</span>")
	to_chat(src, span_tinynoticeital("Hello, World!")) // "<span class='tinynoticeital'>" + str + "</span>")
	to_chat(src, span_unconscious("Hello, World!")) // "<span class='unconscious'>" + str + "</span>")
	to_chat(src, span_userdanger("Hello, World!")) // "<span class='userdanger'>" + str + "</span>")
	to_chat(src, span_warning("Hello, World!")) // "<span class='warning'>" + str + "</span>")
	to_chat(src, span_yell("Hello, World!")) // "<span class='yell'>" + str + "</span>")
	to_chat(src, span_yellowteamradio("Hello, World!")) // "<span class='yellowteamradio'>" + str + "</span>")

	to_chat(src, span_subtle("Hello, World!")) // "<span class='subtle'>" + str + "</span>")
	to_chat(src, span_subtler("Hello, World!")) // "<span class='subtler'>" + str + "</span>")
	to_chat(src, span_emote("Hello, World!")) // "<span class='emote'>" + str + "</span>")
