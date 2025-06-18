/datum/action/imbued_edge/weapon
	var/silent = FALSE
	var/engage_sound
	var/weapon_type
	var/weapon_name_simple

/datum/action/imbued_edge/weapon/try_edge(mob/user, mob/target)
	for(var/obj/item/I in user.held_items)
		if(check_weapon(user, I))
			return
	..(user, target)

/datum/action/imbued_edge/weapon/proc/check_weapon(mob/user, obj/item/hand_item)
	if(istype(hand_item, weapon_type))
		user.temporarilyRemoveItemFromInventory(hand_item, TRUE) //DROPDEL will delete the item
		if(engage_sound)
			playsound(user, engage_sound, 30, TRUE)
			//user.visible_message("<span class='warning'>With a sickening crunch, [user] reforms [user.p_their()] [weapon_name_simple] into an arm!</span>", "<span class='notice'>We assimilate the [weapon_name_simple] back into our body.</span>", "<span class='italics>You hear organic matter ripping and tearing!</span>")
		user.update_inv_hands()
		return 1

/datum/action/imbued_edge/weapon/edge_action(mob/living/user)
	var/obj/item/held = user.get_active_held_item()
	if(held && !user.dropItemToGround(held))
		//to_chat(user, "<span class='warning'>[held] is stuck to your hand, you cannot grow a [weapon_name_simple] over it!</span>")
		return
	..()
	var/obj/item/W = new weapon_type(user, silent)
	user.put_in_hands(W)
	if(engage_sound)
		playsound(user, engage_sound, 30, TRUE)
	return W
