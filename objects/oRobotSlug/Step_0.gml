event_inherited();


#region //X Collisions
	var _subPixel = 0.5;
	if place_meeting( x + xspd, y, oWall )
	{	
		// Check for up slopes
		if (!place_meeting(x + xspd, y - (1 + abs(xspd)), oWall) ) { 
			//Move up by small amount if moving on slope
			while place_meeting(x + xspd, y, oWall) { y -= _subPixel; }
		}
		// If no up slope, check for ceiling slopes 
		else
		{
			//Ceiling slopes
			if (!place_meeting(x + xspd, y + abs(xspd)+1, oWall))
			{
				while place_meeting(x+xspd, y, oWall) {y += _subPixel}
			}
			//normal collison
			else
			{
				//Check for tiny gaps between walls and player
				var _pixelCheck = _subPixel * sign(xspd);
				while !place_meeting(x + _pixelCheck, y, oWall) { x += _pixelCheck; }
				
				//"Collide"
				xspd = 0;
			}
		}
	}
	// Check for Down Slopes
	if  (yspd >= 0 && !place_meeting( x + xspd, y + 1, oWall ) && place_meeting( x + xspd, y + abs(xspd)+1, oWall ))
	{
		//precisely move down slope
		while !place_meeting(x + xspd, y + _subPixel, oWall) {y += _subPixel;}
	}



	//Apply X Movement
	x += xspd;
#endregion

//run state code
if gamestate_is(GAMESTATE.PLAYING) && !disabled	state();

//var state_name = "";
//switch (state) {
    //case stateIdle:  	state_name = "idle"; break;
    //case statePatrol: 	state_name = "patrol"; break;
    //case stateAgro: 	state_name = "agro"; break;
    //case stateCooldown: state_name = "cooldown"; break;
//}
//show_debug_message(string(state_name))

//agro
if (distance_to_object(oPlayer) < 10 && (state == statePatrol || state == stateIdle) && state != stateAgro) {
	state = stateAgro
}


//died
if (hp <= 0){
	effect_create_layer("FX", ef_explosion, x, y, .5, -1)
	effect_create_layer("FX", ef_firework, x, y, .5, -1)
	instance_destroy()
}
//start on first frame
	if (current_sprite != sprite_index) {
	current_sprite = sprite_index;
	image_index = 0
	}