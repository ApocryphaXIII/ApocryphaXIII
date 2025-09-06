/obj/structure/bloodextractor
	name = "blood extractor"
	desc = "Extract blood in packs."
	icon = 'code/modules/wod13/props.dmi'
	icon_state = "bloodextractor"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	COOLDOWN_DECLARE(last_extracted)

/obj/structure/bloodextractor/MouseDrop_T(mob/living/target, mob/living/user)
	. = ..()
	var/mob/living/carbon/human/H = target // APOC EDIT START
	if(user.stat != CONSCIOUS || HAS_TRAIT(user, TRAIT_UI_BLOCKED) || !Adjacent(user) || !H.Adjacent(user) || !ishuman(H))
		return
	if(!H.buckled)
		to_chat(user, span_warning("You need to buckle [H] before using [src]!"))
		return
	if(!COOLDOWN_FINISHED(src, last_extracted))
		to_chat(user, span_warning("[src] isn't ready yet!"))
		return
	COOLDOWN_START(src, last_extracted, 20 SECONDS)
	if(!do_after(H, 5 SECONDS, src))
		return
	if(iskindred(H))
		if(H.bloodpool < 4)
			to_chat(user, span_warning("[src] can't find enough blood in [H]'s body!"))
			return
		var/obj/item/reagent_containers/blood/vitae/BV = new /obj/item/reagent_containers/blood/vitae(get_turf(src))
		BV.blood_type = H.dna.blood_type
		BV.layer = (layer + 0.1)
		BV.update_name()
		H.bloodpool = max(0, H.bloodpool - 4)
		return

	if(H.bloodpool < 2)
		to_chat(user, span_warning("The [src] can't find enough blood in [H]'s body!"))
		return
	if(HAS_TRAIT(H, TRAIT_POTENT_BLOOD))
		var/obj/item/reagent_containers/blood/elite/BE = new /obj/item/reagent_containers/blood/elite(get_turf(src))
		BE.blood_type = H.dna.blood_type
		BE.layer = (layer + 0.1)
		BE.update_name()
	else
		var/obj/item/reagent_containers/blood/elite/BN = new /obj/item/reagent_containers/blood(get_turf(src))
		BN.blood_type = H.dna.blood_type
		BN.layer = (layer + 0.1)
		BN.update_name()
	H.bloodpool = max(0, H.bloodpool - 2)
	user.visible_message("<span class='warning'>[user] connects [target] to [src] and draws some blood.") // APOC EDIT END
