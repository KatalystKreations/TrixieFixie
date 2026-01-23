

/// @desc Fades the screen to black and optionally takes you to a room.
/// @param {any*} _room_to_goto Room to goto to. (optional)
/// @param {Real} _fadeinSpd 0.025 Speed to fade in. (optional)
/// @param {Real} _fadeoutSpd 0.05 Speed to fade out. (optional)
function spawn_fade(_room_to_goto = undefined, _fadeinSpd = 0.025, _fadeoutSpd = 0.05){
	if instance_exists(oFade) exit;
	if (instance_exists(oPlayer)){
	oGame.hp = oPlayer.hp
	oGame.hp_max = oPlayer.hp_max
	}
	var _inst = instance_create_depth(0, 0, -9999, oFade)
	_inst.room_to_goto = _room_to_goto;
	_inst.fadeinSpd = _fadeinSpd;
	_inst.fadeoutSpd = _fadeoutSpd;
	return _inst;
}


/// @desc  Fades an object
/// @param {real} [fadeTo]=(0) What to fade to.
/// @param {real} [fadeSpd]=(0.025) How fast is fades.
/// @returns {bool} Description
function fade(fadeTo = 0, fadeSpd = 0.025){
	if image_alpha > fadeTo
	{
		image_alpha -= fadeSpd;
	}else return true;
}

/// @desc  Fades an object and destroys it when done.
/// @param {real} [fadeSpd]=0.05 | How fast is fades.
function fadetoDeath(fadeSpd = 0.05){
		image_alpha -= fadeSpd;
	if image_alpha <= 0 instance_destroy()
	if image_alpha == fadeSpd return true else return false 
}

/// @desc  Fades an object in.
/// @param {real} [fadeInTo]=1 | What to fade in to.
/// @param {real} [fadeSpd]=0.025 | How fast is fades in.
/// @returns {bool} Description
function fadein(fadeInTo = 1, fadeSpd = 0.025){
	if image_alpha < fadeInTo
	{
		image_alpha += fadeSpd;
	}else return true;
}

/**
 * Make it look like it's glowing.
 * @param {real} [_border]=1 Size.
 * @param {constant.color} [_col]=c_white Color.
 */
function draw_glow(_border = 1, _col = c_white){
	var outline_color = _col;
				var thickness = _border;
				gpu_set_blendmode(bm_add)	
				draw_sprite_ext(sprite_index, image_index, x - thickness, y - thickness, image_xscale, image_yscale, image_angle, outline_color, 1);
				draw_sprite_ext(sprite_index, image_index, x + thickness, y - thickness, image_xscale, image_yscale, image_angle, outline_color, 1);
				draw_sprite_ext(sprite_index, image_index, x - thickness, y + thickness, image_xscale, image_yscale, image_angle, outline_color, 1);
				draw_sprite_ext(sprite_index, image_index, x + thickness, y + thickness, image_xscale, image_yscale, image_angle, outline_color, 1);
				
				gpu_set_blendmode(bm_normal)	
}

/**
 * Make it look like it's glowing.
 * @param {real} [_border]=1 Size.
 * @param {constant.color} [_col]=c_white Color.
 */
function draw_one_glow(_border = 1, _col = c_white){
	var outline_color = _col;
	var thickness = _border;
	gpu_set_blendmode(bm_add)	
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale + (thickness/20), image_yscale + (thickness/20), image_angle, outline_color, 1);
	gpu_set_blendmode(bm_normal)	
}

/**
 * Makes objects look hovered over. Returns what is hovered over.
 */
function draw_clickable(){
	var _image_blend = #ffffff;
	if (position_meeting(mouse_x, mouse_y, id)){
		_image_blend = #636363
		_id = id
	}else {
		_image_blend = #ffffff;
		_id = undefined
	}
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, _image_blend, image_alpha)
	return _id
}


/**
 * Makes objects hover in place. (spd mulitplies by amplitude)
 * @param {real} [spd]=0.05 How fast it move up and down.
 * @param {real} [amplitude]=2 How much it moves up it down.
 */
function hover(spd = 0.05, amplitude = .5){
	static timer = 0
	timer++
	y = y + sin(timer * spd) * amplitude
	
}