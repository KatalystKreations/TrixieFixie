
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

can_float = true;

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
	if canMove
	xspd = face * moveSpd;
	else cutSpd()
	sprite(xspd!=0 ? spr_walk : spr_idle);
	
	//Apply
	x += xspd; 
}
stateHooking = function() {
	
}


state = stateFree;