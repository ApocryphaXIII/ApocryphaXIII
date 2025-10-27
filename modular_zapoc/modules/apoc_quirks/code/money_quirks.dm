/datum/quirk/debtor/broke
	name = "Broke"
	desc = "You don't have a single dollar to your name."
	mob_trait = TRAIT_DEBTOR
	value = -3
	gain_text = "<span class='warning'>You feel broke.</span>"
	lose_text = "<span class='notice'>You feel hope for your future finances.</span>"
	moneymod = 0

/datum/quirk/debtor/rich
	name = "Rich"
	desc = "You made some savvy investments or maybe you were just born this way. Double your starting money. Starting balance cannot excede $20000."
	mob_trait = TRAIT_DEBTOR
	value = 2
	gain_text = "<span class='notice'>You feel rich.</span>"
	lose_text = "<span class='warning'>You feel poor.</span>"
	moneymod = 2

/datum/quirk/debtor/fabulous
	name = "Fabulously Wealthy"
	desc = "Money is no object to you. Triple your starting money. Starting balance cannot excede $20000."
	mob_trait = TRAIT_DEBTOR
	value = 5
	gain_text = "<span class='notice'>You feel disgustingly rich.</span>"
	lose_text = "<span class='warning'>Oh no! Your credit score is slipping!</span>"
	moneymod = 3
