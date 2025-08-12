/obj/flag/california/rare
	var/always = FALSE

/obj/flag/california/rare/Initialize(mapload)
	. = ..()
	if(prob(1) || always)
		name = "flag of New California"
		desc = "The flag of the great State of... has it always looked like that?"
		icon = 'modular_zapoc/modules/ncr/icons/ncr.dmi'
