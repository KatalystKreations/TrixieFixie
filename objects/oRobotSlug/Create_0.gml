event_inherited();

/// Movement
spd  = 1;
xspd = 0;
yspd = 0;

/// Direction
face = choose(-1, 1);

/// AI
patrol_range = 100;
target_x = xstart + (75 * face);

/// Visuals
current_sprite = sprite_index;

/// Systems
getGravVars(0.35, 5);
getCollisionVars();

// Other
patrol_range = 100
target_x = xstart + (75*face)
current_sprite = sprite_index;

// Helper Functions
	function should_turn()
	{
	    return place_meeting(x + face * spd, y, oWall)
	        || !place_meeting(x + face * 8, bbox_bottom + 1, oWall);
	}
	function face_target(_target)
	{
	    face = sign(_target.x - x);
	
	    if (face == 0)
	        face = 1;
	}
	function patrol_bounds()
	{
	    if (x < xstart - patrol_range)
	    {
	        face = 1;
	        return true;
	    }
	
	    if (x > xstart + patrol_range)
	    {
	        face = -1;
	        return true;
	    }
	
	    return false;
	}
	
	
stateIdle = function()
{
    sprite_index = sRobotSlug;
	
	// Switch to Patrol every two seconds
    if (!alarm[0])
        alarm[0] = aSecond * 2;

	// Indicate Moving
    if (alarm[0] < aSecond * 0.5)
        sprite_index = sRobotSlug_moving;

	// Switch back to Idle? after five seconds
    if (!alarm[1])
    {
        alarm[1] = aSecond * 5;
        sprite_index = sRobotSlug;
    }
	
	// Switch directions at bounds
    if (patrol_bounds())
    {
        xspd = (spd * 0.5) * face;
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


