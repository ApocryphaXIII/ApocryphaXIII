/obj/machinery/vending/coffee
	name = "coffee vending machine"
	desc = "For those sleepy mornings."
	icon_state = "vend_g"
	icon = 'modular_tfn/icons/vendors_shops.dmi'
	products = list(
		/obj/item/reagent_containers/food/drinks/coffee = 6,
		/obj/item/reagent_containers/food/drinks/mug/tea = 6,
		/obj/item/reagent_containers/food/drinks/mug/coco = 3
	)
	refill_canister = /obj/item/vending_refill/coffee
	default_price = PAYCHECK_PRISONER
	extra_price = PAYCHECK_ASSISTANT
	payment_department = ACCOUNT_SRV
	light_mask = "coffee-light-mask"
	light_color = COLOR_DARK_MODERATE_ORANGE

/obj/item/vending_refill/coffee
	machine_name = "Solar's Best Hot Drinks"
	icon_state = "refill_joe"
