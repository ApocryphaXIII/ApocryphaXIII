/datum/plant_gene
	var/name
	var/mutability_flags = PLANT_GENE_EXTRACTABLE | PLANT_GENE_REMOVABLE ///These flags tells the genemodder if we want the gene to be extractable, only removable or neither.

/datum/plant_gene/proc/get_name() // Used for manipulator display and gene disk name.
	var/formatted_name
	if(!(mutability_flags & PLANT_GENE_REMOVABLE && mutability_flags & PLANT_GENE_EXTRACTABLE))
		if(mutability_flags & PLANT_GENE_REMOVABLE)
			formatted_name += "Fragile "
		else if(mutability_flags & PLANT_GENE_EXTRACTABLE)
			formatted_name += "Essential "
		else
			formatted_name += "Immutable "
	formatted_name += name
	return formatted_name

/datum/plant_gene/proc/can_add(obj/item/seeds/S)
	return !istype(S, /obj/item/seeds/sample) // Samples can't accept new genes

/datum/plant_gene/proc/Copy()
	var/datum/plant_gene/G = new type
	G.mutability_flags = mutability_flags
	return G

/datum/plant_gene/proc/apply_vars(obj/item/seeds/S) // currently used for fire resist, can prob. be further refactored
	return

// Core plant genes store 5 main variables: lifespan, endurance, production, yield, potency
/datum/plant_gene/core
	var/value

/datum/plant_gene/core/get_name()
	return "[name] [value]"

/datum/plant_gene/core/proc/apply_stat(obj/item/seeds/S)
	return

/datum/plant_gene/core/New(i = null)
	..()
	if(!isnull(i))
		value = i

/datum/plant_gene/core/Copy()
	var/datum/plant_gene/core/C = ..()
	C.value = value
	return C

/datum/plant_gene/core/can_add(obj/item/seeds/S)
	if(!..())
		return FALSE
	return S.get_gene(src.type)

/datum/plant_gene/core/lifespan
	name = "Lifespan"
	value = 25

/datum/plant_gene/core/lifespan/apply_stat(obj/item/seeds/S)
	S.lifespan = value


/datum/plant_gene/core/endurance
	name = "Endurance"
	value = 15

/datum/plant_gene/core/endurance/apply_stat(obj/item/seeds/S)
	S.endurance = value


/datum/plant_gene/core/production
	name = "Production Speed"
	value = 6

/datum/plant_gene/core/production/apply_stat(obj/item/seeds/S)
	S.production = value


/datum/plant_gene/core/yield
	name = "Yield"
	value = 3

/datum/plant_gene/core/yield/apply_stat(obj/item/seeds/S)
	S.yield = value


/datum/plant_gene/core/potency
	name = "Potency"
	value = 10

/datum/plant_gene/core/potency/apply_stat(obj/item/seeds/S)
	S.potency = value

/datum/plant_gene/core/instability
	name = "Stability"
	value = 10

/datum/plant_gene/core/instability/apply_stat(obj/item/seeds/S)
	S.instability = value

/datum/plant_gene/core/weed_rate
	name = "Weed Growth Rate"
	value = 1

/datum/plant_gene/core/weed_rate/apply_stat(obj/item/seeds/S)
	S.weed_rate = value


/datum/plant_gene/core/weed_chance
	name = "Weed Vulnerability"
	value = 5

/datum/plant_gene/core/weed_chance/apply_stat(obj/item/seeds/S)
	S.weed_chance = value


// Reagent genes store reagent ID and reagent ratio. Amount of reagent in the plant = 1 + (potency * rate)
/datum/plant_gene/reagent
	name = "Nutriment"
	var/reagent_id = /datum/reagent/consumable/nutriment
	var/rate = 0.04

/datum/plant_gene/reagent/get_name()
	var/formatted_name
	if(!(mutability_flags & PLANT_GENE_REMOVABLE && mutability_flags & PLANT_GENE_EXTRACTABLE))
		if(mutability_flags & PLANT_GENE_REMOVABLE)
			formatted_name += "Fragile "
		else if(mutability_flags & PLANT_GENE_EXTRACTABLE)
			formatted_name += "Essential "
		else
			formatted_name += "Immutable "
	formatted_name += "[name] production [rate*100]%"
	return formatted_name

/datum/plant_gene/reagent/proc/set_reagent(reag_id)
	reagent_id = reag_id
	name = "UNKNOWN"

	var/datum/reagent/R = GLOB.chemical_reagents_list[reag_id]
	if(R && R.type == reagent_id)
		name = R.name

