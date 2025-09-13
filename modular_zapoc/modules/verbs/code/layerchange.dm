#define LAYER_CHANGE_MAX 4.5
#define LAYER_CHANGE_MIN 3.5

/mob/living/verb/layerup()
	set name = "Layer Change Up"
	set category = "IC"

	if(!canface())
		to_chat(usr, span_warning("You can't change layer right now."))
		return

	var/newlayer = clamp((layer+0.1), LAYER_CHANGE_MAX, LAYER_CHANGE_MIN)
	if(newlayer == LAYER_CHANGE_MAX)
		to_chat(usr, span_warning("You're at the highest layer!"))
	else
		to_chat(usr, span_notice("Your layer is now [newlayer]."))
		usr.layer = newlayer

/mob/living/verb/layerdown()
	set name = "Layer Change Down"
	set category = "IC"

	if(!canface())
		to_chat(usr, span_warning("You can't change layer right now."))
		return

	var/newlayer = clamp((layer-0.1), LAYER_CHANGE_MAX, LAYER_CHANGE_MIN)

	if(newlayer == LAYER_CHANGE_MIN)
		to_chat(usr, span_warning("You're at the lowest layer!"))
	else
		to_chat(usr, span_notice("Your layer is now [newlayer]."))
		usr.layer = newlayer


#undef LAYER_CHANGE_MAX
#undef LAYER_CHANGE_MIN
