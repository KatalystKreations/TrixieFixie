
event_inherited();

// Attack
	loaded = false;
	alarm[0] = aSECOND;
	dropping = false;

//Move
	moveDir 	= 0;
	xspd 		= 0;
	yspd 		= 0;
	face 		= 1;
	moveSpd 	= 5;

//Sprites
	spr_idle = sRobot_Dropper_WalkEmpty
	spr_walk = sRobot_Dropper_WalkEmpty
	spr_walkFull = sRobot_Dropper_WalkLoaded
	spr_death = sRobot_Dropper_Death



/// @desc Start on first frame of an animation
/// @returns {bool}
cur_sprite = sprite_index;
function check_sprite(){
	if (cur_sprite != sprite_index) {
		cur_sprite = sprite_index;
		image_index = 0;
		return true;
	}else return false;
}

