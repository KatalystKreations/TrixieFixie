
event_inherited();

spr_idle = sRobot_Hooker_Idle
spr_walk = sRobot_Hooker_Walk
spr_land = sRobot_Hooker_Landing
spr_death = sRobot_Hooker_Death

cutSpd()
face = 1;
moveSpd = 1;
patrol_range = 200;
target_x = xstart+patrol_range;


stateFree = function() {
	
	// Face back and forth
	if (target_x < x) {
		face = LEFT
	}
	else face = RIGHT
		
	//Switch directions
	if (distance_to_point(target_x, y) < moveSpd) {
		if (face == RIGHT) {
			target_x = xstart - patrol_range;
		}
		else target_x = xstart + patrol_range
	}
	
	// Move
	xspd = face * moveSpd;
	sprite(spr_walk);
	
	//Apply
	x += xspd; 
}
stateHooking = function() {
	
}


state = stateFree;