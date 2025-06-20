// ! evil vamp type
/obj/machinery/vamp/atm
	name = "ATM Machine"
	desc = "Check your balance or make a transaction"
	icon = 'icons/obj/vtm_atm.dmi'
	icon_state = "atm"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/logged_in = FALSE
	var/entered_code

	var/atm_balance = 0
	var/obj/item/card/credit/current_card = null
	light_system = STATIC_LIGHT
	light_color = COLOR_GREEN
	light_range = 2
	light_power = 1
	light_on = TRUE

/obj/machinery/vamp/atm/New()
	..()
	logged_in = FALSE
	current_card = null

// /card/ is a bit of a weird path but it allows us to inherit behavoir for wallet code.
/obj/item/card/credit
	name = "debit card"
	desc = "Used to access bank money."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "card1"
	inhand_icon_state = "card1"
	lefthand_file = 'code/modules/wod13/lefthand.dmi'
	righthand_file = 'code/modules/wod13/righthand.dmi'
	item_flags = NOBLUDGEON
	flags_1 = HEAR_1
	w_class = WEIGHT_CLASS_SMALL
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	onflooricon = 'code/modules/wod13/onfloor.dmi'

	var/registered_name
	var/datum/bank_account/registered_account
	var/has_checked = FALSE
	var/min_starting_wealth = 600
	var/max_starting_wealth = 1000

/obj/item/card/credit/prince
	icon_state = "card2"
	inhand_icon_state = "card2"
	min_starting_wealth = 10000
	max_starting_wealth = 15000

/obj/item/card/credit/seneschal
	icon_state = "card2"
	inhand_icon_state = "card2"
	min_starting_wealth = 4000
	max_starting_wealth = 8000

/obj/item/card/credit/elder
	icon_state = "card3"
	inhand_icon_state = "card3"
	min_starting_wealth = 3000
	max_starting_wealth = 7000

/obj/item/card/credit/giovanniboss
	icon_state = "card2"
	inhand_icon_state = "card2"
	min_starting_wealth = 8000
	max_starting_wealth = 15000

/obj/item/card/credit/rich
	min_starting_wealth = 1000
	max_starting_wealth = 4000


/obj/item/card/credit/Initialize(mapload)
	. = ..()
	var/mob/living/carbon/human/user = null
	if(ishuman(loc)) // In pockets
		user = loc
	else if(ishuman(loc?.loc)) // In backpack
		user = loc
	if(user && user.account_id)
		registered_account = SSeconomy.bank_accounts_by_id["[user.account_id]"]
	if(!registered_account)
		registered_account = new /datum/bank_account()
	if(!isnull(user))
		registered_name = user.real_name
		if(user.clane?.name == CLAN_VENTRUE)
			min_starting_wealth = max(min_starting_wealth, 1000)
			max_starting_wealth = clamp(max_starting_wealth * 1.5, 4000, 20000)
	registered_account.account_balance = rand(min_starting_wealth, max_starting_wealth)

/obj/item/card/credit/examine(mob/user)
	. = ..()
	if(registered_name)
		. += span_notice("The card bears a name: [registered_name].")

/obj/item/card/credit/GetCreditCard()
	return src

/obj/machinery/vamp/atm/attackby(obj/item/P, mob/user, params)
	if(is_creditcard(P))
		if(logged_in)
			to_chat(user, "<span class='notice'>Someone is already logged in.</span>")
			return
		current_card = P
		to_chat(user, "<span class='notice'>Card swiped.</span>")
		return

	else if(istype(P, /obj/item/stack/dollar))
		var/obj/item/stack/dollar/cash = P
		if(!logged_in)
			to_chat(user, "<span class='notice'>You need to be logged in.</span>")
			return
		else
			atm_balance += cash.get_item_credit_value()
			to_chat(user, "<span class='notice'>You have deposited [cash.get_item_credit_value()] dollars into the ATM. The ATM now holds [atm_balance] dollars.</span>")
			qdel(P)
			return

