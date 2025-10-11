/turf/open/floor/plating/shit/Entered(atom/movable/AM)
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(HAS_TRAIT(H, TRAIT_RUBICON))
			H.apply_status_effect(/datum/status_effect/rubicon)

/turf/open/floor/plating/vampocean/Entered(atom/movable/AM)
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(HAS_TRAIT(H, TRAIT_RUBICON))
			H.apply_status_effect(/datum/status_effect/rubicon)

/turf/open/floor/plating/vampcrossableocean/Entered(atom/movable/AM)
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(HAS_TRAIT(H, TRAIT_RUBICON))
			H.apply_status_effect(/datum/status_effect/rubicon)

/turf/open/floor/plating/vampacid/Entered(atom/movable/AM)
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(HAS_TRAIT(H, TRAIT_RUBICON))
			H.apply_status_effect(/datum/status_effect/rubicon)

/turf/open/floor/plating/bloodshit/Entered(atom/movable/AM)
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(HAS_TRAIT(H, TRAIT_RUBICON))
			H.apply_status_effect(/datum/status_effect/rubicon)

/turf/open/floor/plating/shit/Exited(atom/movable/AM)
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(H.has_status_effect(/datum/status_effect/rubicon))
			H.remove_status_effect(/datum/status_effect/rubicon)

/turf/open/floor/plating/vampocean/Exited(atom/movable/AM)
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(H.has_status_effect(/datum/status_effect/rubicon))
			H.remove_status_effect(/datum/status_effect/rubicon)

/turf/open/floor/plating/vampcrossableocean/Exited(atom/movable/AM)
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(H.has_status_effect(/datum/status_effect/rubicon))
			H.remove_status_effect(/datum/status_effect/rubicon)

/turf/open/floor/plating/vampacid/Exited(atom/movable/AM)
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(H.has_status_effect(/datum/status_effect/rubicon))
			H.remove_status_effect(/datum/status_effect/rubicon)

/turf/open/floor/plating/bloodshit/Exited(atom/movable/AM)
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if(H.has_status_effect(/datum/status_effect/rubicon))
			H.remove_status_effect(/datum/status_effect/rubicon)
