

//Moving
	moveDir = 0;
	moveSpd[0] = 5;
	moveSpd[1] = 6.5;
	moveSpd[2] = 2.5;	//crawlspd
	moveSpd[3] = 7.5;	//slideboost spd
	xspd = 0;
	yspd = 0;
	runType = 0;
	xmoving = false;
	acceleration = .2	//the lower the slower
	deceleration = .2 	//the lower the slower
	face = 1;
	cutSpd = function(_xspd = true, _yspd = true){
		if _xspd
		xspd = 0;
		if _yspd 
		yspd = 0;
	}
	//sliding
		is_sliding = false;
		slideTimer = 0;
		slideTime = aSecond*2;
		slideDeceleration = .025;
		slideBoost = 7;
		slideBoosted = false;
		slideBoostTimer = 0;
		slideBoostTime = aSecond;
	//crouching
		crouching = false;
		crawling = false;
		head_clear = !place_meeting(x, y-sprite_get_height(sPlayer1Idle_weapon), oWall); 

//Jumping
	regGrav = .35;
	jumpGrav = .40;
	grav = regGrav;
	maxGravSpd = 10;
	jspd = -5;
	dustLand = true;
	jumped = false;
	//Jump Time
		jumpTimer = 0;
		jumpTime = 10
	//coyote time
		coyoteTimer = 0;
		coyoteTime = 10;
	//jump buffering
		jumpBufferTimer = 0;
		jumpBufferTime = 5;
	
		


//wall jumping / wall sliding
	on_wall = false;
	wall_x_jump_spd = 7;
	wall_y_jump_spd = -6.5;
	wall_slide_spd_max = 2; 	//the lower the slower
	wall_jump_delay = 0;
	wall_jump_delay_max = 15; 	//how long in frames you cant control direction after wall jumping
	wall_dust = 0;
	side = bbox_right
	//Ledge Grabbing
		grabbing_ledge = false;

//health
	hp_max = oGame.hp_max
	hp = oGame.hp
	hp_danger_zone = hp_max * .30;

//hit 
	hit = false;
	hit_flash = false;
	hit_flashTimer = 0;
	hit_flashTime = 10;
	
//attack
	damage = 8;
	


//snd stuff
	//footsteps
		footstep_snd = 0; 			//constantly go up to alternate snds
		footstep_cooldown = 0; 		//prevent snd from playing mulitple times too fast
		footstep_cooldown_max = 10; 	
	//slides snds
		slidesnd = undefined;
		slidesnd_cooldown = 0;
		slidesnd_cooldown_max = aSecond * .5;

//sprite stuff
	spr_idle = sPlayer1Idle_weapon
	spr_run = sPlayer1Run_weapon
	spr_turn = sPlayer1Turn_weapon
	spr_jump = sPlayer1Jump_weapon
	spr_jump_trans = sPlayer1JumpTrans_weapon
	spr_fall = sPlayer1Fall_weapon
	spr_crouch = sPlayer1Crouch_weapon
	spr_crawl = sPlayer1Crawl_weapon
	spr_slide = sPlayer1Crouch_weapon
	spr_wallslide = sPlayer1WallSlide_weapon
	spr_ledgegrab = sPlayer1LedgeGrab

	current_sprite = sprite_index;

	image_index_previous = 0;
	sha_add = 0.2
	uni_add = shader_get_uniform(shd_Flash, "add")	



//spawnpoint
	global.spawn_x = x;
	global.spawn_y = y;




 rightKey = keyboard_check( ord("D") );
 leftKey = keyboard_check( ord("A") );
 downKey = keyboard_check( ord("S") );
 downKeyPressed = keyboard_check_pressed( ord("S") );
 upKey = keyboard_check( ord("W") );
 jumpKeyPressed = keyboard_check_pressed( ord("W") );
 runKey = keyboard_check(vk_lshift);
 grounded = place_meeting( x, y+1, oWall);


//State Free
stateFree = function()
{
	
#region //X Movement 
	//timers
	
		slideBoostTimer = max(slideBoostTimer-1, 0)
		slideTimer = max(slideTimer-1, 0);
		wall_jump_delay = max(wall_jump_delay-1, 0)
	if (slideBoostTimer && !slideBoosted) {slideBoosted = true; xspd *= 1.4}
		
	if (downKeyPressed && grounded && abs(xspd)>moveSpd[0]-1 && !is_sliding) 
		{
			slideTimer = slideTime
			state = stateSlide;
		}
	
	if (wall_jump_delay == 0 && !is_sliding && !slideBoostTimer && !oGame.alarm[0])
	{
		//Get X speed
		    //switch sprint speed
				runType = runKey;
		

		//slide boosting
		if (slideBoostTimer > 0)
		{
		slideBoostTimer--
		runType = 3
		}
		
		
		//crouching
		if (downKey && grounded && abs(xspd) < moveSpd[0]-2 ){
			xspd = 0; 
			yspd = 0;
			state = stateCrouch;
		}
			
			//Acceleration
				if (moveDir != 0) {xspd += moveDir*(acceleration*3)}
			//Deceleration
				if (abs(xspd) > 0 && moveDir == 0) {xspd -= (sign(xspd)*deceleration)}
			//come to a complete stop when super slow
				if (!moveDir && abs(xspd) < deceleration) {xspd = 0}
			//Run Cap
				//if (abs(xspd) > moveSpd[runType]) {xspd -= sign(xspd)*.95}
				xspd = clamp(xspd, -moveSpd[runType], moveSpd[runType])
	}
	

	
#endregion

#region //Y Movement
	
#region //Jumping
		//landing dust and sound
			if (!grounded) 
			{
				dustLand = false;
				slideTimer = 0
				
			}
			if (grounded && !dustLand)
			{
				
				dustLand = true;
				var landDust = instance_create_layer(x, y, "FX", oDustLand);
				//jump land snd
					audio_play_sound(snd_jump_land, 1, false, 1, 0, random_range(0.9, 1.8))
			}
		//reset jump when on ground
			if (grounded)
			{
				coyoteTimer = coyoteTime
				jumped = false;
			}	
			else coyoteTimer--
		
		//allow jump with lenience (jumpkey and onground)
			if (jumpBufferTimer && coyoteTimer && !oGame.alarm[0])
			{
				jumpTimer = jumpTime;
				
				if (slideBoostTimer) {yspd = jspd-(slideBoost/2)}
				coyoteTimer = 0
				jumpBufferTimer = 0
				
				if (!jumped)
				{
					jumped = true;
					//dust fx
						dustLand = false;
						var jDust = instance_create_layer(x, y, "FX", oDustJump);
						jDust.image_xscale = 1.5;
						jDust.image_yscale = 1.5;
					//jump snd
					audio_play_sound(snd_jump_up, 1, false, 1, 0, random_range(0.9, 1.8))
				}
			}
			if (jumpTimer) {
					yspd = jspd;
					jumpTimer--
				}
#endregion
		
	
	
	// Wall detection
		 on_wall_left  = place_meeting(x - 1, y, oWall);
		 on_wall_right = place_meeting(x + 1, y, oWall);
		 on_wall = on_wall_left || on_wall_right;
		// Wall slide state
			if (on_wall && !grounded) { 
				state = stateOnWall 
			}
#endregion
return "Free";
	
}

