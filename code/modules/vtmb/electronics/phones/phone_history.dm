/datum/phonehistory
	var/name = "Unknown"
	var/number = ""
	var/time = ""
	var/call_type = ""

/datum/phonehistory/New(obj/item/vamp/phone/my_phone, obj/item/vamp/phone/interacting_phone, call_type)
	time = "[station_time_timestamp("hh:mm")]"
	number = interacting_phone.number
	src.call_type = call_type

	for(var/datum/phonecontact/my_contact in my_phone.contacts)
		if(my_contact.number == interacting_phone.number)
			//Verify if they have a contact with the number if so, save their name
			name = my_contact.name
			break
