#define HARMONIC_REGEN_BOOST 0.1

/datum/component/nanites
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

	var/mob/living/host_mob
	var/nanite_volume = 100		//amount of nanites in the system, used as fuel for nanite programs
	var/max_nanites = 500		//maximum amount of nanites in the system
	var/regen_rate = 0.5		//nanites generated per second
	var/safety_threshold = 50	//how low nanites will get before they stop processing/triggering
	var/cloud_id = 0 			//0 if not connected to the cloud, 1-100 to set a determined cloud backup to draw from
	var/cloud_active = TRUE		//if false, won't sync to the cloud
	var/next_sync = 0
	var/list/datum/nanite_program/programs = list()
	var/max_programs = NANITE_PROGRAM_LIMIT

	var/list/datum/nanite_program/protocol/protocols = list() ///Separate list of protocol programs, to avoid looping through the whole programs list when cheking for conflicts
	var/start_time = 0 ///Timestamp to when the nanites were first inserted in the host
	var/stealth = FALSE //if TRUE, does not appear on HUDs and health scans
	var/diagnostics = FALSE //if TRUE, displays program list when scanned by nanite scanners

/datum/component/nanites/Initialize(amount = 100, cloud = 0)
	if(!isliving(parent) && !istype(parent, /datum/nanite_cloud_backup))
		return COMPONENT_INCOMPATIBLE

	nanite_volume = amount
	cloud_id = cloud

	//Nanites without hosts are non-interactive through normal means
	if(isliving(parent))
		host_mob = parent

		if(!(host_mob.mob_biotypes & (MOB_ORGANIC|MOB_UNDEAD))) //Shouldn't happen, but this avoids HUD runtimes in case a silicon gets them somehow.
			return COMPONENT_INCOMPATIBLE

		start_time = world.time

		host_mob.hud_set_nanite_indicator()
		START_PROCESSING(SSnanites, src)

		if(cloud_id && cloud_active)
			cloud_sync()

/datum/component/nanites/RegisterWithParent()
	RegisterSignal(parent, COMSIG_HAS_NANITES, PROC_REF(confirm_nanites))
	RegisterSignal(parent, COMSIG_NANITE_IS_STEALTHY, PROC_REF(check_stealth))
	RegisterSignal(parent, COMSIG_NANITE_DELETE, PROC_REF(delete_nanites))
	RegisterSignal(parent, COMSIG_NANITE_UI_DATA, PROC_REF(nanite_ui_data))
	RegisterSignal(parent, COMSIG_NANITE_GET_PROGRAMS, PROC_REF(get_programs))
	RegisterSignal(parent, COMSIG_NANITE_SET_VOLUME, PROC_REF(set_volume))
	RegisterSignal(parent, COMSIG_NANITE_ADJUST_VOLUME, PROC_REF(adjust_nanites))
	RegisterSignal(parent, COMSIG_NANITE_SET_MAX_VOLUME, PROC_REF(set_max_volume))
	RegisterSignal(parent, COMSIG_NANITE_SET_CLOUD, PROC_REF(set_cloud))
	RegisterSignal(parent, COMSIG_NANITE_SET_CLOUD_SYNC, PROC_REF(set_cloud_sync))
	RegisterSignal(parent, COMSIG_NANITE_SET_SAFETY, PROC_REF(set_safety))
	RegisterSignal(parent, COMSIG_NANITE_SET_REGEN, PROC_REF(set_regen))
	RegisterSignal(parent, COMSIG_NANITE_ADD_PROGRAM, PROC_REF(add_program))
	RegisterSignal(parent, COMSIG_NANITE_SCAN, PROC_REF(nanite_scan))
	RegisterSignal(parent, COMSIG_NANITE_SYNC, PROC_REF(sync))

	if(isliving(parent))
		RegisterSignal(parent, COMSIG_ATOM_EMP_ACT, PROC_REF(on_emp))
		RegisterSignal(parent, COMSIG_LIVING_DEATH, PROC_REF(on_death))
		RegisterSignal(parent, COMSIG_MOB_ALLOWED, PROC_REF(check_access))
		RegisterSignal(parent, COMSIG_LIVING_ELECTROCUTE_ACT, PROC_REF(on_shock))
		RegisterSignal(parent, COMSIG_LIVING_MINOR_SHOCK, PROC_REF(on_minor_shock))
		RegisterSignal(parent, COMSIG_SPECIES_GAIN, PROC_REF(check_viable_biotype))
		RegisterSignal(parent, COMSIG_NANITE_SIGNAL, PROC_REF(receive_signal))
		RegisterSignal(parent, COMSIG_NANITE_COMM_SIGNAL, PROC_REF(receive_comm_signal))