/datum/plant_gene/reagent/New(reag_id = null, reag_rate = 0)
	..()
	if(reag_id && reag_rate)
		set_reagent(reag_id)
		rate = reag_rate

/datum/plant_gene/reagent/Copy()
	var/datum/plant_gene/reagent/G = ..()
	G.name = name
	G.reagent_id = reagent_id
	G.rate = rate
	return G

/datum/plant_gene/reagent/can_add(obj/item/seeds/S)
	if(!..())
		return FALSE
	for(var/datum/plant_gene/reagent/R in S.genes)
		if(R.reagent_id == reagent_id && R.rate <= rate)
			return FALSE
	return TRUE

/**
 * Intends to compare a reagent gene with a set of seeds, and if the seeds contain the same gene, with more production rate, upgrades the rate to the highest of the two.
 *
 * Called when plants are crossbreeding, this looks for two matching reagent_ids, where the rates are greater, in order to upgrade.
 */

/datum/plant_gene/reagent/proc/try_upgrade_gene(obj/item/seeds/seed)
	for(var/datum/plant_gene/reagent/reagent in seed.genes)
		if(reagent.reagent_id != reagent_id || reagent.rate <= rate)
			continue
		rate = reagent.rate
		return TRUE
	return FALSE

/datum/plant_gene/reagent/polypyr
	name = "Polypyrylium Oligomers"
	reagent_id = /datum/reagent/medicine/polypyr
	rate = 0.15

/datum/plant_gene/reagent/liquidelectricity
	name = "Liquid Electricity"
	reagent_id = /datum/reagent/consumable/liquidelectricity
	rate = 0.1

// Various traits affecting the product.
/datum/plant_gene/trait
	var/rate = 0.05
	var/examine_line = ""
	var/trait_id // must be set and equal for any two traits of the same type

/datum/plant_gene/trait/Copy()
	var/datum/plant_gene/trait/G = ..()
	G.rate = rate
	return G

/datum/plant_gene/trait/can_add(obj/item/seeds/S)
	if(!..())
		return FALSE

	for(var/datum/plant_gene/trait/R in S.genes)
		if(trait_id && R.trait_id == trait_id)
			return FALSE
		if(type == R.type)
			return FALSE
	return TRUE

/datum/plant_gene/trait/proc/on_new(obj/item/food/grown/G, newloc)
	return

/datum/plant_gene/trait/proc/on_consume(obj/item/food/grown/G, mob/living/carbon/target)
	return

/datum/plant_gene/trait/proc/on_slip(obj/item/food/grown/G, mob/living/carbon/target)
	return

/datum/plant_gene/trait/proc/on_squash(obj/item/food/grown/G, atom/target)
	return

/datum/plant_gene/trait/proc/on_attackby(obj/item/food/grown/G, obj/item/I, mob/user)
	return

/datum/plant_gene/trait/proc/on_throw_impact(obj/item/food/grown/G, atom/target)
	return

///This proc triggers when the tray processes and a roll is sucessful, the success chance scales with production.
/datum/plant_gene/trait/proc/on_grow(obj/machinery/hydroponics/H)
	return

/datum/plant_gene/trait/squash
	// Allows the plant to be squashed when thrown or slipped on, leaving a colored mess and trash type item behind.
	// Also splashes everything in target turf with reagents and applies other trait effects (teleporting, etc) to the target by on_squash.
	// For code, see grown.dm
	name = "Liquid Contents"
	examine_line = "<span class='info'>It has a lot of liquid contents inside.</span>"

/datum/plant_gene/trait/squash/can_add(obj/item/seeds/S)
	if(S.get_gene(/datum/plant_gene/trait/sticky))
		return FALSE
	. = ..()

/datum/plant_gene/trait/squash/on_slip(obj/item/food/grown/G, mob/living/carbon/C)
	// Squash the plant on slip.
	G.squash(C)

/datum/plant_gene/trait/slip
	// Makes plant slippery, unless it has a grown-type trash. Then the trash gets slippery.
	// Applies other trait effects (teleporting, etc) to the target by on_slip.
	name = "Slippery Skin"
	rate = 1.6
	examine_line = "<span class='info'>It has a very slippery skin.</span>"

/datum/plant_gene/trait/slip/on_new(obj/item/food/grown/G, newloc)
	..()
	if(istype(G) && ispath(G.trash_type, /obj/item/grown))
		return
	var/obj/item/seeds/seed = G.seed
	var/stun_len = seed.potency * rate

	if(!istype(G, /obj/item/grown/bananapeel) && (!G.reagents || !G.reagents.has_reagent(/datum/reagent/lube)))
		stun_len /= 3

	G.AddComponent(/datum/component/slippery, min(stun_len,140), NONE, CALLBACK(src, PROC_REF(handle_slip), G))

