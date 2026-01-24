// Inherit the parent event
event_inherited();

if (!active) {
	image_speed = .8;
	if (sprite_animation_end()) {
		sprite(sRobot_Dropper_Capsule_open)
		if (enemy != noone) {
			instance_create_layer(x, y, "Enemies", enemy)
			enemy = noone;
		}
	}
}