/datum/component/nanites/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_HAS_NANITES,
								COMSIG_NANITE_IS_STEALTHY,
								COMSIG_NANITE_DELETE,
								COMSIG_NANITE_UI_DATA,
								COMSIG_NANITE_GET_PROGRAMS,
								COMSIG_NANITE_SET_VOLUME,
								COMSIG_NANITE_ADJUST_VOLUME,
								COMSIG_NANITE_SET_MAX_VOLUME,
								COMSIG_NANITE_SET_CLOUD,
								COMSIG_NANITE_SET_CLOUD_SYNC,
								COMSIG_NANITE_SET_SAFETY,
								COMSIG_NANITE_SET_REGEN,
								COMSIG_NANITE_ADD_PROGRAM,
								COMSIG_NANITE_SCAN,
								COMSIG_NANITE_SYNC,
								COMSIG_ATOM_EMP_ACT,
								COMSIG_LIVING_DEATH,
								COMSIG_MOB_ALLOWED,
								COMSIG_LIVING_ELECTROCUTE_ACT,
								COMSIG_LIVING_MINOR_SHOCK,
								COMSIG_MOVABLE_HEAR,
								COMSIG_SPECIES_GAIN,
								COMSIG_NANITE_SIGNAL,
								COMSIG_NANITE_COMM_SIGNAL))

/datum/component/nanites/Destroy()
	STOP_PROCESSING(SSnanites, src)
	QDEL_LIST(programs)
	if(host_mob)
		set_nanite_bar(TRUE)
		host_mob.hud_set_nanite_indicator()
	host_mob = null
	return ..()

/datum/component/nanites/InheritComponent(datum/component/nanites/new_nanites, i_am_original, amount, cloud)
	if(new_nanites)
		adjust_nanites(null, new_nanites.nanite_volume)
	else
		adjust_nanites(null, amount) //just add to the nanite volume

/datum/component/nanites/process(delta_time)
	if(!IS_IN_STASIS(host_mob))
		adjust_nanites(null, (regen_rate + (SSresearch.science_tech.researched_nodes["nanite_harmonic"] ? HARMONIC_REGEN_BOOST : 0)) * delta_time)
		add_research()
		for(var/X in programs)
			var/datum/nanite_program/NP = X
			NP.on_process()
		if(cloud_id && cloud_active && world.time > next_sync)
			cloud_sync()
			next_sync = world.time + NANITE_SYNC_DELAY
	set_nanite_bar()

///Deletes nanites!
/datum/component/nanites/proc/delete_nanites()
	SIGNAL_HANDLER

	qdel(src)

///Syncs the nanite component to another, making it so programs are the same with the same programming (except activation status)
/datum/component/nanites/proc/sync(datum/signal_source, datum/component/nanites/source, full_overwrite = TRUE, copy_activation = FALSE)
	SIGNAL_HANDLER

	var/list/programs_to_remove = programs.Copy()
	var/list/programs_to_add = source.programs.Copy()
	for(var/X in programs)
		var/datum/nanite_program/NP = X
		for(var/Y in programs_to_add)
			var/datum/nanite_program/SNP = Y
			if(NP.type == SNP.type)
				programs_to_remove -= NP
				programs_to_add -= SNP
				SNP.copy_programming(NP, copy_activation)
				break
	if(full_overwrite)
		for(var/X in programs_to_remove)
			qdel(X)
	for(var/X in programs_to_add)
		var/datum/nanite_program/SNP = X
		add_program(null, SNP.copy())

