#define WHITELISTFILE "[global.config.directory]/whitelist.txt"

GLOBAL_LIST(whitelist)
GLOBAL_PROTECT(whitelist)

/proc/load_whitelist()
	GLOB.whitelist = list()
	for(var/line in world.file2list(WHITELISTFILE))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		GLOB.whitelist += ckey(line)

	if(!GLOB.whitelist.len)
		GLOB.whitelist = null

/proc/check_whitelist(ckey)
	if(!GLOB.whitelist)
		return FALSE
	. = (ckey in GLOB.whitelist)

//Whitelists players by adding them to the glob AND the txt so they are whitelisted for this round and all rounds after
/proc/whitelist_ckey(input_ckey)
	if(!check_rights(R_ADMIN))
		return
	// The ckey proc "santizies" it to be its "true" form
	var/canon_ckey = ckey(input_ckey)
	// Dont add them to the whitelist if they are already in it
	if(canon_ckey in GLOB.whitelist)
		return

	GLOB.whitelist += canon_ckey
	rustg_file_append(input_ckey, WHITELISTFILE)

	message_admins("[input_ckey] has been whitelisted by [usr]")

#undef WHITELISTFILE
