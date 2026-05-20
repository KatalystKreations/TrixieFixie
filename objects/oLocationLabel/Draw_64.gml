
display_set_gui_size(getCamW(), getCamH());
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(fLocationText)
//draw_text_ext_transformed(x, y, locationText, 10, -1, 1, 1, 0)

//// Flip curve
//var yScl_val = animcurve_channel_evaluate(curve_channel, curve_head)
	//curve_head = min(curve_head+curve_speed, 1); 
//
//var txt = locationText;
//var newTxt = "";
//for (var i = 0; i < string_length(txt); i++) {
	//
	//draw_text_ext_transformed(
		//x+(i*20), 
		//y+(string_height(txt)*yScl_val/2), 
		//string_char_at(txt, i+1), 
		//100, 
		//-1, 
		//1, 
		//yScl_val, 
		//0
	//)
//}

draw_set_font(fLocationText);
draw_set_halign(fa_left);

var padx = 20,
	pady = -20
var xx = x+padx;
var yy = y+pady;


for (var i = 0; i < char_count; i++) {
    var c = char_state[i];
	var _col = c_aqua;
	
    draw_text_colour(xx, yy, c.current, c_white,c_white,_col,_col, image_alpha);
    xx += string_width(c.current);
	
}




draw_set_halign(fa_left)
draw_set_font(-1)
display_set_gui_size(-1, -1);