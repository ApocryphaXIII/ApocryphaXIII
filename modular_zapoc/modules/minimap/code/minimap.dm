#define ui_minimap "WEST-3:15,SOUTH+3:24"

/obj/largemap
	icon = 'modular_zapoc/modules/minimap/icons/largemap.dmi'
	icon_state = "largemap"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER

/datum/hud/human/New(mob/living/carbon/human/owner)
	..()
	var/atom/movable/screen/using
	using = new /atom/movable/screen/minimap
	using.icon = 'modular_zapoc/modules/minimap/icons/minimap.dmi'
	using.icon_state = "map"
	using.screen_loc = ui_minimap
	using.hud = src
	static_inventory += using


/datum/hud/werewolf/New(mob/living/carbon/werewolf/owner) // Should work with transformations now
	..()
	var/atom/movable/screen/using
	using = new /atom/movable/screen/minimap
	using.icon = 'modular_zapoc/modules/minimap/icons/minimap.dmi'
	using.icon_state = "map"
	using.screen_loc = ui_minimap
	using.hud = src
	static_inventory += using

/atom/movable/screen/minimap
	name = "city map"

/atom/movable/screen/minimap/Click()
	call_minimap(usr)

/proc/call_minimap()
	var/user = usr
	var/static/list/map_icons = list(
		"tower" = "Millenium Tower",
		"hospital" = "Hospital",
		"hotel" = "Hotel",
		"library" = "Library",
		"gunstore" = "Gun Store",
		"food" = "Restaurant",
		"clothing" = "Clothing Store",
		"clinic" = "Clinic",
		"copshop" = "Police Station",
		"gas" = "Gas Station",
		"artgallery" = "Gallery",
		"museum" = "Museum",
		"techstore" = "Tech Store",
		"toilet" = "Public Restroom",
		"janitor" = "Sanitation Office",
		"coffee" = "Coffee Shop",
		"pawn" = "Pawn Shop",
		"laundry" = "Laundromat",
		"cargo" = "Railyard",
		"church" = "Church",
		"strip" = "Gentleman's Club",
		"jazz" = "Jazz Club",
		"arcade" = "Arcade",
		"endron" = "Endron Office",
		"bank" = "Bank",
		"caberet" = "Caberet Club",
		"bar" = "Bar"
	)
	var/dat = {"
			<style type="text/css">

			body {
				background-color: #090909; color: white;
			}

			</style>
			"}
	var/obj/largemap/MAP = new(user)
	var/obj/effect/overlay/map_target/AM = new(MAP, user)
	AM.pixel_x = usr.x-16
	AM.pixel_y = usr.y-16
	MAP.overlays |= AM
	dat += "<center>[icon2html(getFlatIcon(MAP), user)]</center><BR>"
	for(var/building_iconstate as anything in map_icons)
		var/icon/building_icon = new('modular_zapoc/modules/minimap/icons/map_legend.dmi', building_iconstate)
		dat += "<center>[icon2html(building_icon, user)] - [map_icons[building_iconstate]];</center><BR>"
		qdel(building_icon)
	user << browse(dat, "window=map;size=400x600;border=1;can_resize=0;can_minimize=0")
	onclose(user, "map", usr)
	qdel(MAP)

/obj/effect/overlay/map_target
	icon = 'modular_zapoc/modules/minimap/icons/minimap.dmi'
	icon_state = "target"
	layer = ABOVE_HUD_LAYER

/* Live updating doesn't work and is out of scope, leaving this here for posterity
/obj/effect/overlay/map_target/Initialize(mapload, mob/living/user)
	. = ..()
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(update_position))

/obj/effect/overlay/map_target/proc/update_position(atom/movable/source)
	pixel_x = source.x
	pixel_y = source.y
*/

#undef ui_minimap
