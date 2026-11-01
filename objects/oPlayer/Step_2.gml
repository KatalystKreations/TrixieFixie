//out of bounds
	if (y > room_height && !alarm[1] && gamestate_is(GAMESTATE.PLAYING)) {
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
//Death
	if (hp <= 0 && gamestate_is(GAMESTATE.PLAYING) && !instance_exists(oFade)){
		oGame.alarm[0] = aSecond*2
		state = stateDead;
		// Remove cookie projectiles
		with (oCookie_bad) {
			if (speed) {
				instance_destroy()
			}
		}
	}

	if gamestate_is(GAMESTATE.DEAD) { cutSpd(1,0); }
