

// Sprites
	if (dropping) {
		sprite(sRobot_Dropper_Drop);
		if (sprite_animation_end(sRobot_Dropper_Drop)) { dropping = false; }
	}else {
		if (loaded) { sprite(sRobot_Dropper_WalkLoaded) }
		else 		{ sprite(sRobot_Dropper_WalkEmpty)  }
	}
//Start on first frame
check_sprite();