switch (sprite_index) {
	
	case sRobotSlug_activating: sprite_index = sRobotSlug_activated; break;
	case sRobotSlug_activated: state = stateCooldown; xspd = 0; break;
}