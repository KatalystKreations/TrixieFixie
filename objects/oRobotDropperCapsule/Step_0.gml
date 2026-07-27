// Inherit the parent event
event_inherited();

if (!active) {
	image_speed = .8;
	if (sprite_animation_end()) {
		sprite(sRobot_Dropper_Capsule_open)
		if (enemy != noone) {
			var nearArry = []
			var enemyCap = 6;
			with (oEnemy_par) {
				if (distance_to_object(other) < aBLOCK * 5){
					array_push(nearArry, self);
				}
			}
			if (array_length(nearArry) < enemyCap)
			instance_create_layer(x, y, "Enemies", enemy)
			enemy = noone;
		}
	}
}