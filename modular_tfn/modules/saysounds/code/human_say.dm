/mob/living/carbon/human/proc/send_voice(message, speech_mode)
	if(!message || !length(message))
		return
	if(dna.species)
		dna.species.send_voice(src, speech_mode)

/mob/living/carbon/human/send_speech(message, message_range = 6, obj/source = src, bubble_type = bubble_icon, list/spans, datum/language/message_language=null, message_mods, original_message)
	. = ..()

	var/speech_mode
	var/ending = copytext_char(message, -1)

	if(copytext_char(message, -2) == "!!")
		speech_mode = "_exclaim"
	else if(message_mods[MODE_SING])
		speech_mode ="_sing"
	else if(ending == "?")
		speech_mode = "_ask"
	else if(ending == "!")
		speech_mode = "_exclaim"

	if(message_mods[WHISPER_MODE])
		send_voice(message, speech_mode, 50)
	else
		send_voice(message, speech_mode, 100)

/datum/species/proc/send_voice(mob/living/L, speech_mode, talksound_vol)
	if(!talksound_vol)
		talksound_vol = 100

	// Only play sounds for mobs with a ckey (player-controlled)
	if(!L.ckey)
		return

	var/vocal_sound_pref = L.client?.prefs?.chosen_vocal_sound || 1

	var/sound_file
	switch(vocal_sound_pref)
		if(1)
			sound_file = "modular_tfn/modules/saysounds/sounds/talk[speech_mode].ogg"
		if(2)
			sound_file = "modular_tfn/modules/saysounds/sounds/pencil[speech_mode].ogg"
		if(3)
			sound_file = "modular_tfn/modules/saysounds/sounds/goon/buwoo[speech_mode].ogg"
		if(4)
			sound_file = "modular_tfn/modules/saysounds/sounds/goon/cow[speech_mode].ogg"
		if(5)
			sound_file = "modular_tfn/modules/saysounds/sounds/goon/pug[speech_mode].ogg"
		if(6)
			sound_file = "modular_tfn/modules/saysounds/sounds/goon/speak_1[speech_mode].ogg"
		if(7)
			sound_file = "modular_tfn/modules/saysounds/sounds/goon/speak_2[speech_mode].ogg"
		if(8)
			sound_file = "modular_tfn/modules/saysounds/sounds/goon/speak_3[speech_mode].ogg"
		if(9)
			sound_file = "modular_tfn/modules/saysounds/sounds/goon/speak_4[speech_mode].ogg"
		if(10)
			return
		else
			sound_file = 'modular_tfn/modules/saysounds/sounds/talk.ogg' // Default fallback

	var/vocal_frequency = rand(95, 105) / 100 // 0.95 to 1.05 (5% variation)
	playsound(L, "[sound_file]", talksound_vol, TRUE, 0, SOUND_FALLOFF_EXPONENT, vocal_frequency, CHANNEL_VOCAL_SOUNDS, FALSE)

// playsound_local override to check for CHANNEL_VOCAL_SOUNDS
/mob/playsound_local(turf/turf_source, soundin, vol as num, vary, frequency, falloff_exponent = SOUND_FALLOFF_EXPONENT, channel = 0, sound/S, max_distance, falloff_distance = SOUND_DEFAULT_FALLOFF_DISTANCE, distance_multiplier = 1, use_reverb = TRUE)

	// before running original playsound_local, check if the playsound is channel_vocal_sounds, and if they have the pref turned on, if they do, dont play that channel
	if(channel == CHANNEL_VOCAL_SOUNDS && client?.prefs?.disable_vocal_sounds)
		return

	// run original playsound_local
	return ..()