///Syncs the nanites to their assigned cloud copy, if it is available. If it is not, there is a small chance of a software error instead.
/datum/component/nanites/proc/cloud_sync()
	if(cloud_id)
		var/datum/nanite_cloud_backup/backup = SSnanites.get_cloud_backup(cloud_id)
		if(backup)
			var/datum/component/nanites/cloud_copy = backup.nanites
			if(cloud_copy)
				sync(null, cloud_copy)
				return
	//Without cloud syncing nanites can accumulate errors and/or defects
	if(prob(8) && programs.len)
		var/datum/nanite_program/NP = pick(programs)
		NP.software_error()

///Adds a nanite program, replacing existing unique programs of the same type. A source program can be specified to copy its programming onto the new one.
/datum/component/nanites/proc/add_program(datum/source, datum/nanite_program/new_program, datum/nanite_program/source_program)
	SIGNAL_HANDLER

	for(var/X in programs)
		var/datum/nanite_program/NP = X
		if(NP.unique && NP.type == new_program.type)
			qdel(NP)
	if(programs.len >= max_programs)
		return COMPONENT_PROGRAM_NOT_INSTALLED
	if(source_program)
		source_program.copy_programming(new_program)
	programs += new_program
	new_program.on_add(src)
	return COMPONENT_PROGRAM_INSTALLED

/datum/component/nanites/proc/consume_nanites(amount, force = FALSE)
	if(!force && safety_threshold && (nanite_volume - amount < safety_threshold))
		return FALSE
	adjust_nanites(null, -amount)
	return (nanite_volume > 0)

///Modifies the current nanite volume, then checks if the nanites are depleted or exceeding the maximum amount
/datum/component/nanites/proc/adjust_nanites(datum/source, amount)
	SIGNAL_HANDLER

	nanite_volume += amount
	if(nanite_volume > max_nanites)
		reject_excess_nanites()
	if(nanite_volume <= 0) //oops we ran out
		qdel(src)

/**
 *	Handles how nanites leave the host's body if they find out that they're currently exceeding the maximum supported amount
 *
 * IC explanation:
 * Normally nanites simply discard excess volume by slowing replication or 'sweating' it out in imperceptible amounts,
 * but if there is a large excess volume, likely due to a programming change that leaves them unable to support their current volume,
 * the nanites attempt to leave the host as fast as necessary to prevent nanite poisoning. This can range from minor oozing to nanites
 * rapidly bursting out from every possible pathway, causing temporary inconvenience to the host.
 */
