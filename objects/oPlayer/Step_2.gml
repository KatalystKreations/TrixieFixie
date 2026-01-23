//camera shake
	if (global.camShake) {
		global.camShakeMagnitude = map_value(hp, hp_max, 0, global.camShakemin, global.camShakemax) +1
		global.camShakeMagnitude = clamp(global.camShakeMagnitude, global.camShakemin, global.camShakemax)	
		
	    var cam = view_camera[0];
	    var x_offset = random_range(-global.camShakeMagnitude, global.camShakeMagnitude);
	    var y_offset = random_range(-global.camShakeMagnitude, global.camShakeMagnitude);
	    camera_set_view_pos(cam, camera_get_view_x(cam) + x_offset, camera_get_view_y(cam) + y_offset);
	    global.camShakeTimer -= 1;
	    if (global.camShakeTimer <= 0) global.camShake = false;
	}




//out of bounds
	if (y > room_height && !alarm[1] && gamestate_is(GAMESTATE.PLAYING)) {
		alarm[1] = 10;
	}
//next room
	if (bbox_left > room_width && !instance_exists(oFade)){
		var nxtrm_fade = spawn_fade(room_next(room));
		
		
	}
//Death
	if (hp <= 0 && gamestate_is(GAMESTATE.PLAYING) && !instance_exists(oFade)){
		oGame.alarm[0] = aSecond*2
	}

	if gamestate_is(GAMESTATE.DEAD) { cutSpd(1,0); }
