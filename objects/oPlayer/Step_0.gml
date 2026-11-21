//show_debug_message(string("Dash Time: {0}", dashTime)) 
//show_debug_message(string("Dash Timer: {0}", dashTimer)) 
//show_debug_message(string("Dash CooldownMax: {0}", dashCooldownMax)) 
//show_debug_message(string("Dash Cooldown: {0}", dashCooldown)) 
//show_debug_message(string("-----------------")) 

// Curves
curve_step()

#region // Detect //
// Inputs
	getControls(ord("D"), ord("A"), ord("S"), ord("W"), vk_lshift, _player_id)
	getGPcontrols(_player_id)
	getPowerControls(_player_id)
	runKey += xBtn;
	clamp(runKey, 0, 1)
// Ground
	grounded = place_meeting( x, y+1, collision);
	ground = instance_place(x, y+1, collision[0])
// Direction
	moveDir = rightKey - leftKey;
	xmoving = xspd != 0
	if ((moveDir != 0) && (wall_jump_delay == 0)) 
	{face = sign(moveDir)}
// Wall Side
	if (face == 1)  {side = bbox_right}
	if (face == -1) {side = bbox_left}
// Jump
	if (jumpKeyPressed || aBtnPressed)  { jumpBufferTimer = jumpBufferTime; }
	if (!upKey && !aBtn) { jumpTimer = 0; }
	jumpBufferTimer = max(jumpBufferTimer-1, 0) 
//Head Clear 	
	head_clear = !collision_line(x, y-15, x, y-sprite_get_height(spr_idle), collision, false, false); 
// Gravity
	if (yspd > 0) 		{ grav = jumpGrav;} 
	//else if (downKey)	{ grav = forceGrav; if !onGround create_dust(oDustWallSlide)}
	else  		  		{ grav = regGrav; }
// Cutscenes
	//if (instance_exists(oCutscene)) {
	//state = stateCutscene;
	//}

#endregion



// Exit if Paused
if gamestate_is(GAMESTATE.PAUSED) exit;

//two player
if (!instance_exists(oPlayer_2) && keyboard_check_pressed(vk_numpad5)){
	instance_create_depth(x, y, depth, oPlayer_2, {_player_id: 1})
}


//run state code if game is not paused
if gamestate_is(GAMESTATE.PLAYING) || gamestate_is(GAMESTATE.DEAD) {
	state();
	if (state_is(stateCrawl, stateCrouch, stateSlide)) {
		#region Combat
			if (mouse_check_button_pressed(mb_left) || rtBtn_pressed) {
				_h = noone;
				var
				_x = 25.20, 
				_y = -6.60, 
				_xs = 3.90, 
				_ys = 0.82, 
				_frames = 1 
				
				_h = spawn_hitbox(
					_x,  _y, 
					damage, 
					_frames, 
					_xs, _ys
				)
				 
			}	
		#endregion
		
	}
}






#region Getting Hit 
if (hit)
{
	hit = false;
	hit_flashTimer = hit_flashTime
}
if (hit_flashTimer)
{
	hit_flashTimer--
	hit_flash = true
}else 
{
	hit_flash = false;
}
#endregion

#region //Sounds
	//footsteps
	if (footstep_cooldown==0 && xmoving && (floor(image_index) == 3 || floor(image_index) == 8)) {
		footstep_cooldown = footstep_cooldown_max;
		//play alternate snds
		footstep_snd++
		if (is_even(footstep_snd)){
			audio_play_sound(snd_footstep_01, 1, false, 1, 0, random_range(0.8, 1.3))
		}
		else {
			audio_play_sound(snd_footstep_02, 1, false, 1, 0, random_range(0.8, 1.3))
		}
	}	
	footstep_cooldown = max(footstep_cooldown-1, 0)
	
#endregion



#region //Sprite Control
	mask_index = spr_idle
	image_xscale = face;
	//scale image speed to player speed
	if (xmoving && sprite_index_is(sPlayer1Run_weapon)) 
		image_speed = clamp(abs(xspd) / moveSpd[runType], 0.1, 1.4) else {
		image_speed = 1;
	}

	#region //Dash
	if (dashTimer > 0) {
		if onGround{
			sprite(spr_dashFlip)
			image_index = map_value(dashTimer, 1, dashTime*2, image_number-1, 0)
		}
		else sprite(spr_dashAir)
		mask_index = spr_slide; 
	}
	#endregion 
	#region //ground sprites
	else if (grounded){ 
		
	//make dust
		if (xmoving && (floor(image_index) == 3 || floor(image_index) == 8)) {
	        if (floor(image_index) != image_index_previous) {
	            instance_create_layer(x, y, "FX", oDustRun);
				image_index_previous = floor(image_index);
	        }
    	}
		//run
		if (xspd != 0){ 
				if (sign(xspd) == face){
					sprite_index = spr_run
				}
				else {
					sprite_index = spr_turn
					with (instance_create_layer(x+10 * face, bbox_bottom, "FX", oDustWallSlide)){}
				}
		}
		//idle
		if (xspd == 0){ 
			sprite_index = spr_idle;
		}
		//sliding
		if (is_sliding){
			mask_index = spr_slide; 
			sprite_index = spr_slide
			with (instance_create_layer(x, bbox_bottom, "FX", oDustWallSlide)){}
		}
		if (crouching){
			mask_index = spr_slide; 
			sprite_index = spr_crouch
		}
		if (crawling){
			mask_index = spr_slide; 
			sprite_index = spr_crawl
		}
		if (grabbing_ledge){
			sprite_index = spr_ledgegrab
		}
	}
	#endregion
	#region //air sprites
	else if (pivot_point) {
			sprite(sPlayer1Swing_weapon)
		}
		else{
		
		//if falling
		if (yspd > 0){ 
			sprite_index = spr_fall;
			if (on_wall) {
			sprite_index = spr_wallslide
				
				wall_dust++
				if (wall_dust<2) with (instance_create_layer(side, bbox_bottom, "FX", oDustWallSlide)){
					//other.wall_dust = 0;
					hspeed = -other.face*0.25
				}else {
					wall_dust = 0;  
				}
			}
		} 
		//if rising
		if (yspd < 0){ sprite_index = spr_jump}
		if (yspd > -2 && yspd < 2) { sprite_index = spr_jump_trans}
		//if slideboosting
		if (slideBoostTimer > 0){
			sprite(spr_dashFlip)
			//image_index = map_value(slideBoostTimer, 1, slideBoostTime*2, image_number-1, 0)
			
			var ray = scr_raycast(x,y,x,room_height,collision,false,id)
			if (ray) {
				// Timer should be equal to 58 from 60 when it gets here
				if (slideBoostTimer == slideBoostTime-2) {
					dash_height = ray.y
				}
				
			}
			else {
				dash_height = room_height
			}
			var dist_from_ground = distance_to_point(x, dash_height)
			var halfway = (image_number-1) /2;
			var fullway = (image_number-1)
			if (yspd < 0)
			{
				image_index = map_value(dist_from_ground, 0, aBLOCK * 2, 0, halfway-1);
			}
			else
			{
				image_index = map_value(dist_from_ground, aBLOCK * 2, 0, halfway, fullway);
			}
			
			// DASH FX //
			dash_fx()
		}
	}
	#endregion
	
	//start on first frame
	if (current_sprite != sprite_index) {
	current_sprite = sprite_index;
	image_index = 0
	}
#endregion