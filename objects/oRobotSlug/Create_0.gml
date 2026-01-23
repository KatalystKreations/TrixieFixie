event_inherited();

spd = 1
xspd = 0;
face = choose(1, -1);
patrol_range = 100
target_x = xstart + (75*face)
current_sprite = sprite_index;


stateIdle = function(){
	sprite_index = sRobotSlug
	if (!alarm[0]) alarm[0] = aSecond*2;
	if (alarm[0] < aSecond/2) sprite_index = sRobotSlug_moving
		if (!alarm_get(1)) alarm_set(1, aSecond * 5) sprite_index = sRobotSlug;
		
	
	//check for out of range from spawn
		if ( x < xstart - patrol_range){
			face = 1;
			xspd = (spd/2) * face;
		}
		if ( x > xstart + patrol_range) {
			face = -1;
			xspd = (spd/2) * face;
		}
	
}

statePatrol = function(){
	//patrol for random time
	if (!alarm_get(1)){
		alarm_set(1, choose(aSecond*2, aSecond*5, aSecond*7))
	}
	
	// Check for wall or edge
		if (place_meeting(x + face * spd, y, oWall) || 
			!place_meeting(bbox_right, y + 1, oWall) || 
			!place_meeting(bbox_left, y + 1, oWall)) {
		    face = -face; // turn around 
			//state = stateIdle;
		}
	//check for out of range from spawn
		if ( x < xstart - patrol_range){
			face = 1; // turn right 
			if (!alarm_get(1)){
		alarm_set(1, 1)
	}
		}
		if ( x > xstart + patrol_range) {
			face = -1; // turn left 
			if (!alarm_get(1)){
		alarm_set(1, 1)
	}
		}
	xspd = spd * face;
	sprite_index = sRobotSlug_moving
}

stateAgro = function(){
	if (sprite_index != sRobotSlug_activated && sprite_index != sRobotSlug_activating ){
	sprite_index = sRobotSlug_activating;
	alarm_set(1, -1)
	}
	// Check for wall or edge
		if (place_meeting(x + face * spd, y, oWall) || 
			!place_meeting(bbox_right, y + 1, oWall) || 
			!place_meeting(bbox_left, y + 1, oWall)) {
		    xspd = 0;
		}
	//face the player
		if (oPlayer.x < x) face = -1
		if (oPlayer.x > x) face = 1
	xspd = spd * face;
	
	
	
}

stateCooldown = function(){
	if (!alarm_get(1)) alarm_set(1, aSecond * 5) sprite_index = sRobotSlug;
		
	// Check for wall or edge
		if (place_meeting(x + face * spd, y, oWall) || 
			!place_meeting(bbox_right, y + 1, oWall) || 
			!place_meeting(bbox_left, y + 1, oWall)) {
		    face = -face; // turn around 
			//state = stateIdle;
		}
	//check for out of range from spawn
		if ( x < xstart - patrol_range){
			face = 1
		}
		if ( x > xstart + patrol_range) {
			face = -1
		}
		xspd = (spd/2) * face;
}

state = statePatrol;


