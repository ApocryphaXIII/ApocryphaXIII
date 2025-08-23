/datum/job/vamp/voivode
	title = "Voivode"
	department_head = list("Eldest")
	faction = "Vampire"
	total_positions = 2 //APOC EDIT
	spawn_positions = 2 //APOC EDITs
	supervisors = " the Laws of Hospitality"
	selection_color = "#953d2d"

	outfit = /datum/outfit/job/voivode

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_VOIVODE
	exp_type_department = EXP_TYPE_VOIVODATE //APOC EDIT

	allowed_species = list("Vampire")
	allowed_bloodlines = list(CLAN_TZIMISCE, CLAN_MALKAVIAN, CLAN_TOREADOR, CLAN_OLD_TZIMISCE) //APOC EDIT
	minimal_generation = 10
//	minimum_character_age = 150 //Uncomment if age-restriction wanted
	minimum_vampire_age = 75

	v_duty = "You are a leader of the Seer's Voivodate. A congregation of Seer clans, leading the new Voivodate in the face of near systemic Collapse. Oversee the Hospitality on your lands, and guard the Sarcophagus of the Voivode-in-Waiting in Waiting kept in your basement." //APOC EDIT
	experience_addition = 20
	minimal_masquerade = 2
	known_contacts = list("Prince", "Baron", "Sheriff", "Emissary", "Seneschal", "Zadruga", "Bogatyr", "Bogatyr Captain")

//APOC EDIT START
/datum/job/vamp/voivode/after_spawn(mob/living/H, mob/M, latejoin)
	. = ..()
	var/clan_name = M.client.prefs.clan.name
	if(clan_name)
		allowed_bloodlines -= clan_name

/datum/job/vamp/voivode/on_free_job(mob/living/carbon/human/despawning)
    if(!despawning.clan)
        return
    var/clan_name = despawning.clan.name
    if(despawning.clan && (clan_name in src::allowed_bloodlines))
        allowed_bloodlines += clan_name
//APOC EDIT END


/datum/outfit/job/voivode
	name = "Voivode"
	jobtype = /datum/job/vamp/voivode
	id = /obj/item/card/id/voivode
	uniform = /obj/item/clothing/under/vampire/voivode
	suit = /obj/item/clothing/suit/vampire/trench/voivode
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	l_pocket = /obj/item/vamp/phone/voivode
	backpack_contents = list(/obj/item/vamp/keys/voivodate/master=1, /obj/item/passport=1, /obj/item/flashlight=1, /obj/item/card/credit/elder=1) //APOC EDIT

/obj/effect/landmark/start/voivode
	name = "Voivode"
