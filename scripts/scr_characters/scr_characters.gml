

function getGravVars(_grav = .35, _maxGravSpd = 10){
	if !variable_instance_exists(id, "xspd"){
	xspd = 0;
	yspd = 0;
	}
	grav = _grav;
	maxGravSpd = _maxGravSpd;
}
function getCollisionVars(_col_arr = [oWall, layer_tilemap_get_id("Tiles_Ground")]){
	if !variable_instance_exists(id, "xspd"){
	xspd = 0;
	yspd = 0;
	}
	collision = _col_arr
	onGround = place_meeting( x, y+1, collision);
	ground = instance_place(x, y+1, collision[0]);
}

/** @desc  Handles Collisions
 Required Variables in Object:
 * - xspd
 * - yspd
 * - onGround
 * - collision
*/
/// @param {bool} [_ground]=true Check for ground?
/// @param {bool} [_x]=true Check for x Collision?
/// @param {bool} [_y]=true Check for y Collision?
function getCollisions(_ground = true, _x = true, _y = true){

	if (_ground) {
		onGround 	= place_meeting( x, y + 1, collision );
		ground		= instance_place(x, y-1, collision)
	}
	
	#region X Collisions
		var _subPixel = 0.5;
	if (_x) {
		if place_meeting( x + xspd, y, collision )
		{	
			// Check for up slopes
			if (!place_meeting(x + xspd, y - (1 + abs(xspd)), collision) /*&& !downKey*/) { 
				//Move up by small amount if moving on slope
				while place_meeting(x + xspd, y, collision) { y -= _subPixel; }
			}
			// If no up slope, check for ceiling slopes 
			else
			{
				//Ceiling slopes
				if (!place_meeting(x + xspd, y + abs(xspd)+1, collision))
				{
					while place_meeting(x+xspd, y, collision) {y += _subPixel}
				}
				//normal collison
				else
				{
					//Check for tiny gaps between walls and player
					var _pixelCheck = _subPixel * sign(xspd);
					while !place_meeting(x + _pixelCheck, y, collision) { x += _pixelCheck; }
					
					//"Collide"
					xspd = 0;
				}
			}
		}
		// Check for Down Slopes
		if  (yspd >= 0 && !place_meeting( x + xspd, y + 1, collision ) && place_meeting( x + xspd, y + abs(xspd)+1, collision ))
		{
			//precisely move down slope
			while !place_meeting(x + xspd, y + _subPixel, collision) {y += _subPixel;}
		}
	}
	#endregion
	
	#region Y Collisions 
	if (_y) {
		_subPixel = 0.25;
		if place_meeting( x, y+yspd, collision )
		{
			
			//Check for tiny gaps between walls and player
			var _pixelCheck = _subPixel * sign(yspd);
			while ( !place_meeting( x, y + _pixelCheck, collision ) ) { y += _pixelCheck; }
			//Bonk code
				if yspd < 0 {jumpTimer = 0;}
			//Set speed to 0 to collide
			yspd = 0;
			if variable_instance_exists(ground, "yspd"){
				 	yspd = ground.yspd
				if place_meeting(x,y+abs(yspd), collision) yspd = 0}
		}
	}
	#endregion
}


/** @desc Handles Jumping 
 Required Variables in Object:
 * - yspd
 * - onGround
 * - dustLand
 * - jumpCount
 * - coyoteTimer
 * - coyoteTime
 * - jumped
 * - jumpBefferTimer
 * - maxJumps
 * - jumpTimer
 * - jumpHoldFrames[-]
 * @param {real} [_extra_height]=0 How much higher to jump.
*/
function jump(_extra_height = 0) {
	with (other) {
		if (onGround) 
		{
			//Create Land Dust
			if (!dustLand) 
			{
				//Flag to only happen once.
				dustLand = true;
				//Jump Land Dust
				create_dust(); 	
				//Jump Land Sound
				audio_play_sound(snd_jump_land, 1, false, random_range(0.9, 1.2), 0, random_range(0.9, 1.8)) 
			}
			//Reset jump when on ground
			jumpCount 	= 0; 				
			coyoteTimer = coyoteTime
			jumped 		= false;
		}	
		else //if not onGround
		{
			//Reset flag so it can happen again.
			dustLand = false;
			//Decrease Timer for still being able to jump after falling off ledge.
			coyoteTimer--;
			//Falling on ledge counts as jump
			if (jumpCount == 0 && coyoteTimer <= 0) { jumpCount = 1; } 	
		}
		
		//Allow Jump with Lenience (jumpkey and onground)
		if ( jumpBufferTimer && jumpCount < maxJumps )
		{
			//Increase Jump Count
			jumpCount++;
			jumped 		= false;
			//Set Main Jump Timer to Current Jump Number's Timer
			jumpTimer = jumpHoldFrames[jumpCount - 1];
			
			//If Jumped, Reset Coyote Timer and Jump Buffer after used.
			coyoteTimer 	= 0;
			jumpBufferTimer = 0;
			
			//One time Jump Stuff
			if (!jumped)
			{
				//Flag to only detect jump once.
				jumped = true;
				// Create Jump Dust
					dustLand = false;
					var 
					jDust = create_dust(oDustJump);
					jDust.image_xscale = 1.5;
					jDust.image_yscale = 1.5;
				//Jump Sound
				audio_play_sound(snd_jump_up, 1, false, random_range(0.9, 1.2), 0, random_range(0.9, 1.8))
			}
		}
		// Check if should be jumping
		if (jumpTimer) {
			//Add Jump to y
			yspd = jumpspd[jumpCount - 1]-_extra_height;
			//Decrease Jump Timer so you don't fly up forever.
			jumpTimer--;
		}
	}
}



/** @desc Add a number to yspd.
 * Required Variables in Object:
 * - yspd
 * - grav  (Define in Function parameters)
 * - maxGravSpd (Define in Function parameters)
 / @param {real} [_grav]=grav Speed of gradual descent.
 / @param {real} [_maxGravSpd]=maxGravSpd Max fall speed.
*/
function getGrav(_grav = grav, _maxGravSpd = maxGravSpd) {
	with (other) {
		//Add Gravity
			yspd += _grav;
			//Cap the max falling speed
			if yspd > _maxGravSpd {yspd = _maxGravSpd}
	}
}





/**
* Set the xspd and/or yspd to 0.
* @param {bool} [_xspd]=true 
* @param {bool} [_yspd]=true 
*/
function cutSpd(_xspd = true, _yspd = true){
		if _xspd xspd = 0;
		if _yspd yspd = 0;
	}

/// @desc Freeze an object.
function freeze(){
	cutSpd();
	image_speed = 0;
	
}

/**
 *  Places everything back at it's spawnpoint.
 */
function reset(){
    with all
	{
    x = xstart;
    y = ystart;
    }
    
    with oPlayer_par
	{
    x = global.spawn_x;
    y = global.spawn_y;
    }
    
}

function decelerate(_decel = variable_instance_exists(id, "deceleration") ? deceleration : 0.3) {
	if (abs(xspd) > 0) { xspd -= (sign(xspd) * _decel);}
			//come to a complete stop when super slow
			if (!moveDir && abs(xspd) < acceleration)  {  xspd = 0; return true;}
	return false
}
