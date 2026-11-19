if (active && sprite_index != sCheckPointActivating && sprite_index != sCheckPointActive){
	sprite_index = sCheckPointActivating
}

if (collision_line(x, y, x, 0, oPlayer_par, false, false)) {
	activate()
}