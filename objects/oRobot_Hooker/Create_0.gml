
event_inherited();

spr_idle = sRobot_Hooker_Idle
spr_walk = sRobot_Hooker_Walk
spr_land = sRobot_Hooker_Landing
spr_death = sRobot_Hooker_Death

cutSpd()
face = 1;
moveSpd = 1;
acceleration = 0.4
decceleration = 0.2
moveDir = 0;
patrol_range = 200;
target_x = xstart+patrol_range;

can_float = true;
is_grabbed = false;

stateFree = function() {
	
	// Face back and forth
	if (target_x < x) {
		moveDir = LEFT
	}
	else moveDir= RIGHT
		
	//Switch directions
	if (abs(target_x - x) <= abs(xspd)) {
		if (moveDir == RIGHT) {
			target_x = xstart - patrol_range;
		}
		else target_x = xstart + patrol_range
	}
	
	// Move
	if canMove{
		xspd += moveDir*(acceleration)
		var targetSpd = clamp(xspd, -moveSpd, moveSpd);
		xspd = lerp(xspd, targetSpd, 0.1); // 0.1 is the easing factor
		
	}
	//else cutSpd()
	sprite(xspd!=0 ? spr_walk : spr_idle);
	//Apply
	x += xspd; 
}
stateHooking = function() {
	
}


state = stateFree;