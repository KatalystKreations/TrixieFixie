
if (active) {
	sprite(spr_active)
	// Animation End - Freeze Frame on open
	if (sprite_image_index_is(image_number-1)) {
		image_speed = 0;
	}
}
else {
	image_speed = 1;
	// Animation to revert to normal
	if (sprite_is(spr_active)) {
		sprite(spr_deactive)
	}
	if (sprite_is(spr_deactive)) {
		// Animation End - Back to Base
		if (sprite_image_index_is(image_number-1)) {
			sprite(spr_base)
		}
	}
}

// State Conditions
// If stepped on start timer
if (place_meeting(x,y-1,oPlayer_par)) {
	start_counting = true;
}
// Tick Timer
if (start_counting) {
	timer_before_active--
}
// Once active
if (timer_before_active <= 0) {
	timer_before_active = time_before_active
	start_counting = false;
	active = true;
	alarm[0] = activeTime // Unactivate Alarm
}
