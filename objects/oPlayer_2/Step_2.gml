




//out of bounds
	if (y > room_height && !alarm[1] && !oGame.alarm[0]){
		alarm[1] = 10;
	}
//next room
	if (bbox_left > room_width && !instance_exists(oFade)){
		if room_exists(room_next(room))
		var nxtrm_fade = spawn_fade(room_next(room));
		else {
			if (show_question("DEMO COMPLETE!\nRestart?")){
				game_restart()
			}
			else game_end()
		}
	}
//death
	if (hp <= 0 && !oGame.alarm[0]){
		oGame.alarm[0] = 60
	}
	if (oGame.alarm[0]) {
		xspd = 0;
	}