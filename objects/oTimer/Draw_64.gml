if room_is(rm_StartFade) exit;
	 
var total_seconds = floor(timer / aSECOND);

hour   = total_seconds div 3600;
minute = (total_seconds div 60) mod 60;
second = total_seconds mod 60;

var h = string_format(hour,   2, 0);
var m = string_format(minute, 2, 0);
var s = string_format(second, 2, 0);

// Text Position
var _x = display_get_gui_width() / 2;
var _y =  display_get_gui_height() - 20;

// Format
draw_set_halign(fa_center);

// Draw Text
draw_text(_x, _y, "Timer - " + h + ":" + m + ":" + s);

// Reset Format
draw_set_halign(fa_left);