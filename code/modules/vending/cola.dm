
/obj/machinery/vending/cola
	name = "cola vending machine"
	//desc = "A softdrink vendor provided by Robust Industries, LLC."
	icon_state = "vend_r"
	icon = 'modular_tfn/icons/vendors_shops.dmi'
	products = list(
		/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola = 15,
		/obj/item/reagent_containers/food/drinks/soda_cans/vampiresoda = 15,
	)
	refill_canister = /obj/item/vending_refill/cola
	default_price = 1
	extra_price = 1
	payment_department = ACCOUNT_SRV

/obj/machinery/vending/cola/blue
	icon_state = "vend_c"
	//light_mask = "cola-light-mask"
	light_color = COLOR_MODERATE_BLUE

/obj/item/vending_refill/cola
	machine_name = "Robust Softdrinks"
	icon_state = "refill_cola"
