/proc/get_dist_in_pixels(pixel_starts_x, pixel_starts_y, pixel_ends_x, pixel_ends_y)
	var/total_x = abs(pixel_starts_x-pixel_ends_x)
	var/total_y = abs(pixel_starts_y-pixel_ends_y)
	return round(sqrt(total_x*total_x + total_y*total_y))

/proc/get_angle_raw(start_x, start_y, start_pixel_x, start_pixel_y, end_x, end_y, end_pixel_x, end_pixel_y)
	var/dy = (world.icon_size * end_y + end_pixel_y) - (world.icon_size * start_y + start_pixel_y)
	var/dx = (world.icon_size * end_x + end_pixel_x) - (world.icon_size * start_x + start_pixel_x)
	if(!dy)
		return (dx >= 0) ? 90 : 270
	. = arctan(dx/dy)
	if(dy < 0)
		. += 180
	else if(dx < 0)
		. += 360

/proc/get_angle_diff(angle_a, angle_b)
	return ((angle_b - angle_a) + 180) % 360 - 180;