/datum/component/nanites/proc/reject_excess_nanites()
	var/excess = nanite_volume - max_nanites
	nanite_volume = max_nanites

	switch(excess)
		if(0 to NANITE_EXCESS_MINOR) //Minor excess amount, the extra nanites are quietly expelled without visible effects
			return
		if((NANITE_EXCESS_MINOR + 0.1) to NANITE_EXCESS_VOMIT) //Enough nanites getting rejected at once to be visible to the naked eye
			host_mob.visible_message("<span class='warning'>A grainy grey slurry starts oozing out of [host_mob].</span>", "<span class='warning'>A grainy grey slurry starts oozing out of your skin.</span>", null, 4);
		if((NANITE_EXCESS_VOMIT + 0.1) to NANITE_EXCESS_BURST) //Nanites getting rejected in massive amounts, but still enough to make a semi-orderly exit through vomit
			if(iscarbon(host_mob))
				var/mob/living/carbon/C = host_mob
				host_mob.visible_message("<span class='warning'>[host_mob] vomits a grainy grey slurry!</span>", "<span class='warning'>You suddenly vomit a metallic-tasting grainy grey slurry!</span>", null);
				C.vomit(0, FALSE, TRUE, FLOOR(excess / 100, 1), FALSE, VOMIT_NANITE, FALSE, TRUE, 0)
			else
				host_mob.visible_message("<span class='warning'>A metallic grey slurry bursts out of [host_mob]'s skin!</span>", "<span class='userdanger'>A metallic grey slurry violently bursts out of your skin!</span>", null);
				if(isturf(host_mob.drop_location()))
					var/turf/T = host_mob.drop_location()
					T.add_vomit_floor(host_mob, VOMIT_NANITE, 0)
		if((NANITE_EXCESS_BURST + 0.1) to INFINITY) //Way too many nanites, they just leave through the closest exit before they harm/poison the host
			host_mob.visible_message("<span class='warning'>A torrent of metallic grey slurry violently bursts out of [host_mob]'s face and floods out of [host_mob.p_their()] skin!</span>",
								"<span class='userdanger'>A torrent of metallic grey slurry violently bursts out of your eyes, ears, and mouth, and floods out of your skin!</span>");

			host_mob.blind_eyes(15) //nanites coming out of your eyes
			host_mob.Paralyze(120)
			if(iscarbon(host_mob))
				var/mob/living/carbon/C = host_mob
				var/obj/item/organ/ears/ears = C.getorganslot(ORGAN_SLOT_EARS)
				if(ears)
					ears.adjustEarDamage(0, 30) //nanites coming out of your ears
				C.vomit(0, FALSE, TRUE, 2, FALSE, VOMIT_NANITE, FALSE, TRUE, 0) //nanites coming out of your mouth

			//nanites everywhere
			if(isturf(host_mob.drop_location()))
				var/turf/T = host_mob.drop_location()
				T.add_vomit_floor(host_mob, VOMIT_NANITE, 0)
				for(var/turf/adjacent_turf in oview(host_mob, 1))
					if(adjacent_turf.density || !adjacent_turf.Adjacent(T))
						continue
					adjacent_turf.add_vomit_floor(host_mob, VOMIT_NANITE, 0)

///Updates the nanite volume bar visible in diagnostic HUDs
/datum/component/nanites/proc/set_nanite_bar(remove = FALSE)
	var/image/holder = host_mob.hud_list[DIAG_NANITE_FULL_HUD]
	var/icon/I = icon(host_mob.icon, host_mob.icon_state, host_mob.dir)
	holder.pixel_y = I.Height() - world.icon_size
	holder.icon_state = null
	if(remove || stealth)
		return //bye icon
	var/nanite_percent = (nanite_volume / max_nanites) * 100
	nanite_percent = clamp(CEILING(nanite_percent, 10), 10, 100)
	holder.icon_state = "nanites[nanite_percent]"

/datum/component/nanites/proc/on_emp(datum/source, severity)
	SIGNAL_HANDLER

	nanite_volume *= (rand(60, 90) * 0.01)		//Lose 10-40% of nanites
	adjust_nanites(null, -(rand(5, 50)))		//Lose 5-50 flat nanite volume
	if(prob(40/severity))
		cloud_id = 0
	for(var/X in programs)
		var/datum/nanite_program/NP = X
		NP.on_emp(severity)


/datum/component/nanites/proc/on_shock(datum/source, shock_damage, siemens_coeff = 1, flags = NONE)
	SIGNAL_HANDLER

	if(flags & SHOCK_ILLUSION || shock_damage < 1)
		return

	if(!HAS_TRAIT_NOT_FROM(host_mob, TRAIT_SHOCKIMMUNE, "nanites"))//Another shock protection must protect nanites too, but nanites protect only host
		nanite_volume *= (rand(45, 80) * 0.01)		//Lose 20-55% of nanites
		adjust_nanites(null, -(rand(5, 50)))			//Lose 5-50 flat nanite volume
		for(var/X in programs)
			var/datum/nanite_program/NP = X
			NP.on_shock(shock_damage)

