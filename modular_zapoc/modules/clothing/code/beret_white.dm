/obj/item/clothing/head/beret/colorable
	name = "beret"
	desc = "A beret. For bringing out your inner French."
	icon_state = "beret"
	color = "#FFFFFF"
	greyscale_colors = "#FFFFFF"
	var/original_color = "#FFFFFF"
	var/recolored = FALSE


/obj/item/clothing/head/beret/colorable/AltClick(mob/user)
	. = ..()
	recolor_prompt(user)


/obj/item/clothing/head/beret/colorable/examine(mob/user)
	. = ..()
	if(!recolored)
		. += span_notice("Alt-click to recolor [src].")


/obj/item/clothing/head/beret/colorable/proc/recolor_prompt(mob/user)
	if(!recolored)
		var/list/choices = list("Custom", "Gray", "White", "Black", "Red", "Dark Red", "Orange", "Yellow", "Light Green", "Green", "Aquamarine", "Light Blue", "Blue", "Dark Blue", "Purple", "Pink", "Light Brown", "Brown")

		var/user_input = tgui_input_list(user, "Choose a color", "[src]", choices)
		switch(user_input)
			if("Custom")
				var/custom_color = input(user, "Select Color", "[src]", color) as color|null
				if(!isnull(custom_color))
					color = custom_color
				else
					return
			if("Gray")
				color = "#C4B8B3"
			if("White")
				color = "#FFFFFF"
			if("Black")
				color = "#3F3C40"
			if("Red")
				color = "#972A2A"
			if("Dark Red")
				color = "#7F0000"
			if("Orange")
				color = "#BF4900"
			if("Yellow")
				color = "#FFBC30"
			if("Light Green")
				color = "#5FAD20"
			if("Green")
				color = "#3E7C44"
			if("Aquamarine")
				color = "#91CCB8"
			if("Light Blue")
				color = "#76CADB"
			if("Blue")
				color = "#6885AD"
			if("Purple")
				color = "#8D008F"
			if("Pink")
				color = "#F2B6AA"
			if("Light Brown")
				color = "#BF845A"
			if("Brown")
				color = "#996145"

		user.regenerate_icons()

		var/confirm = tgui_alert(user, "Is this the color you want?", "[src]", list("Yes", "No"), timeout = 30 SECONDS)

		if(confirm == "Yes")
			recolored = TRUE
		else
			color = original_color
			user.regenerate_icons()


/obj/item/clothing/head/beret/colorable/precolored
	recolored = TRUE


/obj/item/clothing/head/beret/colorable/precolored/gray
	color = "#C4B8B3"


/obj/item/clothing/head/beret/colorable/precolored/black
	color = "#3F3C40"


/obj/item/clothing/head/beret/colorable/precolored/red
	color = "#972A2A"


/obj/item/clothing/head/beret/colorable/precolored/darkred
	color = "#7F0000"


/obj/item/clothing/head/beret/colorable/precolored/orange
	color = "#BF4900"


/obj/item/clothing/head/beret/colorable/precolored/yellow
	color = "#FFBC30"


/obj/item/clothing/head/beret/colorable/precolored/lightgreen
	color = "#5FAD20"


/obj/item/clothing/head/beret/colorable/precolored/green
	color = "#3E7C44"


/obj/item/clothing/head/beret/colorable/precolored/aquamarine
	color = "#91CCB8"


/obj/item/clothing/head/beret/colorable/precolored/lightblue
	color = "#76CADB"


/obj/item/clothing/head/beret/colorable/precolored/blue
	color = "#6885AD"


/obj/item/clothing/head/beret/colorable/precolored/purple
	color = "#8D008F"


/obj/item/clothing/head/beret/colorable/precolored/pink
	color = "#F2B6AA"


/obj/item/clothing/head/beret/colorable/precolored/lightbrown
	color = "#BF845A"


/obj/item/clothing/head/beret/colorable/precolored/brown
	color = "#996145"
