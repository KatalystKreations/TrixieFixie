if (active && sprite_index != sCheckPointActivating && sprite_index != sCheckPointActive){
	sprite_index = sCheckPointActivating
}

if (!active && collision_line(x, y, x, max_detection_point_y, oPlayer_par, false, false)) {
	activate()
}