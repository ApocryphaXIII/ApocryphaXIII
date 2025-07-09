/datum/component/spooky
	var/too_spooky = TRUE //will it spawn a new instrument?

/datum/component/spooky/Initialize()
	RegisterSignal(parent, COMSIG_ITEM_ATTACK, PROC_REF(spectral_attack))

/datum/component/spooky/proc/spectral_attack(datum/source, mob/living/carbon/C, mob/user)
	SIGNAL_HANDLER

	if(ishuman(C))
		C.Jitter(35)
		C.stuttering = 20
		to_chat(C, "<font color='red' size='4'><B>DOOT</B></font>")
	else //the sound will spook monkeys.
		C.Jitter(15)
		C.stuttering = 20