/datum/plant_gene/trait/slip/proc/handle_slip(obj/item/food/grown/G, mob/M)
	for(var/datum/plant_gene/trait/T in G.seed.genes)
		T.on_slip(G, M)

/datum/plant_gene/trait/cell_charge
	// Cell recharging trait. Charges all mob's power cells to (potency*rate)% mark when eaten.
	// Generates sparks on squash.
	// Small (potency*rate*5) chance to shock squish or slip target for (potency*rate*5) damage.
	// Also affects plant batteries see capatative cell production datum
	name = "Electrical Activity"
	rate = 0.2

/datum/plant_gene/trait/cell_charge/on_slip(obj/item/food/grown/G, mob/living/carbon/C)
	var/power = G.seed.potency*rate
	if(prob(power))
		C.electrocute_act(round(power), G, 1, SHOCK_NOGLOVES)

/datum/plant_gene/trait/cell_charge/on_squash(obj/item/food/grown/G, atom/target)
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		var/power = G.seed.potency*rate
		if(prob(power))
			C.electrocute_act(round(power), G, 1, SHOCK_NOGLOVES)

/datum/plant_gene/trait/cell_charge/on_consume(obj/item/food/grown/G, mob/living/carbon/target)
	if(!G.reagents.total_volume)
		var/batteries_recharged = 0
		for(var/obj/item/stock_parts/cell/C in target.GetAllContents())
			var/newcharge = min(G.seed.potency*0.01*C.maxcharge, C.maxcharge)
			if(C.charge < newcharge)
				C.charge = newcharge
				if(isobj(C.loc))
					var/obj/O = C.loc
					O.update_icon() //update power meters and such
				C.update_icon()
				batteries_recharged = 1
		if(batteries_recharged)
			to_chat(target, "<span class='notice'>Your batteries are recharged!</span>")



/datum/plant_gene/trait/glow
	// Makes plant glow. Makes plant in tray glow too.
	// Adds 1 + potency*rate light range and potency*(rate + 0.01) light_power to products.
	name = "Bioluminescence"
	rate = 0.03
	examine_line = "<span class='info'>It emits a soft glow.</span>"
	trait_id = "glow"
	var/glow_color = "#C3E381"

/datum/plant_gene/trait/glow/proc/glow_range(obj/item/seeds/S)
	return 1.4 + S.potency*rate

/datum/plant_gene/trait/glow/proc/glow_power(obj/item/seeds/S)
	return max(S.potency*(rate + 0.01), 0.1)

/datum/plant_gene/trait/glow/on_new(obj/item/food/grown/G, newloc)
	. = ..()
	G.light_system = MOVABLE_LIGHT
	G.AddComponent(/datum/component/overlay_lighting, glow_range(G.seed), glow_power(G.seed), glow_color)

/datum/plant_gene/trait/glow/shadow
	//makes plant emit slightly purple shadows
	//adds -potency*(rate*0.2) light power to products
	name = "Shadow Emission"
	rate = 0.04
	glow_color = "#AAD84B"

/datum/plant_gene/trait/glow/shadow/glow_power(obj/item/seeds/S)
	return -max(S.potency*(rate*0.2), 0.2)

/datum/plant_gene/trait/glow/white
	name = "White Bioluminescence"
	glow_color = "#FFFFFF"

/datum/plant_gene/trait/glow/red
	//Colored versions of bioluminescence.
	name = "Red Bioluminescence"
	glow_color = "#FF3333"

/datum/plant_gene/trait/glow/yellow
	//not the disgusting glowshroom yellow hopefully
	name = "Yellow Bioluminescence"
	glow_color = "#FFFF66"

/datum/plant_gene/trait/glow/green
	//oh no, now i'm radioactive
	name = "Green Bioluminescence"
	glow_color = "#99FF99"

/datum/plant_gene/trait/glow/blue
	//the best one
	name = "Blue Bioluminescence"
	glow_color = "#6699FF"

/datum/plant_gene/trait/glow/purple
	//did you know that notepad++ doesnt think bioluminescence is a word
	name = "Purple Bioluminescence"
	glow_color = "#D966FF"

/datum/plant_gene/trait/glow/pink
	//gay tide station pride
	name = "Pink Bioluminescence"
	glow_color = "#FFB3DA"



/datum/plant_gene/trait/teleport
	// Makes plant teleport people when squashed or slipped on.
	// Teleport radius is calculated as max(round(potency*rate), 1)
	name = "Bluespace Activity"
	rate = 0.1

