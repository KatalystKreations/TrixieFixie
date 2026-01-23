//Lifetime
if (lifetime > 0) {
	lifetime--;
}else fadetoDeath(.2);



//Gravity
if (gravity_enabled) {
	  gravity = gravity_force;
}else gravity = 0;

//Stop on Terrain
if (stop_on_collide) {
	if (place_meeting( x, y+vspeed, collision ) || place_meeting( x, y-vspeed, collision )) { 
		vspeed 		= 0;
		gravity 	= 0;
		friction 	= 0.1;
	}
	if (place_meeting( x+hspeed, y, collision ) || place_meeting( x-hspeed, y, collision ))
	{  hspeed = 0; }
}

//Unativate if to slow
if (speed <= 2){
	   active = false;
} else active = true;

//Destroy on Terrain
if (destroy_on_collision) {
	if (place_meeting( x, y, collision )) { 
		if (break_effects)
		effect_create_layer("FX", on_break_partcle, x, y, .5, break_col)
		instance_destroy(); 
	}
}

// Rotate based on Direction
if (turn_along_arc) {
	image_angle = direction
}

//Break on hit