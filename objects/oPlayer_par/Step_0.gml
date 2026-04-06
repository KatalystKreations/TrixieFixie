//Detect Ground
onGround 	= place_meeting( x, y + 1, collision );
//Switch sprint speed
runType 	= runKey;
if (gamestate_is(GAMESTATE.PLAYING)) {
	
#region Get Moving Direction
		moveDir = rightKey - leftKey;
		#region Gamepad Controls
			var _gp = undefined;
			if (array_length(global.gamepads) > _player_id)
				_gp = global.gamepads[_player_id];
	
			if (_gp != undefined) 
			{
				var _gp_l_ax_x_val = gamepad_axis_value(_gp, gp_axislh);
				moveDir += _gp_l_ax_x_val;
				moveDir = clamp(moveDir, -1, 1);
			}
		#endregion
		//Find Facing
		if (moveDir != 0) { face = sign(moveDir); }
#endregion

#region X Movement
	
    #region Running
			var _mSpd 	= moveSpd[runType];
		//Acceleration
			if (moveDir != 0)  { xspd += moveDir * (acceleration *3);} 
         //Deceleration
			if (abs(xspd) > 0) { xspd -= (sign(xspd) * deceleration);}
			//come to a complete stop when super slow
			if (!moveDir && abs(xspd) < acceleration)  {  xspd = 0; }
         //Run Cap
			xspd = clamp(xspd, -_mSpd, _mSpd);
	#endregion
	
	#region X Collisions
	var _subPixel = 0.5;
	if place_meeting( x + xspd, y, collision )
	{	
		// Check for up slopes
		if (!place_meeting(x + xspd, y - (1 + abs(xspd)), collision) && !downKey) { 
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
	#endregion

	//Apply
	x += xspd;
#endregion

#region Y Movement

	#region Gravity
		//Switch Gravity type based on jumping or falling.
		if (yspd > 0) 		{ grav = jumpGrav;} 
		else if (downKey)	{ grav = forceGrav; create_dust(oDustWallSlide)}
		else  		  		{ grav = regGrav; }
		//Add Gravity
		yspd += grav;
		//Cap the max falling speed
		if yspd > maxGravSpd {yspd = maxGravSpd}
	#endregion

	#region Jumping
	//Detect jump input for buffer frames
		if (jumpKeyPressed) { jumpBufferTimer = jumpBufferTime; }
		if (!upKey) 		{ jumpTimer 	  = 0; }
		jumpBufferTimer = max(jumpBufferTimer-1, 0);
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
		yspd = jumpspd[jumpCount - 1];
		//Decrease Jump Timer so you don't fly up forever.
		jumpTimer--;
	}
	#endregion
	
	#region Y Collisions 
	_subPixel = 0.5;
	if place_meeting( x, y+yspd, collision )
	{
		//Check for tiny gaps between walls and player
		var _pixelCheck = _subPixel * sign(yspd);
		while ( !place_meeting( x, y + _pixelCheck, collision ) ) { y += _pixelCheck; }
		//Bonk code
			if yspd < 0 {jumpTimer = 0;}
		//Set speed to 0 to collide
		yspd = 0;
	}
	#endregion
	
	//Apply Y
	y += yspd;
#endregion
	
	image_speed = 1;
}
else if (gamestate_is(GAMESTATE.PAUSED)) {
	image_speed = 0;
}
