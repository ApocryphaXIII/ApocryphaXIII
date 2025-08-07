/obj/vampire_car/retro
	icon_state = "1"
	max_passengers = 1
	dir = WEST

/obj/vampire_car/retro/rand
	icon_state = "3"

/obj/vampire_car/retro/rand/Initialize(mapload)
	icon_state = "[pick(1, 3, 5)]"
	if(access == "none")
		access = "npc[rand(1, 20)]"
	. = ..()

/obj/vampire_car/rand
	icon_state = "4"
	dir = WEST

/obj/vampire_car/rand/Initialize(mapload)
	icon_state = "[pick(2, 4, 6)]"
	if(access == "none")
		access = "npc[rand(1, 20)]"
	. = ..()

/obj/vampire_car/rand/camarilla
	access = "camarilla"
	icon_state = "6"

/obj/vampire_car/retro/rand/camarilla
	access = "camarilla"
	icon_state = "5"

/obj/vampire_car/rand/anarch
	access = "anarch"
	icon_state = "6"

/obj/vampire_car/retro/rand/anarch
	access = "anarch"
	icon_state = "5"

/obj/vampire_car/rand/clinic
	access = "clinic"
	icon_state = "6"

/obj/vampire_car/retro/rand/clinic
	access = "clinic"
	icon_state = "5"

/obj/vampire_car/limousine
	icon_state = "limo"
	max_passengers = 6
	dir = WEST

/obj/vampire_car/limousine/giovanni
	icon_state = "giolimo"
	access = "giovanni"

/obj/vampire_car/limousine/camarilla
	icon_state = "limo"

/obj/vampire_car/police
	icon_state = "police"
	max_passengers = 3
	dir = WEST
	beep_sound = 'code/modules/wod13/sounds/migalka.ogg'
	access = "police"
	light_system = MOVABLE_LIGHT
	light_color = "#ff0000"
	light_range = 6
	light_power = 6
	light_on = FALSE
	var/color_blue = FALSE
	COOLDOWN_DECLARE(last_color_change)

/obj/vampire_car/police/unmarked
	icon_state = "unmarked"

/obj/vampire_car/police/set_headlight_on(new_value)
	. = ..()
	if(isnull(.))
		return
	set_light_on(headlight_on)


/obj/vampire_car/police/car_move()
	if(!light_on)
		return ..()
	if(!COOLDOWN_FINISHED(src, last_color_change))
		return ..()
	COOLDOWN_START(src, last_color_change, 1 SECONDS)
	if(color_blue)
		color_blue = FALSE
		set_light_color("#ff0000")
	else
		color_blue = TRUE
		set_light_color("#0000ff")
	return ..()

/obj/vampire_car/taxi
	icon_state = "taxi"
	max_passengers = 3
	dir = WEST
	access = "taxi"

/obj/vampire_car/track
	icon_state = "track"
	max_passengers = 6
	dir = WEST
	access = "none"
	baggage_limit = 100
	baggage_max = WEIGHT_CLASS_BULKY
	component_type = /datum/component/storage/concrete/vtm/car/track

/obj/vampire_car/track/Initialize(mapload)
	if(access == "none")
		access = "npc[rand(1, 20)]"
	. = ..()

/obj/vampire_car/track/volkswagen
	icon_state = "volkswagen"
	baggage_limit = 60

/obj/vampire_car/track/ambulance
	icon_state = "ambulance"
	access = "clinic"
	baggage_limit = 60
