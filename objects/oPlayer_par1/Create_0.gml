event_inherited();



//Curves
pulse_curve_head = 0;
pulse_curve_speed = .01;
pulse_curve_struct = animcurve_get(animC_pulse);
pulse_curve_channel = animcurve_get_channel(pulse_curve_struct, 0)

//Moving
moveDir = 0;
moveSpd[0] = 3.5;
moveSpd[1] = 6.5;
moveSpd[2] = 2.5;	//crawlspd
moveSpd[3] = 7.5;	//slideboost spd
moveSpd[4] = 4.5;	//dodge spd
xspd = 0;
yspd = 0;
runType = 0;
xmoving = false;
acceleration = .2	//the lower the slower
deceleration = .3 	//the lower the slower
face = 1;

// Sliding
is_sliding = false;
slideTimer = 0;
slideTime = aSECOND*2;
slideDeceleration = .05;
slideBoost = 7;
slideBoosted = false;
slideBoostTimer = 0;
slideBoostTime = aSECOND;

// Crouching
crouching = false;
crawling = false;
head_clear = true; 
	
//Dodge
dodging = false;
dodgeSpd = moveSpd[4];
dodgeTime = 10;
dodgeTimer = 0;
tapsRight = 0;
tapsLeft = 0;
tapsNeeded = 2
tapTime = 12;
tapTimer = 0;

// Jumping
regGrav = .35;
jumpGrav = .40;
forceGrav = regGrav*2;
grav = regGrav;
maxGravSpd = 10;
jspd = -4;
dustLand = true;
jumped = false;
//Jump Time
	jumpTimer = 0;
	jumpTime = 10
//Coyote time
	coyoteTimer = 0;
	coyoteTime = 10;
//Jump buffering
	jumpBufferTimer = 0;
	jumpBufferTime = 5;
//Successive jumps
	maxJumps = 1 + oGame.upgradeJumps;
	jumps = maxJumps;
	jumpCount = 0;

	jumpHoldFrames[0] = 17;
	jumpspd[0] = -4.5;
	
	jumpHoldFrames[1] = 13;
	jumpspd[1] = -4.0;
	
	jumpHoldFrames[2] = 5;
	jumpspd[2] = -4.0;
	
	jumpHoldFrames[3] = 5;
	jumpspd[3] = -4.0;
	
		

// Wall jumping / wall sliding
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
	hp = hp_max
	hp_danger_zone = hp_max * .30;
// Essence
	essence_max = oGame.essence_max
	essence = essence_max

//hit 
	get_hitFlash()

	
//attack
	damage = 20;
	usingPower1 = false
	usingPower2 = false;

	after_power_time = 40;
	after_power_timer = 0;
	invincible = false;
	attacker = noone;
	

// Holding Objects
	is_picking_up = false;
	is_holding = false;
	obj_holding = noone;

//controller





	


//snd stuff
	//footsteps
		footstep_snd = 0; 			//constantly go up to alternate snds
		footstep_cooldown = 0; 		//prevent snd from playing mulitple times too fast
		footstep_cooldown_max = 10; 	
	//slides snds
		slidesnd = undefined;
		slidesnd_cooldown = 0;
		slidesnd_cooldown_max = aSECOND * .5;

//sprite stuff
	spr_idle 			= sHeteknn_Idle
	spr_run 			= sHeteknn_Run
	spr_turn 			= sHeteknn_Turn
	spr_jump 			= sHeteknn_Jump
	spr_jump_double 	= sHeteknn_JumpDouble
	spr_jump_trans 		= sHeteknn_JumpTrans
	spr_fall 			= sHeteknn_Fall
	spr_crouch 			= sHeteknn_Crouch
	spr_crawl 			= sHeteknn_Crawl
	spr_slide 			= sHeteknn_SlideBelly
	spr_wallslide 		= sHeteknn_WallSlide
	spr_dead 			= sHeteknn_Dead
	spr_hit 			= sHeteknn_Hit

	spr_pickup 			= sHeteknn_Pickup
	spr_hold 			= sHeteknn_Hold

	spr_power1 			= sHeteknn_Power1
	spr_power2 			= sHeteknn_PlayerPower2
	spr_power_after 	= sHeteknn_PowerAfter
	spr_hit_tp 			= sHeteknn_Hit_tp

	current_sprite = sprite_index;
	prev_blend = image_blend;
	image_index_previous = 0;
	spr_power1_image_index = 0;
	spr_power1_image_index_max = sprite_get_number(sprite_index);


	characters = {
		Heteknn : {
			projectile: oIceBall
		},
		Haizek : {
			projectile: oIceSpike
		},
		Emno : {
			projectile: oIceBlock
		},
		Tyrpiu : {
			projectile: oWormSpit
		},
		Wegio : {
			projectile: oIceBall
		},
		Kenda : {
			projectile: oIceBall
		}
	}
	
	character = characters[$ global.playerName]



