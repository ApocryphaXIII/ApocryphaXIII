/mob/living
	// Pools
	#warn set at 2 while second sight is the only valid ability so people dont spam it.
	/// The number of conviction points. Used primarly for imbued.
	var/conviction = DEFAULT_CONVICTION
	/// The max number of conviction points. Used primarly for imbued.
	var/total_conviction = 10

	/// Pooled "trait" used for imbued.
	var/willpower = DEFAULT_WILLPOWER
	var/total_willpower = 10

	//This is a horrible spot for this btw.
	/// Static typecache of all imbued powers that are usable.
	var/static/list/imbued_powers = typecacheof(/datum/action/imbued_edge, ignore_root_path = TRUE)
