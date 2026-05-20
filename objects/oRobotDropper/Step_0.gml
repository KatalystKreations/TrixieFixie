event_inherited();
if disabled exit;
	
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

//died
if (hp <= 0){
	effect_create_layer("FX", ef_explosion, x, y, .5, -1)
	effect_create_layer("FX", ef_firework, x, y, .5, -1)
	instance_destroy()
}