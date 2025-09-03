/obj/structure/popcorn_maker
	name = "popcorn maker"
	desc = "Old fansioned, you think it might even be older then you."
	icon = 'modular_zapoc/modules/structures/icons/popcorn_maker.dmi'
	icon_state = "popcorn_machine"
	COOLDOWN_DECLARE(popcorn_cooldown)

/obj/structure/popcorn_maker/attack_hand(mob/living/user)
	. = ..()
	if(COOLDOWN_FINISHED(src, popcorn_cooldown))
		COOLDOWN_START(src, popcorn_cooldown, 1 SECONDS)
		var/obj/item/food/popcorn/new_popcorn = new(loc)
		user.put_in_hands(new_popcorn)
		playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE)
