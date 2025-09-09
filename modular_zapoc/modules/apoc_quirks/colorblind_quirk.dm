#define MATRIX_COLOR_MONO list(0.33, 0.33, 0.33, 0.59, 0.59, 0.59, 0.11, 0.11, 0.11)
#define MATRIX_COLOR_PROTA list(0.57, 0.43, 0, 0.56, 0.44, 0, 0, 0.24, 0.76)
#define MATRIX_COLOR_PROTA2 list(0.82, 0.18, 0, 0.33, 0.67, 0, 0, 0.13, 0.88)
#define MATRIX_COLOR_DEUTER list(0.63, 0.38, 0, 0.70, 0.30, 0, 0, 0.30, 0.70)
#define MATRIX_COLOR_DEUTER2 list(0.80, 0.20, 0, 0.26, 0.74, 0, 0, 0.14, 0.86)
#define MATRIX_COLOR_TRITA list(0.95, 0.05, 0, 0, 0.43, 0.57, 0, 0.48, 0.53)
#define MATRIX_COLOR_TRITA2 list(0.97, 0.03, 0, 0, 0.73, 0.27, 0, 0.18, 0.82)
#define MATRIX_COLOR_ACHROMA list(0.30, 0.59, 0.11, 0.30, 0.59, 0.11, 0.30, 0.59, 0.11)
#define MATRIX_COLOR_ACHROMA2 list(0.62, 0.32, 0.06, 0.16, 0.78, 0.06, 0.16, 0.32, 0.52)
#define MATRIX_COLOR_CANINE list(0.50, 0.40, 0.10, 0.50, 0.40, 0.10, 0, 0.20, 0.80)
#define MATRIX_COLOR_FELINE list(0.40, 0.20, 0.40, 0.40, 0.60, 0, 0.20, 0.20, 0.60)

/datum/client_colour/colorblind
	colour = MATRIX_COLOR_PROTA
	priority = 10
	override = TRUE
	fade_in = 20
	fade_out = 20

/datum/client_colour/colorblind/protanomaly
	colour = MATRIX_COLOR_PROTA2

/datum/client_colour/colorblind/deuteranopia
	colour = MATRIX_COLOR_DEUTER

/datum/client_colour/colorblind/deuteranomaly
	colour = MATRIX_COLOR_DEUTER2

/datum/client_colour/colorblind/tritanopia
	colour = MATRIX_COLOR_TRITA

/datum/client_colour/colorblind/tritanomaly
	colour = MATRIX_COLOR_TRITA2

/datum/client_colour/colorblind/achromatopsia
	colour = MATRIX_COLOR_ACHROMA

/datum/client_colour/colorblind/achromanomaly
	colour = MATRIX_COLOR_ACHROMA2

/datum/client_colour/colorblind/canine
	colour = MATRIX_COLOR_CANINE

/datum/client_colour/colorblind/feline
	colour = MATRIX_COLOR_FELINE

/datum/quirk/colorblind
	name = "Colorblind (Monochromia)"
	desc = "You suffer from full colorblindness, and perceive nearly the entire world in blacks and whites."
	value = 0
	medical_record_text = "Patient is afflicted with almost complete color blindness."
	gain_text = "<span class='warning'>You feel colorblind.</span>"
	lose_text = "<span class='notice'>Everything looks so colorful!</span>"
	var/client_colour_path = /datum/client_colour/monochrome
	var/should_transfer = FALSE

/datum/quirk/colorblind/protanopia
	name = "Colorblind (Protanopia)"
	desc = "You suffer from protanopia, a type of red-green colorblindness."
	value = 0
	medical_record_text = "Patient is afflicted with protanopia."
	client_colour_path = /datum/client_colour/colorblind

/datum/quirk/colorblind/deuteranopia
	name = "Colorblind (Deuteranopia)"
	desc = "You suffer from deuteranopia, a type of red-green colorblindness."
	medical_record_text = "Patient is afflicted with deuteranopia."
	client_colour_path = /datum/client_colour/colorblind/deuteranopia

/datum/quirk/colorblind/tritanopia
	name = "Colorblind (Tritanopia)"
	desc = "You suffer from tritanopia, a type of blue-yellow colorblindness."
	medical_record_text = "Patient is afflicted with tritanopia."
	client_colour_path = /datum/client_colour/colorblind/tritanopia

/*/datum/quirk/colorblind/canine // Commented out pending /datum/quirk/transfer_mob working on fera forms
	name = "Colorblind (Canine)"
	desc = "Your eyes are dichromatic, like those of a canine."
	value = -1
	medical_record_text = "Patient is afflicted with tritanopia."
	allowed_species = list("Werewolf")
	client_colour_path = /datum/client_colour/colorblind/canine
	should_transfer = TRUE

/datum/quirk/colorblind/feline
	name = "Colorblind (Feline)"
	desc = "Your eyes percieve colors duller than most, like those of a feline."
	value = -1
	medical_record_text = "Patient is afflicted with tritanopia."
	allowed_species = list("Bastet")
	client_colour_path = /datum/client_colour/colorblind/feline
	should_transfer = TRUE
*/

/datum/quirk/colorblind/add()
	if(isliving(quirk_holder))
		var/mob/living/carbon/human/H = quirk_holder
		H.add_client_colour(client_colour_path)

/datum/quirk/colorblind/remove()
	if(isliving(quirk_holder))
		var/mob/living/carbon/human/H = quirk_holder
		H.remove_client_colour(client_colour_path)

#undef MATRIX_COLOR_MONO
#undef MATRIX_COLOR_PROTA
#undef MATRIX_COLOR_PROTA2
#undef MATRIX_COLOR_DEUTER
#undef MATRIX_COLOR_DEUTER2
#undef MATRIX_COLOR_TRITA
#undef MATRIX_COLOR_TRITA2
#undef MATRIX_COLOR_ACHROMA
#undef MATRIX_COLOR_ACHROMA2
#undef MATRIX_COLOR_CANINE
#undef MATRIX_COLOR_FELINE