getControls()
getPowerControls()



//State Cutscene
stateCutscene = function(){
	#region Movement
		#region Add Movement to variables
			// Handle Gravity	
				var _grav  = 0.0010
				if yspd > 0  getGrav(max(_grav, 0), .25)
				if yspd <= 0  getGrav()
			// Handle Collisions
				getCollisions();
			// Decel
				decelerate()
		#endregion
		#region  Apply to Position
			x += xspd;
			y += yspd;
		#endregion
	#endregion
	
	if (!instance_exists(oCutscene)) {
		state = stateFree;
	}
	return "CutScene"
}



//State Free
stateFree = function()
{
	usingPower1 = false
	usingPower2 = false
	crawling = false;
	crouching = false;
	is_sliding = false;
	slideTimer = 0;
#region //X Movement 
	#region //Timers
		slideBoostTimer 	= max(slideBoostTimer-1, 0);
		wall_jump_delay 	= max(wall_jump_delay-1, 0);
		//Slide Boost Speed
			if (slideBoostTimer && !slideBoosted) {slideBoosted = true; xspd *= 1.4}
	#endregion
	#region //Trigger Slide
		var crouchBtnPressed = (downKeyPressed || bBtnPressed);
		if (crouchBtnPressed 
		&& 	onGround 
		&& 	abs(xspd) > moveSpd[0]-1 
		&& 	!is_sliding
		&&  !is_holding) 
		{
			slideTimer = slideTime
			//xspd += sign(xspd)*moveSpd[4]
			state = stateSlide;
		}
	#endregion
	
	//Check for 'jumping off walls', 'not sliding', 'not slide boosting'
		if (wall_jump_delay == 0 && !is_sliding && !slideBoostTimer)
		{
			//Switch Sprint Type
				runType = runKey;
			//slide boosting
			if (slideBoostTimer > 0)
			{
			runType = 3
			}
			
			#region //Trigger Crouching
				var crouchBtn = (downKey || bBtn);
				if (
					crouchBtn
					&& 	onGround 
					&& 	abs(xspd) < moveSpd[0]-2 
					&& !is_holding
				)
				{
					// Cut xpsd
					cutSpd(true, false);
					state = stateCrouch;
				}
			#endregion
			
			#region Running
					var _mSpd 	= moveSpd[runType];
				//Acceleration
					if (moveDir != 0)  { xspd += moveDir * (acceleration *3);} 
				//Deceleration
					decelerate();
					
				//Run Cap
					var targetSpd = clamp(xspd, -moveSpd[runType], moveSpd[runType]);
					xspd = lerp(xspd, targetSpd, 0.1); // 0.1 is the easing factor
			#endregion
			
			
		}
#endregion

#region // Y Movement
#region // Jumping
	if (onGround)
	{
		if (!dustLand) 
		{
			dustLand = true; 		//flag
			var landDust = instance_create_layer(x, y, "FX", oDustLand); 			//jump land dust
			audio_play_sound(snd_jump_land, 1, false, 1, 0, random_range(0.9, 1.8)) //jump land snd
		}
		jumpCount = 0; 				//reset jump when on ground
		coyoteTimer = coyoteTime
		jumped = false;
	}	
	else //if not on the ground
	{
		dustLand = false;
		slideTimer = 0
		coyoteTimer--	
		if (jumpCount == 0 && coyoteTimer <= 0) { jumpCount = 1; } 					//Falling on cliff counts as jump
	}
	
	/// Allow Jump with Lenience (jumpkey and onground)
	if (jumpBufferTimer && jumpCount < maxJumps)
	{
		jumpTimer = jumpHoldFrames[jumpCount];
		jumpCount++
		
		
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
		jumpTimer--
		yspd = jspd;
	}
#endregion
#endregion
	
	#region // Wall detection
		on_wall_left  = place_meeting(x - 1, y, collision);
		on_wall_right = place_meeting(x + 1, y, collision);
		on_wall = on_wall_left || on_wall_right;
		// Trigger Wall State
			if (on_wall /*&& yspd > 0*/ && !onGround && !is_holding) {  slideBoostTimer = 0; state = stateOnWall  }
	#endregion
	
	#region Movement
		#region Add Movement to variables
			// Handle Gravity	
				getGrav(grav, maxGravSpd);
			// Handle Collisions
				getCollisions();
		#endregion
		#region  Apply to Position
			x += xspd;
			y += yspd;
		#endregion
	#endregion
	

	
return "Free";
	
}
//State Slide
stateSlide = function()
{
	slideBoosted = false;
	is_sliding = true;
	
	// Player Jumped
		if (jumpBufferTimer && coyoteTimer)
		{
			slideBoostTimer = slideBoostTime; 
			state = stateFree; 
		}
	// Handle direction-change exit
		if ( (moveDir != sign(xspd) && moveDir != 0) ) {
			state = stateFree;
		}
	// Handle timer expiration
		if ( slideTimer <= 0 ) {
			// Back to free state
			if downKey && xmoving 	state = stateCrawl;
			if downKey 				state = stateCrouch;
			else 					state = stateFree;	
		}	
	//Handle deceleration
		if (decelerate(slideDeceleration)){
			if (moveDir == 0) state = stateFree;
			else 			  state = stateCrawl;
			is_sliding = false
		}
	
	#region Movement
		#region Add Movement to variables
			// Handle Gravity	
				getGrav(grav, maxGravSpd);
			// Handle Collisions
				getCollisions();
		#endregion
		#region  Apply to Position
			x += xspd;
			y += yspd;
		#endregion
	#endregion
	
	return "Slide";
}