/obj/machinery/vamp/atm/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Atm", name)
		ui.open()

/obj/machinery/vamp/atm/ui_data(mob/user)
	var/list/data = list()
	var/list/accounts = list()

	for(var/datum/bank_account/account in GLOB.bank_account_list)
		if(account && account.account_holder)
			accounts += list(
				list("account_holder" = account.account_holder
				)
			)
		else
			accounts += list(
				list(
					"account_holder" = "Unnamed Account"
				)
			)

	data["logged_in"] = logged_in
	data["card"] = current_card ? TRUE : FALSE
	data["entered_code"] = entered_code
	data["atm_balance"] = atm_balance
	data["bank_account_list"] = json_encode(accounts)
	if(current_card)
		data["balance"] = current_card.registered_account.account_balance
		data["account_holder"] = current_card.registered_account.account_holder
		data["account_id"] = current_card.registered_account.account_id
		data["code"] = current_card.registered_account.bank_pin
	else
		data["balance"] = 0
		data["account_holder"] = ""
		data["account_id"] = ""
		data["code"] = ""

	return data

/obj/machinery/vamp/atm/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	.=..()
	if(.)
		return
	switch(action)
		if("login")
			if(current_card?.registered_account && params["code"] == current_card.registered_account.bank_pin)
				logged_in = TRUE
				return TRUE
			else
				return FALSE
		if("logout")
			logged_in = FALSE
			entered_code = ""
			current_card = null
			return TRUE
		if("withdraw")
			var/amount = text2num(params["withdraw_amount"])
			if(amount != round(amount))
				to_chat(usr, "<span class='notice'>Withdraw amount must be a round number.")
			else if(current_card.registered_account.account_balance < amount)
				to_chat(usr, "<span class='notice'>Insufficient funds.</span>")
			else
				while(amount > 0)
					var/drop_amount = min(amount, 1000)
					var/obj/item/stack/dollar/cash = new /obj/item/stack/dollar()
					cash.amount = drop_amount
					to_chat(usr, "<span class='notice'>You have withdrawn [drop_amount] dollars.</span>")
					try_put_in_hand(cash, usr)
					amount -= drop_amount
					current_card.registered_account.account_balance -= drop_amount
			return TRUE
		if("transfer")
			var/amount = text2num(params["transfer_amount"])
			if(!amount || amount <= 0)
				to_chat(usr, "<span class='notice'>Invalid transfer amount.</span>")
				return FALSE

			var/target_account_id = params["target_account"]
			if(!target_account_id)
				to_chat(usr, "<span class='notice'>Invalid target account ID.</span>")
				return FALSE

			var/datum/bank_account/target_account = null
			for(var/datum/bank_account/account in GLOB.bank_account_list)
				if(account.account_holder == target_account_id)
					target_account = account
					break

			if(!target_account)
				to_chat(usr, "<span class='notice'>Invalid target account.</span>")
				return FALSE
			if(current_card.registered_account.account_balance < amount)
				to_chat(usr, "<span class='notice'>Insufficient funds.</span>")
				return FALSE

			current_card.registered_account.account_balance -= amount
			target_account.account_balance += amount
			to_chat(usr, "<span class='notice'>You have transferred [amount] dollars to account [target_account.account_holder].</span>")
			return TRUE

		if("change_pin")
			var/new_pin = params["new_pin"]
			current_card.registered_account.bank_pin = new_pin
			return TRUE
		if("deposit")
			if(atm_balance > 0)
				current_card.registered_account.account_balance += atm_balance
				to_chat(usr, "<span class='notice'>You have deposited [atm_balance] dollars into your card. Your new balance is [current_card.registered_account.account_balance] dollars.</span>")
				atm_balance = 0
				return TRUE

			else
				to_chat(usr, "<span class='notice'>The ATM is empty. Nothing to deposit.</span>")
				return TRUE
