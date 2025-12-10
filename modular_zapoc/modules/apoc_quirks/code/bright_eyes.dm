/datum/quirk/brighteyes
	name = "Bright Eyes"
	desc = "Your eyes are a startling color or bear some other characteristic that is odd to observers. Contacts? Weird Genes? Born a wolf? Who can say. Maybe wear some sunglasses."
	value = 0
	mob_trait = TRAIT_BRIGHTEYES
	gain_text = "<span class='warning'>Your eyes feel unique.</span>"
	lose_text = "<span class='notice'>Your eyes feel generic.</span>"
	allowed_species = list("Ghoul","Human","Imbued","Vampire","Kuei-Jin")

/datum/quirk/brighteyes/fera
	name = "Bright Eyes (Fera)"
	desc = "To those who know, your eyes betray your true nature. Your eyes are a startling color or characteristically canine in apperance."
	value = -1
	allowed_species = list("Werewolf")
