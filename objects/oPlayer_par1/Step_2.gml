


//out of bounds; Off damage cooldown; Not restarting
	if (y > room_height && !alarm[1] && !oGame.alarm[0]){
		alarm[1] = 10;
	}
//next room
	if (bbox_left > room_width && !instance_exists(oFade)){
		if ( room != room_last)
		var nxtrm_fade = spawn_fade(room_next(room));
		else {
			spawn_fade()
		}
		
	}
