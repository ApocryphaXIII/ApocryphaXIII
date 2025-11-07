/obj/structure/bonfire/torch
	name = "torch"
	desc = "A stick on fire. Revolutionary."
	icon = 'modular_zapoc/modules/apoc_decor/icons/torch.dmi'
	icon_state = "torch"
	density = TRUE
	start_lit = TRUE
	burn_icon = "torch_lit" //for a softer more burning embers icon, use "bonfire_warm"


/obj/structure/bonfire/torch/Initialize()
	. = ..()
	if(start_lit)
		StartBurning()

/obj/structure/bonfire/torch/unlit
	start_lit = FALSE
