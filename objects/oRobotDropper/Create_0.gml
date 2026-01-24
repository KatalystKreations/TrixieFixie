loaded = false;
alarm[0] = aSECOND;
dropping = false;


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

