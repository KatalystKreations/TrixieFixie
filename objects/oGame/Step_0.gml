if (mouse_check_button_pressed(mb_left)) {
	instance_create_depth(mouse_x, mouse_y, depth ,oSwordSlash1)
	//instance_create_depth(mouse_x, mouse_y, depth ,oSwordSlash1).image_xscale = -1
}



if (alarm[0] > 0) {
	set_gamestate(GAMESTATE.DEAD)
}