/datum/component/nanites/proc/on_minor_shock(datum/source)
	SIGNAL_HANDLER

	adjust_nanites(null, -(rand(5, 15)))			//Lose 5-15 flat nanite volume
	for(var/X in programs)
		var/datum/nanite_program/NP = X
		NP.on_minor_shock()

/datum/component/nanites/proc/check_stealth(datum/source)
	SIGNAL_HANDLER

	return stealth

/datum/component/nanites/proc/on_death(datum/source, gibbed)
	SIGNAL_HANDLER

	for(var/X in programs)
		var/datum/nanite_program/NP = X
		NP.on_death(gibbed)

/datum/component/nanites/proc/receive_signal(datum/source, code, comm_source = "an unidentified source")
	SIGNAL_HANDLER

	for(var/X in programs)
		var/datum/nanite_program/NP = X
		NP.receive_signal(code, comm_source)

/datum/component/nanites/proc/receive_comm_signal(datum/source, comm_code, comm_message, comm_source = "an unidentified source")
	SIGNAL_HANDLER

	for(var/X in programs)
		if(istype(X, /datum/nanite_program/comm))
			var/datum/nanite_program/comm/NP = X
			NP.receive_comm_signal(comm_code, comm_message, comm_source)

/datum/component/nanites/proc/check_viable_biotype()
	SIGNAL_HANDLER

	if(!(host_mob.mob_biotypes & (MOB_ORGANIC|MOB_UNDEAD)))
		qdel(src) //bodytype no longer sustains nanites

/datum/component/nanites/proc/check_access(datum/source, obj/O)
	SIGNAL_HANDLER

	for(var/datum/nanite_program/access/access_program in programs)
		if(access_program.activated)
			return O.check_access_list(access_program.access)
		else
			return FALSE
	return FALSE

/datum/component/nanites/proc/set_volume(datum/source, amount)
	SIGNAL_HANDLER

	nanite_volume = clamp(amount, 0, max_nanites)

/datum/component/nanites/proc/set_max_volume(datum/source, amount)
	SIGNAL_HANDLER

	max_nanites = max(1, amount)

/datum/component/nanites/proc/set_cloud(datum/source, amount)
	SIGNAL_HANDLER

	cloud_id = clamp(amount, 0, 100)

/datum/component/nanites/proc/set_cloud_sync(datum/source, method)
	SIGNAL_HANDLER

	switch(method)
		if(NANITE_CLOUD_TOGGLE)
			cloud_active = !cloud_active
		if(NANITE_CLOUD_DISABLE)
			cloud_active = FALSE
		if(NANITE_CLOUD_ENABLE)
			cloud_active = TRUE

/datum/component/nanites/proc/set_safety(datum/source, amount)
	SIGNAL_HANDLER

	safety_threshold = clamp(amount, 0, max_nanites)

/datum/component/nanites/proc/set_regen(datum/source, amount)
	SIGNAL_HANDLER

	regen_rate = amount

/datum/component/nanites/proc/confirm_nanites()
	SIGNAL_HANDLER

	return TRUE //yup i exist

/datum/component/nanites/proc/get_programs(datum/source, list/nanite_programs)
	SIGNAL_HANDLER

	nanite_programs |= programs

/datum/component/nanites/proc/add_research()
	var/research_value = NANITE_BASE_RESEARCH
	if(!ishuman(host_mob))
		if(!iscarbon(host_mob))
			research_value *= 0.4
		else
			research_value *= 0.8
	if(!host_mob.client)
		research_value *= 0.5
	if(host_mob.stat == DEAD)
		research_value *= 0.75
	SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_NANITES = research_value))

