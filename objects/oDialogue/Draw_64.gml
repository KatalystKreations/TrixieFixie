
if !variable_instance_exists(messages[current_message], "name") exit;

var _dx = 0;
var _dy = gui_h * 0.7 - add_margin_y;
var _boxw = gui_w;
var _boxh = gui_h - _dy;
var 
margin_x = add_margin_x,
margin_y = add_margin_y,
padding_x = 16,
padding_y = 13;

if (spawn_top){
	_dy = 0 + add_margin_y
}
if (spawn_wide) {
	margin_x = 0
}


//Draw the box
	draw_sprite_stretched(
	spr_box, imageIndex, 
	_dx + margin_x, 		//left
	_dy, 					//top
	_boxw - (margin_x*2), 	//right
	_boxh - margin_y		//bottom
	);

//Set Up the Text
	_dx += padding_x;
	//_dy += padding_y;
	draw_set_font(fPixel_Big);
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)

//First Draw the Name
	var _name = messages[current_message].name;
	draw_set_color(global.char_colors[$ _name])
	draw_set_halign(halign)
	var prev_dx = _dx;
	if (halign == fa_center)  { _dx = (gui_w/2); }
	draw_text(_dx+margin_x, _dy, _name);
	draw_set_color(c_white)


_dy += padding_y*3 + 6;
_dx = prev_dx;
if (halign == fa_left) _dx -= margin_x
//Draw a line
	draw_sprite_stretched_ext(
	spr_box_line, 1, 
	_dx + padding_x + margin_x,
	_dy, 
	_boxw - (padding_x + margin_x)*4, 
	1,
	-1,
	.9
	)

//Then the Dialogue Below the Name
	
	var final_text_width = _boxw - (_dx * 2) - (margin_x * 2);
	if (halign == fa_center)  { _dx = (gui_w/2); }

	draw_text_ext(
	_dx + margin_x, 				//left coords
	_dy, 							//top coords
	draw_message, 					//text
	-1, 							//sep?
	final_text_width				//How long the text gets before breaking to the next line (width)
	)


draw_reset()