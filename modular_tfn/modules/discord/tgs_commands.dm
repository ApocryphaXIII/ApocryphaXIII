/datum/tgs_chat_command/tgscheck
	name = "check"
	help_text = "Gets the playercount, gamemode, and address of the server"

/datum/tgs_chat_command/tgscheck/Run(datum/tgs_chat_user/sender, params)
	var/server = "byond://37.27.129.146:1337" // APOC EDIT CHANGE - grrr tfn
	return new /datum/tgs_message_content("[GLOB.round_id ? "Round #[GLOB.round_id] ([ROUND_TIME()]): " : "([ROUND_TIME()]): "]Players: [length(GLOB.clients)] (Active: [get_active_player_count(0,1,0)]), Map: [SSmapping.config.map_name], Round [SSticker.HasRoundStarted() ? (SSticker.IsRoundInProgress() ? "Active" : "Finishing") : "Starting/Delayed"] -- Join now! [server]") // APOC EDIT CHANGE - grrr tfn

/datum/tgs_chat_command/gameversion
	name = "gameversion"
	help_text = "Gets the version details from the show-server-revision verb, basically"

/datum/tgs_chat_command/gameversion/Run(datum/tgs_chat_user/sender, params)
	var/list/msg = list("")
	msg += "BYOND Server Version: [world.byond_version].[world.byond_build] (Compiled with: [DM_VERSION].[DM_BUILD])\n"

	if (!GLOB.revdata)
		msg += "No revision information found."
	else
		msg += "Revision [copytext_char(GLOB.revdata.commit, 1, 9)]"
		if (GLOB.revdata.date)
			msg += " compiled on '[GLOB.revdata.date]'"

		if(GLOB.revdata.originmastercommit)
			msg += ", from origin commit: <[CONFIG_GET(string/githuburl)]/commit/[GLOB.revdata.originmastercommit]>"

		if(GLOB.revdata.testmerge.len)
			msg += "\n"
			for(var/datum/tgs_revision_information/test_merge/PR as anything in GLOB.revdata.testmerge)
				msg += "PR #[PR.number] at [copytext_char(PR.head_commit, 1, 9)] [PR.title].\n"
				if (PR.url)
					msg += "<[PR.url]>\n"
	return new /datum/tgs_message_content(msg.Join(""))

// Notify
/datum/tgs_chat_command/notify
	name = "notify"
	help_text = "Pings the invoker when the round ends"

/datum/tgs_chat_command/notify/Run(datum/tgs_chat_user/sender, params)
	if(!CONFIG_GET(string/chat_announce_new_game))
		return new /datum/tgs_message_content("Notifcations are currently disabled")

	for(var/member in SSdiscord.notify_members) // If they are in the list, take them out
		if(member == sender.mention)
			SSdiscord.notify_members -= sender.mention
			return new /datum/tgs_message_content("You will no longer be notified when the server restarts")

	// If we got here, they arent in the list. Chuck 'em in!
	SSdiscord.notify_members += sender.mention
	return new /datum/tgs_message_content("You will now be notified when the server restarts")

// APOC EDIT START - obviously // fangfuckies :3
/datum/tgs_chat_command/fangfuckies // Friend
	name = "fangfuckies"
	help_text = "Posts a random biting gif (0.1% chance for an ultra-rare bonus gif.)"

/datum/tgs_chat_command/fangfuckies/Run(datum/tgs_chat_user/sender, params)
	var/random_image = splittext(CONFIG_GET(string/bite_img_list), ", ") // comma + space delimiter
	if(prob(0.1))
		return new /datum/tgs_message_content("https://images2.imgbox.com/de/57/LouUHBzY_o.gif") // sneefer

	return new /datum/tgs_message_content("[pick(random_image)]")
// APOC EDIT END