//State Crouch
stateCrouch = function()
{
	crouching = true;
	crawling = false;
	
	// Crawling state
	if (moveDir != 0) { state = stateCrawl } 
	
	// Player stopped holding down or falls
	if ((!downKey || !onGround) && head_clear) {
		state = stateFree;
	}
	
	#region Movement
		#region Add Movement to variables
			// Handle Gravity	
				getGrav(grav, maxGravSpd);
			// Handle Collisions
				getCollisions();
		#endregion
		#region  Apply to Position
			x += xspd;
			y += yspd;
		#endregion
	#endregion
	
	return "Crouch";
}

//State Crawl
stateCrawl = function()
{
	crawling = true;
	// Player Jumped
	if (jumpBufferTimer && coyoteTimer)
	// Player stopped holding down
	|| (!downKey && head_clear) {
		state = stateFree;
		return;
	}
	// Handle crouch fallback
	if (crouching && moveDir == 0) {
	    cutSpd();
	    state = stateCrouch;
	    return;
	}
	
	#region Movement
		runType = 2;
		if (moveDir != 0) {xspd += moveDir*(acceleration*3)}	 				//Acceleration
		if (abs(xspd) > 0 && moveDir == 0) {xspd -= (sign(xspd)*deceleration)}	//Deceleration
		if (!moveDir && abs(xspd) < deceleration) {xspd = 0} 					//Come to a complete stop when super slow
		xspd = clamp(xspd, -moveSpd[runType], moveSpd[runType]) 				//Run Cap
		#region Add Movement to variables
			// Handle Gravity	
				getGrav(grav, maxGravSpd);
			// Handle Collisions
				getCollisions();
		#endregion
		#region  Apply to Position
			x += xspd;
			y += yspd;
		#endregion
	#endregion
	
	return "Crawl";
}

