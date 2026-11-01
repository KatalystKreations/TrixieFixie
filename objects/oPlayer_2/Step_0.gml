 ////inputs
	//rightKey = keyboard_check( vk_numpad6);
	 //leftKey = keyboard_check( vk_numpad4 );
	 //downKey = keyboard_check( vk_numpad5 );
	 //downKeyPressed = keyboard_check_pressed( vk_numpad5 );
	 //upKey = keyboard_check( vk_numpad8 );
	 //jumpKeyPressed = keyboard_check_pressed( vk_numpad8 );
	 //runKey = keyboard_check(vk_rshift);
	 //grounded = place_meeting( x, y+1, collision);
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
	head_clear = !collision_line(x, y-5, x, y-sprite_get_height(spr_idle), collision, false, false); 
// Gravity
	if (yspd > 0) 		{ grav = jumpGrav;} 
	else if (downKey)	{ grav = forceGrav; if !onGround create_dust(oDustWallSlide)}
	else  		  		{ grav = regGrav; }
// Cutscenes
	//if (instance_exists(oCutscene)) {
	//state = stateCutscene;
	//}

#endregion



// Exit if Paused
if gamestate_is(GAMESTATE.PAUSED) exit;

//Gravity



//run state code if game is not paused
if gamestate_is(GAMESTATE.PLAYING) || gamestate_is(GAMESTATE.DEAD) state();








//Hit Stuff
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


#region Sounds
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



#region Sprite Control
	mask_index = spr_idle
	image_xscale = face;
	//scale image speed to player speed
	if (xmoving && sprite_index_is(sPlayer1Run)) image_speed = clamp(abs(xspd) / moveSpd[runType], 0.1, 1.4) else {
		image_speed = 1;
	}
	

//ground sprites
	if (grounded){ 
		
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
//air sprites
	else {
		
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
			
		if (yspd > -1 && yspd < 1) { sprite_index = spr_jump_trans}
	}
	//start on first frame
	if (current_sprite != sprite_index) {
	current_sprite = sprite_index;
	image_index = 0
	}
#endregion