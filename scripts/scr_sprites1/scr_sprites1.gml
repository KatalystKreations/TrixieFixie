
/// @desc Change to a sprite.
/// @param {any*} _spr The sprite to change to.
function sprite(_spr){
	sprite_index = _spr;
}

/// @desc Returns an asset using a base and ending.
/// @param {string} _sprAction Name of sprite after the underscore (eg. "Run" in sHeteknn_Run)
/// @param {string} [_sprBaseName]= Name of Base after "s" before the underscore (eg. "Heteknn" in sHeteknn_Run)
function sprAsset(_sprAction, _sprBaseName = variable_global_exists("playerName") ? global.playerName : "Heteknn"){
	return asset_get_index(string("s{0}_{1}", _sprBaseName, _sprAction) )
}


/**
* @desc Gets the middle of a sprite horizontally.
* @param {asset.gmsprite} [_spr]=  The sprite to get the horzontal middle of. 
 * * If you put 0 it will get the width of the deformed sprite_index.
 * * Defaults to spr_idle if it exists, otherwise it defaults to sprite_index.
* @returns {real} 
*/
function sprMidX(_spr = variable_instance_exists(id, "spr_idle") ? spr_idle : sprite_index){
	return _spr != 0 ? (x + sprite_get_width(_spr)/2) : x + sprite_width/2
}

/**
* @desc Gets the middle of a sprite vertically.
* @param {asset.gmsprite} [_spr]=  The sprite to get the vertically middle of. 
 * * If you put 0 it will get the height of the deformed sprite_index.
 * * Defaults to spr_idle if it exists, otherwise it defaults to sprite_index.
* @returns {real} 
*/
function sprMidY(_spr = variable_instance_exists(id, "spr_idle") ? spr_idle : sprite_index){
	return _spr != 0 ? (y + sprite_get_height(_spr)/2) : y + sprite_height/2
}

function num_plus(_waitFrames = 0){
	static num = 0;
	static numwaiter = 0;
	
	numwaiter++
	if numwaiter >= _waitFrames {
		num++;
		numwaiter = 0;
	}
	return num;
}

function sprite_image_index_loop(_start = 0, _end = image_number-1){
	static loops = 0
	if image_index > _end {
		image_index = _start
		loops++
		}
	return loops;
}


/**
 * Check if current object is on the defined image index.
 * @param {real} [_image_index]=0 The frame to check for.
 * @returns {bool} 
 */
function sprite_image_index_is(_image_index = 0){
	return floor(image_index) = _image_index;
}
function sprite_image_index_isPast(_image_index = 0){
	return image_index > _image_index;
}
function sprite_image_index_isBefore(_image_index = 0){
	return image_index < _image_index;
}

/**
 * Checks if current object is the defined sprite. Optionally checks if the sprite is on the defined image index.
 * @param {asset.gmsprite} _sprite_index The sprite to check for.
 * @param {real} [_img_index] OPTIONAL! The frame to check for.
 * @returns {bool} Description
 */
function sprite_index_is(_sprite_index, _img_index = undefined){
	if _img_index = undefined {
	return (sprite_index == _sprite_index);
	}
	else {
		return (sprite_index == _sprite_index && sprite_image_index_is(_img_index));
	}
}


// Doesen't work
function sprite_animation_end(_spr = sprite_index){
	if sprite_index != _spr exit;
	
	if image_index > image_number-1 {
		return true;
		}else return false
}

