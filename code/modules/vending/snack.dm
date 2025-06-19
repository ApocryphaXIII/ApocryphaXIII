/obj/machinery/vending/snack
	name = "snack vending machine"
	//desc = "A snack machine courtesy of the Getmore Chocolate Corporation, based out of Mars."
	icon_state = "vend_b"
	#warn see about a new light mask
	//light_mask = "snack-light-mask"
	icon = 'modular_tfn/icons/vendors_shops.dmi'
	products = list(
		/obj/item/food/vampire/bar = 25,
		/obj/item/food/vampire/crisps = 20,
		/obj/item/reagent_containers/food/drinks/dry_ramen = 10,
		/obj/item/storage/box/gum = 10
	)
	refill_canister = /obj/item/vending_refill/snack
	canload_access_list = list(ACCESS_KITCHEN)
	default_price = PAYCHECK_ASSISTANT * 0.6
	extra_price = PAYCHECK_EASY
	payment_department = ACCOUNT_SRV
	input_display_header = "Chef's Food Selection"

/obj/item/vending_refill/snack
	machine_name = "Getmore Chocolate Corp"