/datum/plant_gene/trait/teleport/on_squash(obj/item/food/grown/G, atom/target)
	if(isliving(target))
		var/teleport_radius = max(round(G.seed.potency / 10), 1)
		var/turf/T = get_turf(target)
		new /obj/effect/decal/cleanable/molten_object(T) //Leave a pile of goo behind for dramatic effect...
		do_teleport(target, T, teleport_radius, channel = TELEPORT_CHANNEL_BLUESPACE)

/datum/plant_gene/trait/teleport/on_slip(obj/item/food/grown/G, mob/living/carbon/C)
	var/teleport_radius = max(round(G.seed.potency / 10), 1)
	var/turf/T = get_turf(C)
	to_chat(C, "<span class='warning'>You slip through spacetime!</span>")
	do_teleport(C, T, teleport_radius, channel = TELEPORT_CHANNEL_BLUESPACE)
	if(prob(50))
		do_teleport(G, T, teleport_radius, channel = TELEPORT_CHANNEL_BLUESPACE)
	else
		new /obj/effect/decal/cleanable/molten_object(T) //Leave a pile of goo behind for dramatic effect...
		qdel(G)

/**
 * A plant trait that causes the plant's capacity to double.
 *
 * When harvested, the plant's individual capacity is set to double it's default.
 * However, the plant is also going to be limited to half as many products from yield, so 2 yield will only produce 1 plant as a result.
 */
/datum/plant_gene/trait/maxchem
	// 2x to max reagents volume.
	name = "Densified Chemicals"
	rate = 2

/datum/plant_gene/trait/maxchem/on_new(obj/item/food/grown/G, newloc)
	..()
	G.max_volume *= rate

/datum/plant_gene/trait/repeated_harvest
	name = "Perennial Growth"

/datum/plant_gene/trait/repeated_harvest/can_add(obj/item/seeds/S)
	if(!..())
		return FALSE
	return TRUE

/datum/plant_gene/trait/battery
	name = "Capacitive Cell Production"

