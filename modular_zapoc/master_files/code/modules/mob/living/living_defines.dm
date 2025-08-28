/mob/living
	// Pools
	/// The number of conviction points. Used primarly for imbued.
	var/conviction = DEFAULT_CONVICTION
	/// The max number of conviction points. Used primarly for imbued.
	var/total_conviction = 10

	/// Pooled "trait" used for imbued.
	var/willpower = DEFAULT_WILLPOWER
	var/total_willpower = 10

	/// Used by imbued.
	var/creed = CREED_BYSTANDER

	//This is a horrible spot for this btw.
	/// Static typecache of all imbued powers that are usable.
	var/static/list/imbued_powers = typecacheof(/datum/action/imbued_edge, ignore_root_path = TRUE)
