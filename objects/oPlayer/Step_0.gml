 //inputs
	rightKey = keyboard_check( ord("D") );
	leftKey = keyboard_check( ord("A") );
	downKey = keyboard_check( ord("S") );
	downKeyPressed = keyboard_check_pressed( ord("S") );
	upKey = keyboard_check( ord("W") );
	jumpKeyPressed = keyboard_check_pressed( ord("W") );
	runKey = keyboard_check(vk_lshift);
	grounded = place_meeting( x, y+1, oWall);
	head_clear = !place_meeting(x, y-sprite_get_height(sPlayer1Idle_weapon), oWall); 
	//move direction and face (IMPORTANT)
		moveDir = rightKey - leftKey;
		if (moveDir != 0 &&  (wall_jump_delay == 0)) {face = sign(moveDir)}
			//wall side
				if (face = 1) side = bbox_right
				if (face = -1) {side = bbox_left}
	//detect jump input for buffer frames
		if (jumpKeyPressed)  { jumpBufferTimer = jumpBufferTime; }
		if (!upKey) { jumpTimer = 0; }
		jumpBufferTimer = max(jumpBufferTimer-1, 0) 

// Exit if Paused
if gamestate_is(GAMESTATE.PAUSED) exit;

//two player
if (!instance_exists(oPlayer_2) && keyboard_check_pressed(vk_numpad5)){
	instance_create_depth(x, y, depth, oPlayer_2)
}

//Gravity
		if (yspd > 0) {grav = jumpGrav} 
		else {grav = regGrav}
		yspd += grav;
		//Cap the max falling speed
		if yspd > maxGravSpd {yspd = maxGravSpd}
			


var state_name = "";
switch (state) {
    case stateFree:  	state_name = "free";  break;
    case stateCrouch: 	state_name = "crouch"; break;
    case stateCrawl: 	state_name = "crawl"; break;
    case stateSlide:	state_name = "slide"; break;
    case stateOnWall:	state_name = "onWall"; break;
}
//show_debug_message(string(state_name))


//run state code if game is not paused
if gamestate_is(GAMESTATE.PLAYING)	state();




#region //X Collisions
		var _subPixel = .5;
		if place_meeting( x + xspd, y, oWall )
		{	
			//slopes up
				if (!place_meeting(x + xspd, y-1 - abs(xspd), oWall) && !downKey)
					while place_meeting(x + xspd, y, oWall) {y-=_subPixel}
			//anything else
				else 
				{
					//check for tiny gaps between walls and player
						var _pixelCheck = _subPixel * sign(xspd);
						while ( !place_meeting( x + _pixelCheck, y, oWall ) ) { x += _pixelCheck }
					//Collide
					xspd = 0
					slideTimer = 0;
					slideBoostTimer = 0
				}
		}
	//Apply X Movement
	x += xspd;
	 xmoving = xspd != 0
#endregion

#region //Y Collisions 
		//Edge Nudging
			if (place_meeting( x, y+yspd, oWall ) && yspd < 0)
			{
				if (!place_meeting( bbox_left, y+(yspd*2), oWall )) {x = bbox_left}
				if (!place_meeting( bbox_right, y+(yspd*2), oWall )) {x = bbox_right}
			}
		_subPixel = .5;
		if place_meeting( x, y+yspd, oWall )
		{
			//check for tiny gaps between walls and player
				var _pixelCheck = _subPixel * sign(yspd);
				while ( !place_meeting( x, y + _pixelCheck, oWall ) ) {y+=_pixelCheck}
			//set speed to 0 to collide
				yspd = 0;
		}
	//Apply
	y += yspd;
	

#endregion


#region Hit Stuff
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
	if (xmoving && sprite_index_is(sPlayer1Run_weapon)) image_speed = clamp(abs(xspd) / moveSpd[runType], 0.1, 1.4) else {
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