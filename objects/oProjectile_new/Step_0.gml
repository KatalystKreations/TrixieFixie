//Lifetime
if (lifetime > 0) {
	lifetime--;
}else {
	if image_alpha == 1
	onDeath_func()
	fadetoDeath(.2);
	
}



//Gravity
if (gravity_enabled) {
	  gravity = gravity_force;
}else gravity = 0;

//Stop on Terrain
if (stop_on_collide && default_collision) {
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
if (destroy_on_collision && default_collision) {
	if (place_meeting( x, y, collision )) { 
		if (break_effects)
		effect_create_layer("FX", on_break_particle, x, y, .5, break_col)
		collide_func();
		instance_destroy(); 
	}
}

// Rotate based on Direction
if (turn_along_arc) {
	image_angle = direction
}

/*Break on hit
* 
*/
var _near_inst = instance_nearest(x,y,oEntity)
if (default_collision && active && instance_exists(_near_inst) && owner != _near_inst.id && distance_to_object(_near_inst) <= 1) {
	var _already_hit = false;
	for (var i = 0; i < array_length(hit_entities); i++) {
		if (hit_entities[i] == _near_inst.id) {
			_already_hit = true;
			break;
		}
	}

	if (!_already_hit) {
		deal_damage(_near_inst, damage, damage_cam_shake);
		apply_knockback(owner, _near_inst, knockback, true);
		array_push(hit_entities, _near_inst.id);

		if (break_effects) {
			effect_create_layer("FX", on_hit_particle, x, y, .5, break_col);
		}

		if (destroy_on_hit) {
			effect_create_layer("FX", on_hit_particle, x, y, .5, break_col);
			hit_func();
			instance_destroy();
		}
	}
}