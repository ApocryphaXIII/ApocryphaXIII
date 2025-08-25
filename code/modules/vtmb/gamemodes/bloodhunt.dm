/atom/movable/screen/alert/bloodhunt
	name = "Blood Hunt Is Going On"
	icon_state = "bloodhunt"

/atom/movable/screen/alert/bloodhunt/Click()
	if(SSbloodhunt.hunted.len) // APOC EDIT START
		var/compound
		for(var/mob/living/carbon/human/H in SSbloodhunt.hunted)
			compound = (compose_dir(H, usr, get_turf(H), "Bloodhunt"))
			to_chat(usr, "[compound]") // APOC EDIT END

SUBSYSTEM_DEF(bloodhunt)
	name = "Blood Hunt"
	init_order = INIT_ORDER_DEFAULT
	wait = 600
	priority = FIRE_PRIORITY_VERYLOW

	var/list/hunted = list()

/datum/controller/subsystem/bloodhunt/fire()
	update_shit()

/datum/controller/subsystem/bloodhunt/proc/update_shit()
	for(var/mob/living/L in hunted)
		if(QDELETED(L))
			hunted -= L
	if(length(hunted))
		for(var/mob/living/carbon/human/H in GLOB.player_list)
			if(iskindred(H) || isghoul(H))
				H.throw_alert("bloodhunt", /atom/movable/screen/alert/bloodhunt)
	else
		for(var/mob/living/carbon/human/H in GLOB.player_list)
			if(iskindred(H) || isghoul(H))
				H.clear_alert("bloodhunt")

/datum/controller/subsystem/bloodhunt/proc/announce_hunted(mob/living/target, reason)
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/H = target
	if(!H.bloodhunted)
		H.bloodhunted = TRUE
		for(var/mob/living/carbon/human/R in GLOB.player_list)
			if(R && iskindred(R) && R.client)
				to_chat(R, "<b>The Blood Hunt after <span class='warning'>[H.true_real_name]</span> has been announced! <br> Reason: [reason]</b>")
				SEND_SOUND(R, sound('code/modules/wod13/sounds/announce.ogg'))
		hunted += H
		update_shit()
