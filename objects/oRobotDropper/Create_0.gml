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





cur_sprite = sprite_index;
/// @desc Start on first frame of an animation
/// @returns {bool}
function check_sprite(){
	if (cur_sprite != sprite_index) {
		cur_sprite = sprite_index;
		image_index = 0;
		return true;
	}else return false;
}