//State On Wall
stateOnWall = function()
{
	#region //Wall Stuff
	side = bbox_right
	//Wall Slide	
		//detect which walls
			 on_wall_left  = place_meeting(x - 1, y, collision);
			 on_wall_right = place_meeting(x + 1, y, collision);
			 on_wall = on_wall_left || on_wall_right;
		if (on_wall && !onGround && yspd > 0)
		{
			
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
				
				if (!on_wall || onGround || yspd < 0 || moveDir != face) 
				{
					if (slidesnd != undefined) { audio_stop_sound(slidesnd)} //Stop Slide sound
					state = stateFree 	//back to free state
				}
		
	// Wall jump
		if (jumpBufferTimer && on_wall && !onGround) 
		{
			jumpBufferTimer = 0;
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
	#region Movement
		#region Add Movement to variables
			// Handle Gravity	
			if (downKey) yspd = min(yspd, wall_slide_spd_max+2); 	//  fall fast
			else if yspd > 0 yspd = min(yspd, wall_slide_spd_max); 	//  fall
				getGrav(grav, maxGravSpd);
			// Handle Collisions
				getCollisions();
		#endregion
		#region  Apply to Position
			x += xspd;
			y += yspd;
		#endregion
	#endregion
return "WallSlide";
}


stateTpFromDanger = function()
{
	if (sprite_index_is(spr_hit_tp) ) {
		invincible = true;
		if ( sprite_animation_end() ) {
			if (attacker != noone) {
				x = attacker.x - sprite_get_width(attacker.sprite_index) * attacker.face ;
			}
			invincible = false;
			state = stateFree;
		}
	}
}

// Dead State
stateDead = function()
{
	getGrav()
	decelerate()
	
}

//ice spike
ice_spike_shoot_time = 10;
ice_spike_shoot_timer = 0;
power_key_held_time = 60;
power_key_held_timer = 0;
statePower1 = function()
{
	decelerate()
	if (power_key_held_timer > 0)
	{
		power_key_held_timer--
		if (powerkey1 || xBtn) ice_spike_shoot_timer = ice_spike_shoot_time
			
		if (power_key_held_timer <= (power_key_held_time/5)) {
			image_blend = charge_abilty_col
			image_index = image_number - 1
		}
	}else {
		image_blend = prev_blend
	}

	if (ice_spike_shoot_timer > 0)
	{
		ice_spike_shoot_timer--
		usingPower1 = true;
	}
	else 
	{
		var icespike = instance_create_depth(x+(10*face), y - (sprite_height/1.5), depth, oIceSpike);
		var new_damage = map_value(power_key_held_timer, 0, power_key_held_time, 30, 10);
		var new_spd = map_value(power_key_held_timer, 0, power_key_held_time, icespike.speed*1.5,  icespike.speed/1.5);
		
		icespike.damage = new_damage;
		icespike.speed = new_spd;
		image_blend = prev_blend
		icespike.owner = id;
		power_key_held_timer = 0
		state = stateFree;
	}
	
}

//ice ball
ice_ball_shoot_time = 10;
ice_ball_shoot_timer = 0;
statePower2 = function()
{
	decelerate()
	if (power_key_held_timer > 0)
	{
		power_key_held_timer--
		if (powerkey2 || bBtn) ice_ball_shoot_timer = ice_ball_shoot_time
	}

	if (ice_ball_shoot_timer > 0)
	{
		ice_ball_shoot_timer--
		usingPower2 = true;
	}
	else 
	{
		var ki_cost = 2;
		if ki > ki_cost{
			var _pro = fire_projectile_dir(x, y-(sprite_height/2), face ? 0 : 180, oIceBall, 20, 5, id);
				//_pro.sprite_index = sIceBall
				//_pro.owner = id
			ki -= ki_cost;
		}
		//var iceball = instance_create_depth(x+(10*face), y - (sprite_height/1.5), depth, oIceBall);
		//var new_damage = map_value(power_key_held_timer, 0, power_key_held_time, 30, 10);
		//var new_spd = map_value(power_key_held_timer, 0, power_key_held_time, iceball.speed*1.5,  iceball.speed/1.5);
//
		//iceball.damage = new_damage;
		//iceball.speed = new_spd;
		//iceball.owner = id;
		
		power_key_held_timer = 0
		state = stateFree;
	}
	
}
state = stateFree;
state_name = "";



