GLOBAL_LIST_EMPTY(loadout_categories)
GLOBAL_LIST_EMPTY(gear_datums)

/datum/loadout_category
	var/category = ""
	var/list/gear = list()

/datum/loadout_category/New(cat)
	category = cat
	..()

///Create a list of gear datums to sort
/proc/populate_gear_list()
	for(var/geartype in subtypesof(/datum/gear))
		var/datum/gear/G = geartype

		var/use_name = initial(G.display_name)
		var/use_category = initial(G.sort_category)

		if(G == initial(G.subtype_path))
			continue

		if(!use_name && initial(G.path))
			WARNING("Loadout gear [G] is missing display name")
			continue
		if(!initial(G.cost))
			WARNING("Loadout - Missing cost: [G]")
			continue
		if(!initial(G.path))
			WARNING("Loadout gear [G] is missing path definition")
			continue

		if(!GLOB.loadout_categories[use_category])
			GLOB.loadout_categories[use_category] = new /datum/loadout_category(use_category)
		var/datum/loadout_category/LC = GLOB.loadout_categories[use_category]
		GLOB.gear_datums[use_name] = new geartype
		LC.gear[use_name] = GLOB.gear_datums[use_name]

	GLOB.loadout_categories = sortAssoc(GLOB.loadout_categories)
	for(var/loadout_category in GLOB.loadout_categories)
		var/datum/loadout_category/LC = GLOB.loadout_categories[loadout_category]
		LC.gear = sortAssoc(LC.gear)
	return 1

/datum/gear
	///Name/index. Must be unique.
	var/display_name
	///Description of this gear. If left blank will default to the description of the pathed item.
	var/description
	///Path to item.
	var/path
	///Cost to purchase
	var/cost = 0
	///Slot to equip to.
	var/slot
	///Roles that can spawn with this item.
	var/list/allowed_roles
	///Stop certain species from receiving this gear
	var/list/species_blacklist
	///Only allow certain species to receive this gear
	var/list/species_whitelist
	///A list of jobs with typepaths to the loadout item the job should receive
	var/list/role_replacements
	///The sub tab under gear that the loadout item is listed under
	var/sort_category = "General"
	///for skipping organizational subtypes (optional)
	var/subtype_path = /datum/gear

/datum/gear/New()
	..()
	if(!description)
		var/obj/O = path
		description = initial(O.desc)

///Called when the gear is first purchased
/datum/gear/proc/purchase(client/C)
	return

/datum/gear_data
	var/path
	var/location

/datum/gear_data/New(npath, nlocation)
	path = npath
	location = nlocation

/datum/gear/proc/spawn_item(location, mob/owner)
	var/datum/gear_data/gd
	if(role_replacements) //If the owner is a carbon and the item in question has a role replacement
		var/job = owner.job || owner.mind?.assigned_role
		if(job in role_replacements) //If the job has an applicable replacement
			gd = new(role_replacements[job], location)
			return new gd.path(gd.location)

	gd = new(path, location) //Else, just give them the item and be done with it

	return new gd.path(gd.location)
