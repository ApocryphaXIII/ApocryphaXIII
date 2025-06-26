/// The subsystem used to play ambience to users every now and then, makes them real excited.
SUBSYSTEM_DEF(ambience)
	name = "Ambience"
	flags = SS_BACKGROUND|SS_NO_INIT
	priority = FIRE_PRIORITY_AMBIENCE
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 1 SECONDS
	///Assoc list of listening client - next ambience time
	var/list/ambience_listening_clients = list()
	///Assoc list of listening client - next track time
	var/list/track_listening_clients = list()

/datum/controller/subsystem/ambience/fire(resumed)
	//Ambience
	for(var/client/client_iterator as anything in ambience_listening_clients)

		//Check to see if the client exists and isn't held by a new player
		var/mob/client_mob = client_iterator?.mob

		if(isnull(client_iterator))
			ambience_listening_clients -= client_iterator
			continue

		// We dont want ambience playing in the lobby but its is also prob more efficent then having to readd every player to the list.
		if(isnewplayer(client_iterator.mob))
			continue

		if(ambience_listening_clients[client_iterator] > world.time)
			continue //Not ready for the next sound

		var/area/current_area = get_area(client_iterator.mob)

		ambience_listening_clients[client_iterator] = world.time + current_area.play_ambience(client_mob)

	//Music. Yes.. in the ambience subsystem. Did not feel like it deserved its own.
	for(var/client/client_iterator as anything in track_listening_clients)

		//Check to see if the client exists and isn't held by a new player
		var/mob/client_mob = client_iterator?.mob

		if(isnull(client_iterator))
			track_listening_clients -= client_iterator
			continue

		// We dont want ambience playing in the lobby but its is also prob more efficent then having to readd every player to the list.
		if(isnewplayer(client_iterator.mob))
			continue

		if(track_listening_clients[client_iterator] > world.time)
			continue //Not ready for the next sound

		var/area/current_area = get_area(client_iterator.mob)

		track_listening_clients[client_iterator] = world.time + current_area.play_music(client_mob)

///Attempts to play an ambient sound to a mob, returning the cooldown in deciseconds
/area/proc/play_ambience(mob/M, sound/override_sound, volume = 27)
	var/sound/new_sound = override_sound || pick(ambientsounds)

	if(!new_sound) //We didnt come up with a sound, try again in 30 seconds
		return 30 SECONDS
	new_sound = sound(new_sound, repeat = 0, wait = 0, volume = volume, channel = CHANNEL_AMBIENCE)

	SEND_SOUND(M, new_sound)

	var/sound_length = ceil(SSsound_cache.get_sound_length(new_sound.file))
	return rand(min_ambience_cooldown + sound_length, max_ambience_cooldown + sound_length)

///Attempts to play a non-diagetic music track to a mob, returning the cooldown in deciseconds
/area/proc/play_music(mob/M, sound/override_sound, volume = 27)
	var/sound/new_sound = override_sound || pick(musictracks)

	//An admin played song is going or recently finished
	if(!COOLDOWN_FINISHED(GLOB, web_sound_cooldown))
		return COOLDOWN_TIMELEFT(GLOB, web_sound_cooldown) + (30 SECONDS)

	if(!new_sound)
		return 30 SECONDS

	new_sound = sound(new_sound, repeat = 0, wait = 0, volume = volume, channel = CHANNEL_MUSIC_TRACKS)

	SEND_SOUND(M, new_sound)

	var/sound_length = ceil(SSsound_cache.get_sound_length(new_sound.file))
	return rand(min_music_cooldown + sound_length, max_music_cooldown + sound_length)
