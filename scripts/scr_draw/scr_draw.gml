	
/// @desc  Make it look like it's glowing... in every direction.
/// @param {real} [_border]= (1) Size.
/// @param {constant.color} [_col]= (c_white) Color.
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

/// @desc  Make it look like it's glowing.
/// @param {real} [_border]= (1) Size.
/// @param {constant.color} [_col]= (c_white) Color.
function draw_one_glow(_border = 1, _col = c_white){
	var outline_color 	= _col;
	var thickness 		= _border;
	gpu_set_blendmode(bm_add)	
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale + (thickness/20), image_yscale + (thickness/20), image_angle, outline_color, 1);
	gpu_set_blendmode(bm_normal)	
}

/// @desc  Makes objects look hovered over. Returns what is hovered over.
/// @returns {id} Description
function draw_clickable(){
	var _image_blend = #ffffff;
	var _id 		 = undefined;
	if (position_meeting(mouse_x, mouse_y, id)) 
	{
		_image_blend = #636363;
		_id 		 = id;
	}
	
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, _image_blend, image_alpha)
	return _id
}


/**
 * Set the scale of both x and y.
 * @param {real} [scale]=1 The scale.
 */
function image_set_scale(scale = 1) { 
	image_xscale = scale;
	image_yscale = scale;
}

/**
 * Multiply the scale of both x and y.
 * @param {real} [scale]=1 The scale.
 */
function image_scale(scale = 1) { 
	if (variable_instance_exists(id, "start_image_xscale")) {
		image_xscale = start_image_xscale * scale
		image_yscale = start_image_yscale * scale
	}else{
		image_xscale *= scale;
		image_yscale *= scale;
	}
}




/// @desc Create a dust object.
/// @param {asset.gmobject} [_dust]= Dust Object
/// @param {real} [_x]= x 
/// @param {real} [_y]= y 
/// @returns {id} Description
function create_dust(_dust = oDustLand, _x = x, _y = y) {
	var landDust = instance_create_layer(_x, _y, "FX", _dust);
	return landDust;
}

