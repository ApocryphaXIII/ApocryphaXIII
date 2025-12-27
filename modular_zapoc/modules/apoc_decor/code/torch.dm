/obj/structure/bonfire/torch
	name = "torch"
	desc = "A stick on fire. Revolutionary."
	icon = 'modular_zapoc/modules/apoc_decor/icons/torch.dmi'
	icon_state = "torch"
	density = TRUE
	pass_flags_self = LETPASSTHROW
	var/start_lit = TRUE
	burn_icon = "torch_lit"


/obj/structure/bonfire/torch/Initialize()
	. = ..()
	if(start_lit)
		StartBurning()

/obj/structure/bonfire/torch/unlit
	start_lit = FALSE
