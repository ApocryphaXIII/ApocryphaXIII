// Vocal Sound Preference Verbs
/client/verb/change_vocal_sound()
	set name = "Select Vocal Sound"
	set category = "Preferences"
	set desc = "Change what sound plays when you speak."

	var/list/sound_options = list("Talk", "Pencil", "Speak 1", "Speak 2", "Speak 3", "Speak 4", "Buwoo", "Cow", "Pug", "None")
	var/new_sound_text = tgui_input_list(usr, "Choose your vocal sound:", "Vocal Sound", sound_options, prefs.chosen_vocal_sound)
	var/new_sound
	switch(new_sound_text)
		if("Talk")
			new_sound = 1
		if("Pencil")
			new_sound = 2
		if("Speak 1")
			new_sound = 3
		if("Speak 2")
			new_sound = 4
		if("Speak 3")
			new_sound = 5
		if("Speak 4")
			new_sound = 6
		if("Buwoo")
			new_sound = 7
		if("Cow")
			new_sound = 8
		if("Pug")
			new_sound = 9
		if("None")
			new_sound = 10

	if(new_sound && new_sound != prefs.chosen_vocal_sound)
		prefs.chosen_vocal_sound = new_sound
		prefs.save_preferences()
		to_chat(usr, "Your vocal sound has been changed to: [new_sound_text]")
		SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Change Vocal Sound", new_sound))

/client/verb/toggle_vocal_sounds()
	set name = "Toggle Vocal Sounds"
	set category = "Preferences"
	set desc = "Enable or disable hearing vocal sounds from other players."

	prefs.disable_vocal_sounds = !prefs.disable_vocal_sounds
	prefs.save_preferences()
	to_chat(usr, "You will [(prefs.disable_vocal_sounds) ? "no longer" : "now"] hear vocal sounds from other players.")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Vocal Sounds", "[(prefs.disable_vocal_sounds) ? "Disabled" : "Enabled"]"))