//State Slide
stateSlide = function()
{
#region //Sliding and Crouching
	
	slideBoosted = false;
	slideTimer--
	is_sliding = true;
	//Deceleration
		if (abs(xspd) > 0) {xspd -= (sign(xspd)*slideDeceleration)}
	//check if jumped during slide
		if (jumpBufferTimer && coyoteTimer && !oGame.alarm[0])
		{
			slideTimer = 0;
			slideBoostTimer = slideBoostTime; 
			state = stateFree 	//back to free state
		}

	if (slideTimer <= 0 || (moveDir != sign(xspd) && moveDir != 0)) {
		is_sliding = false;
		state = stateFree 	//back to free state
	}

#endregion
return "Slide";
}

//State Crouch
stateCrouch = function()
{
	 crouching = true
	if (moveDir != 0) { state = stateCrawl } 	//crawling state
	if (!downKey || !grounded || abs(xspd) > moveSpd[0]-2 && head_clear)
	{
		crouching = false;
		state = stateFree;	//back to free state
	}
return "Crouch";
}

//State Crawl
stateCrawl = function()
{
	crawling = true;
	runType = 2; xspd = clamp(xspd, -moveSpd[2], moveSpd[2])
	//conditions for switching states
		if (!crouching && head_clear) { crawling = false; state = stateFree }									//back to free state
		if (crawling && !downKey && head_clear) { crawling = false; crouching = false; state = stateFree }		//back to free state
		if (crouching && moveDir == 0) { crawling = false;  cutSpd(); state = stateCrouch }						//back to crouch state

	if (moveDir != 0) {xspd += moveDir*(acceleration*3)}	 					//Acceleration
	if (abs(xspd) > 0 && moveDir == 0) {xspd -= (sign(xspd)*deceleration)}	//Deceleration
	if (!moveDir && abs(xspd) < deceleration) {xspd = 0} 					//Come to a complete stop when super slow
	xspd = clamp(xspd, -moveSpd[runType], moveSpd[runType]) 					//Run Cap
	
	return "Crawl";
}

//State On Wall
stateOnWall = function()
{
	#region //Wall Stuff
	side = bbox_right
	//Wall Slide	
		//detect which walls
			 on_wall_left  = place_meeting(x - 1, y, oWall);
			 on_wall_right = place_meeting(x + 1, y, oWall);
			 on_wall = on_wall_left || on_wall_right;
		if (on_wall && !grounded && yspd > 0)
		{
			if (downKey) yspd = min(yspd, wall_slide_spd_max+2); 	//  fall
			else yspd = min(yspd, wall_slide_spd_max); 				// Slow fall
			//face properly
				if (on_wall_left)  face = -1;
				if (on_wall_right) face = 1;
			//Wall Slide Sound
				if (!slidesnd_cooldown)
				{
					slidesnd = audio_play_sound(snd_Slide, 1, false)
					slidesnd_cooldown = slidesnd_cooldown_max
				} else 	slidesnd_cooldown--
				
			//get coords based on which wall the player is on
				side = bbox_right;
				if (on_wall_left)  {side = bbox_left}
		}
				
				if (!on_wall || grounded || yspd < 0 || moveDir != face) 
				{
					if (slidesnd != undefined) { audio_stop_sound(slidesnd)} //Stop Slide sound
					state = stateFree 	//back to free state
				}
		
	// Wall jump
		if (jumpBufferTimer && on_wall && !grounded) 
		{
		    yspd = wall_y_jump_spd;
		    if (on_wall_left)  
			{
				xspd =  wall_x_jump_spd;
				face = 1;
			}
		    if (on_wall_right) 
			{
				xspd = -wall_x_jump_spd;
				face = -1;
			}
			wall_jump_delay = wall_jump_delay_max
			//jump snd
				audio_play_sound(snd_jump_up, 1, false, 1, 0, random_range(1.5, 2.2))
			state = stateFree; 	//back to free state
		}
#endregion
return "WallSlide";
}




state = stateFree;





