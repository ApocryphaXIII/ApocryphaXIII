
/obj/machinery/vending/cola
	name = "\improper Robust Softdrinks"
	desc = "A softdrink vendor provided by Robust Industries, LLC."
	icon_state = "vend_r"
	icon = 'modular_tfn/icons/vendors_shops.dmi'
	//product_slogans = "Robust Softdrinks: More robust than a toolbox to the head!"
	//product_ads = "Refreshing!;Hope you're thirsty!;Over 1 million drinks sold!;Thirsty? Why not cola?;Please, have a drink!;Drink up!;The best drinks in space."
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