/datum/component/nanites/proc/nanite_scan(datum/source, mob/user, full_scan)
	SIGNAL_HANDLER

	if(!full_scan)
		if(!stealth)
			to_chat(user, "<span class='notice'><b>Nanites Detected</b></span>")
			to_chat(user, "<span class='notice'>Saturation: [nanite_volume]/[max_nanites]</span>")
			return TRUE
	else
		to_chat(user, "<span class='info'>NANITES DETECTED</span>")
		to_chat(user, "<span class='info'>================</span>")
		to_chat(user, "<span class='info'>Saturation: [nanite_volume]/[max_nanites]</span>")
		to_chat(user, "<span class='info'>Safety Threshold: [safety_threshold]</span>")
		to_chat(user, "<span class='info'>Cloud ID: [cloud_id ? cloud_id : "None"]</span>")
		to_chat(user, "<span class='info'>Cloud Sync: [cloud_active ? "Active" : "Disabled"]</span>")
		to_chat(user, "<span class='info'>================</span>")
		to_chat(user, "<span class='info'>Program List:</span>")
		if(!diagnostics)
			to_chat(user, "<span class='alert'>Nanite debugging disabled.</span>")
		else
			for(var/X in programs)
				var/datum/nanite_program/NP = X
				to_chat(user, "<span class='info'><b>[NP.name]</b> | [NP.activated ? "Active" : "Inactive"]</span>")
		return TRUE

/datum/component/nanites/proc/nanite_ui_data(datum/source, list/data, scan_level)
	SIGNAL_HANDLER

	data["has_nanites"] = TRUE
	data["nanite_volume"] = nanite_volume
	data["regen_rate"] = regen_rate + (SSresearch.science_tech.researched_nodes["nanite_harmonic"] ? HARMONIC_REGEN_BOOST : 0)
	data["safety_threshold"] = safety_threshold
	data["cloud_id"] = cloud_id
	data["cloud_active"] = cloud_active
	var/list/mob_programs = list()
	var/id = 1
	for(var/X in programs)
		var/datum/nanite_program/P = X
		var/list/mob_program = list()
		mob_program["name"] = P.name
		mob_program["desc"] = P.desc
		mob_program["id"] = id

		if(scan_level >= 2)
			mob_program["activated"] = P.activated
			mob_program["use_rate"] = P.use_rate
			mob_program["can_trigger"] = P.can_trigger
			mob_program["trigger_cost"] = P.trigger_cost
			mob_program["trigger_cooldown"] = P.trigger_cooldown / 10

		if(scan_level >= 3)
			mob_program["timer_restart"] = P.timer_restart / 10
			mob_program["timer_shutdown"] = P.timer_shutdown / 10
			mob_program["timer_trigger"] = P.timer_trigger / 10
			mob_program["timer_trigger_delay"] = P.timer_trigger_delay / 10
			var/list/extra_settings = P.get_extra_settings_frontend()
			mob_program["extra_settings"] = extra_settings
			if(LAZYLEN(extra_settings))
				mob_program["has_extra_settings"] = TRUE
			else
				mob_program["has_extra_settings"] = FALSE

		if(scan_level >= 4)
			mob_program["activation_code"] = P.activation_code
			mob_program["deactivation_code"] = P.deactivation_code
			mob_program["kill_code"] = P.kill_code
			mob_program["trigger_code"] = P.trigger_code
			var/list/rules = list()
			var/rule_id = 1
			for(var/Z in P.rules)
				var/datum/nanite_rule/nanite_rule = Z
				var/list/rule = list()
				rule["display"] = nanite_rule.display()
				rule["program_id"] = id
				rule["id"] = rule_id
				rules += list(rule)
				rule_id++
			mob_program["rules"] = rules
			if(LAZYLEN(rules))
				mob_program["has_rules"] = TRUE
		id++
		mob_programs += list(mob_program)
	data["mob_programs"] = mob_programs

#undef HARMONIC_REGEN_BOOST
