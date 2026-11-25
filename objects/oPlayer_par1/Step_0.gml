

#region // Detect //
// Inputs
	getControls()
	getGPcontrols(player_num)
	getPowerControls()
	runKey += xBtn;
	clamp(runKey, 0, 1)
// Ground
	onGround = place_meeting( x, y+1, collision);
	ground = instance_place(x, y+1, collision[0])
// Direction
	moveDir = rightKey - leftKey;
	xmoving = xspd != 0
	if ((moveDir != 0) && (wall_jump_delay == 0)) 
	{face = sign(moveDir)}
// Wall Side
	if (face = 1)  {side = bbox_right}
	if (face = -1) {side = bbox_left}
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
	if (instance_exists(oCutscene)) {
	state = stateCutscene;
	}


#endregion

#region // Timers //
// Slide
	slideTimer = max(slideTimer-1, 0)

#endregion




// Gamestate
if (gamestate_is(GAMESTATE.PLAYING) 
|| gamestate_is(GAMESTATE.RESTARTING)) 
{
	state();
	ui_player_layer(true);
}
else if (gamestate_is(GAMESTATE.PAUSED)) 
{ ui_player_layer(false); }




hit_stuff(5, 30)
#region // Abilities
	
	if (rbBtn_released && state != stateDead) {
		// Iceball
		event_perform(ev_mouse, ev_global_left_release)
	}
	if (lbBtn_released && state != stateDead) {
		// Retract
		event_perform(ev_mouse, ev_global_middle_press)
	}

	#region Hold Stuff
		if ((rtBtn || mouse_check_button(mb_right)) && state != stateDead) {
			if (!sprite_index_is(spr_hold) && !sprite_index_is(spr_pickup)) {
				is_picking_up = true
				sprite(spr_pickup)
			}
			if (is_holding) {
				if (obj_holding == noone && !sprite_index_is(spr_hold)) {
					
					
				    var obj_available = [];
					
				    // Collect holdable objects
				    with (collision_circle(x, y-32, aBLOCK*1.5, oHoldable, false, true)) {
						
				        if (can_hold) {
				            array_push(obj_available, id);
				        }
				    }
				
				    // Find nearest manually
				    var nearest = noone;
				    var best_dist = 64;
				
				    for (var i = 0; i < array_length(obj_available); i++) {
				        var inst = obj_available[i];
				        var d = point_distance(x, y-32, inst.x, inst.y);
				
				        if (d < best_dist) {
				            best_dist = d;
				            nearest = inst;
				        }
				    }
				
				    // Choose the nearest object
				    if (nearest != noone) {
						obj_holding = nearest;
				    }
				}
				// Snap the nearest object to the player
			    if (instance_exists(obj_holding)) {
				
				    // Snap their bottom to your top
				    snap_bottom_to_top(obj_holding, id);

				    // Snap horizontally if you want
				    snap_center_x_to_center_x(obj_holding, id)
				
				    // Drop if they can't be held
				    if (!obj_holding.can_hold) obj_holding = noone;
				}
				
			}
			
		}else {
			is_holding = false;
			is_picking_up = false;
			obj_holding = noone;
		}
	#endregion
	
	// Teleport
		if ((downKeyPressed || bBtnPressed) && hit_flashTimer>0) {
			cutSpd()
			state = stateTpFromDanger;
		}

#endregion




#region // Sprite Control
	var name = global.playerName; // Store player name

	mask_index = spr_idle
	image_xscale = face;
	//scale image speed to player speed
	if (sprite_index_is(spr_run)) {
		image_speed = clamp(abs(xspd) / moveSpd[runType], 0.1, 1.0) 
	}
	else {
		image_speed = 1;
	}
	
	
	
	//override normal
	if (state == stateDead){
		// One Time Death Effects
		if !sprite_index_is(spriteAsset("Dead")){
			// Death particle
			part_particles_burst(global.partSystMain, x, y, psDead);
			// Shake Camera
			camera_shake(6, 10)
			// Play death sound
			audio_play_sound(sndGoofyDeath, 1, 0, 1, 0, random_range(.9, 1.2))
		}
		// Death Sprite
		sprite(spriteAsset("Dead"))
	
	}else
	if ( state == stateTpFromDanger ) {
		image_speed = 1
		sprite_index = spr_hit_tp
	}else
	if (hit_timer){
		if (state != stateTpFromDanger) {
			sprite_index = spr_hit;
			sprite(asset_get_index(string("s{0}_Hit", global.playerName) ) ) // Hit
		}
		
		if instance_exists(oHitbox){
		face = sign(instance_nearest(x, y, oHitbox).owner.x - x) }
		//xspd = -(.6*face)
		
	}else if (usingPower1){
		sprite_index = spr_power1
	}
	else if (usingPower2){
		sprite_index = spr_power2
	}
	else if (after_power_timer){
		sprite_index = spr_power_after
	}
	else if (is_picking_up && !is_holding){
		// do nothing
	}
	//normal 
	else {
		
	if (is_sliding) {
	    sprite(asset_get_index(string("s{0}_Slide", name) ) ); // Sliding
		mask_index = spr_crouch
	}
	else if (crawling) {
		sprite(asset_get_index(string("s{0}_Crawl", name) ) ) // Crawling
		mask_index = spr_crouch
	}
	else if (crouching) {
		sprite(asset_get_index(string("s{0}_Crouch", name) ) ) // Crouching
		mask_index = spr_crouch
	}
	else if (!onGround) {
		// Falling
	    if (yspd > 2) {
			sprite(on_wall ? spr_wallslide : spriteAsset("Fall") )
	    }
		// Falling slow right after jump
		else if (yspd > 0) {
			sprite(on_wall ? spr_wallslide : spriteAsset("JumpTrans") )
		} 
		// Jump again in air
		else if (jumpCount > 1 && yspd < 0) {
			sprite(asset_get_index(string("s{0}_JumpDouble", name) ) ) // Jump Double
			if (upKey) {
				sprite_image_index_loop(0, 2)
			}
	    } 
		// Regular Jump up
		else {
			sprite(spriteAsset("Jump") ) // Jump
	    }
	}
	// Moving
	else if (xspd != 0) {
		sprite(
			sign(xspd) == face 
			? spriteAsset("Run") // Run
			: spriteAsset("Turn")  // Turn
		)
	}
	// Not Moving
	else {
		sprite(spriteAsset("Idle") ) // Idle
			image_speed = 1;
	}
	}
	
	
	
	
	
	if (sprite_index_is(spr_power1) || sprite_index_is(spr_power2)) {
		spr_power1_image_index++
		//if spr_power1_image_index > image_number spr_power1_image_index = 0;
		var _new_image_index = map_value(spr_power1_image_index, 0, 50, 0, image_number)
		if (image_blend != charge_abilty_col) {
			image_index = _new_image_index;
			image_speed = 1;
		}
		after_power_timer = after_power_time;
	}else {
		after_power_timer = max( after_power_timer-1, 0 )
		spr_power1_image_index = 0;
	}
	
	
	//start on first frame
	if (current_sprite != sprite_index) {
	current_sprite = sprite_index;
	image_index = 0
	}
#endregion



// Death
	if (hp <= 0 && gamestate_is(GAMESTATE.PLAYING)){
		set_gamestate(GAMESTATE.RESTARTING);
		//Particles
		//part_particles_burst(global.partSystMain, x, y, ps_iceball_frost)
		// Restart Room after a second
		oGame.alarm[0] = aSECOND
		
	}
	if (hp <= 0) {
		state = stateDead;
	}