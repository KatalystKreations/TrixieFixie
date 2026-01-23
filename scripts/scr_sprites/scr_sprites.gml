
/// @desc Change to a sprite.
/// @param {any*} _spr The sprite to change to.
function sprite(_spr){
	sprite_index = _spr;
}


function sprite_image_index_loop(_start = 0, _end = 0){
	static loops = 0
	if image_index > _end {
		image_index = _start
		loops++
		}
	return loops;
}

function sprite_image_index_is(_image_index = 0){
	if floor(image_index) = _image_index {return true}else return false
}
function sprite_image_index_isPast(_image_index = 0){
	if image_index > _image_index {return true}else return false
}
function sprite_image_index_isBefore(_image_index = 0){
	if image_index < _image_index {return true}else return false
}

function sprite_index_is(_sprite_index = undefined){
	if _sprite_index = undefined exit;
	if sprite_index == _sprite_index {return true} else return false
}



function sprite_animation_end(){
	if image_index > image_number-1 {
		return true;
		}else return false
}

