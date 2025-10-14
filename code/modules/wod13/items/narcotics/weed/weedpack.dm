/*/obj/item/weedpack // APOC EDIT REMOVE // De-atomized into code/modules/wod13/items/narcotics/weed/weed.dm
	name = "green package"
	desc = "A small package of dried tightly packed kush. Perfect for stuffing into a bong or rolling up in paper."
	icon_state = "package_weed"
	icon = 'code/modules/wod13/items.dmi'
	w_class = WEIGHT_CLASS_SMALL
	ONFLOOR_ICON_HELPER('code/modules/wod13/onfloor.dmi')
	illegal = TRUE
	cost = 150
	//lace-able
	var/list/list_reagents = list(/datum/reagent/drug/cannabis = 30)

/obj/item/weedpack/Initialize(mapload)
	. = ..()
	create_reagents(40, INJECTABLE)
	if(list_reagents)
		reagents.add_reagent_list(list_reagents)

/obj/item/weedpack/attackby(obj/item/attacking_item, mob/living/user, params)
	. = ..()
	if(istype(attacking_item, /obj/item/paper))
		var/obj/item/clothing/mask/cigarette/rollie/cannabis/doctor_bluntenstein = new /obj/item/clothing/mask/cigarette/rollie/cannabis
		doctor_bluntenstein.chem_volume = reagents.total_volume
		reagents.trans_to(doctor_bluntenstein, doctor_bluntenstein.chem_volume, transfered_by = user)
		remove_item_from_storage(user)

		qdel(attacking_item)
		qdel(src)

		user.put_in_hands(doctor_bluntenstein)
		to_chat(user, span_notice("You remove the [pick("sticky green", "good kush", "devil's lettuce", "weed", "reefer", "ganja", "skunk", "dope", "cannabis", "pot")] from the package and quickly roll it up.)]"))
		return TRUE
	return FALSE
*/