/datum/plant_gene/trait/battery/on_attackby(obj/item/food/grown/G, obj/item/I, mob/user)
	if(istype(I, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/C = I
		if(C.use(5))
			to_chat(user, "<span class='notice'>You add some cable to [G] and slide it inside the battery encasing.</span>")
			var/obj/item/stock_parts/cell/potato/pocell = new /obj/item/stock_parts/cell/potato(user.loc)
			pocell.icon_state = G.icon_state
			pocell.maxcharge = G.seed.potency * 20

			// The secret of potato supercells!
			var/datum/plant_gene/trait/cell_charge/CG = G.seed.get_gene(/datum/plant_gene/trait/cell_charge)
			if(CG) // Cell charge max is now 40MJ or otherwise known as 400KJ (Same as bluespace power cells)
				pocell.maxcharge *= CG.rate*100
			pocell.charge = pocell.maxcharge
			pocell.name = "[G.name] battery"
			pocell.desc = "A rechargeable plant-based power cell. This one has a rating of [DisplayEnergy(pocell.maxcharge)], and you should not swallow it."

			if(G.reagents.has_reagent(/datum/reagent/toxin/plasma, 2))
				pocell.rigged = TRUE

			qdel(G)
		else
			to_chat(user, "<span class='warning'>You need five lengths of cable to make a [G] battery!</span>")


/datum/plant_gene/trait/stinging
	name = "Hypodermic Prickles"

/datum/plant_gene/trait/stinging/on_slip(obj/item/food/grown/G, atom/target)
	on_throw_impact(G, target)

/datum/plant_gene/trait/stinging/on_throw_impact(obj/item/food/grown/G, atom/target)
	if(isliving(target) && G.reagents && G.reagents.total_volume)
		var/mob/living/L = target
		if(L.reagents && L.can_inject(null, 0))
			var/injecting_amount = max(1, G.seed.potency*0.2) // Minimum of 1, max of 20
			G.reagents.trans_to(L, injecting_amount, methods = INJECT)
			to_chat(target, "<span class='danger'>You are pricked by [G]!</span>")
			log_combat(G, L, "pricked and attempted to inject reagents from [G] to [L]. Last touched by: [G.fingerprintslast].")

/datum/plant_gene/trait/smoke
	name = "Gaseous Decomposition"

/datum/plant_gene/trait/smoke/on_squash(obj/item/food/grown/G, atom/target)
	var/datum/effect_system/smoke_spread/chem/S = new
	var/splat_location = get_turf(target)
	var/smoke_amount = round(sqrt(G.seed.potency * 0.1), 1)
	S.attach(splat_location)
	S.set_up(G.reagents, smoke_amount, splat_location, 0)
	S.start()
	G.reagents.clear_reagents()

/datum/plant_gene/trait/fire_resistance // Lavaland
	name = "Fire Resistance"

/datum/plant_gene/trait/fire_resistance/apply_vars(obj/item/seeds/S)
	if(!(S.resistance_flags & FIRE_PROOF))
		S.resistance_flags |= FIRE_PROOF

/datum/plant_gene/trait/fire_resistance/on_new(obj/item/food/grown/G, newloc)
	if(!(G.resistance_flags & FIRE_PROOF))
		G.resistance_flags |= FIRE_PROOF

///Invasive spreading lets the plant jump to other trays, the spreading plant won't replace plants of the same type.
/datum/plant_gene/trait/invasive
	name = "Invasive Spreading"

/datum/plant_gene/trait/invasive/on_grow(obj/machinery/hydroponics/our_tray)
	for(var/step_dir in GLOB.alldirs)
		var/obj/machinery/hydroponics/spread_tray = locate() in get_step(our_tray, step_dir)
		if(spread_tray && prob(15))
			if(!our_tray.Adjacent(spread_tray))
				continue //Don't spread through things we can't go through.

			if(spread_tray.myseed) // Check if there's another seed in the next tray.
				if(spread_tray.myseed.type == our_tray.myseed.type && !spread_tray.dead)
					continue // It should not destroy its own kind.
				spread_tray.visible_message("<span class='warning'>The [spread_tray.myseed.plantname] is overtaken by [our_tray.myseed.plantname]!</span>")
				QDEL_NULL(spread_tray.myseed)
			spread_tray.myseed = our_tray.myseed.Copy()
			spread_tray.age = 0
			spread_tray.dead = FALSE
			spread_tray.plant_health = spread_tray.myseed.endurance
			spread_tray.lastcycle = world.time
			spread_tray.harvest = FALSE
			spread_tray.weedlevel = 0 // Reset
			spread_tray.pestlevel = 0 // Reset
			spread_tray.update_icon()
			spread_tray.visible_message("<span class='warning'>The [our_tray.myseed.plantname] spreads!</span>")
			if(spread_tray.myseed)
				spread_tray.name = "[initial(spread_tray.name)] ([spread_tray.myseed.plantname])"
			else
				spread_tray.name = initial(spread_tray.name)

/**
 * A plant trait that causes the plant's food reagents to ferment instead.
 *
 * In practice, it replaces the plant's nutriment and vitamins with half as much of it's fermented reagent.
 * This exception is executed in seeds.dm under 'prepare_result'.
 */
/datum/plant_gene/trait/brewing
	name = "Auto-Distilling Composition"

/**
 * A plant trait that causes the plant to gain aesthetic googly eyes.
 *
 * Has no functional purpose outside of causing japes, adds eyes over the plant's sprite, which are adjusted for size by potency.
 */
/datum/plant_gene/trait/eyes
	name = "Oculary Mimicry"
	var/mutable_appearance/googly

/datum/plant_gene/trait/eyes/on_new(obj/item/food/grown/G, newloc)
	. = ..()
	googly = mutable_appearance('icons/obj/hydroponics/harvest.dmi', "eyes")
	googly.appearance_flags = RESET_COLOR
	G.add_overlay(googly)

/datum/plant_gene/trait/sticky
	name = "Prickly Adhesion"

/datum/plant_gene/trait/sticky/on_new(obj/item/food/grown/G, newloc)
	. = ..()
	if(G.seed.get_gene(/datum/plant_gene/trait/stinging))
		G.embedding = EMBED_POINTY
	else
		G.embedding = EMBED_HARMLESS
	G.updateEmbedding()
	G.throwforce = (G.seed.potency/20)

/datum/plant_gene/trait/sticky/can_add(obj/item/seeds/S)
	if(S.get_gene(/datum/plant_gene/trait/squash))
		return FALSE
	. = ..()

/datum/plant_gene/trait/plant_type // Parent type
	name = "you shouldn't see this"
	trait_id = "plant_type"

/datum/plant_gene/trait/plant_type/weed_hardy
	name = "Weed Adaptation"

/datum/plant_gene/trait/plant_type/fungal_metabolism
	name = "Fungal Vitality"

/datum/plant_gene/trait/plant_type/alien_properties
	name ="?????"

/datum/plant_gene/trait/plant_type/carnivory
	name = "Obligate Carnivory"
