/datum/action/imbued_edge/the_word
	name = "The Word"
	desc = "Allows you to write the word."
	button_icon_state = "the_word"
	edge_dots = IMBUED_POWER_INNATE

/datum/action/imbued_edge/the_word/edge_action(mob/living/user, mob/living/target)
	user.put_in_hands(new /obj/item/soapstone/the_word)
	. = ..()

