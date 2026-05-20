
display_set_gui_size(getCamW(), getCamH());
draw_set_font(fLocationText);
draw_set_valign(fa_middle);
draw_set_halign(fa_left);

var xx = 0 + padx;
var yy = getCamH() + pady;

for (var i = 0; i < char_count; i++) {
    var c = char_state[i];
	var _col = col;
	
    draw_text_colour(xx, yy, c.current, c_white,c_white,_col,_col, image_alpha);
    xx += string_width(c.current);
	
}




draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_font(-1)
display_set_gui_size(-1, -1);