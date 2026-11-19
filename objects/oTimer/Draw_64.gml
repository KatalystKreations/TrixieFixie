if room_is(rm_StartFade) exit;
	 
var total_seconds = floor(timer / aSECOND);

var minute = total_seconds div 60;
var second = total_seconds mod 60;

// hundredths of a second
var ms = floor((timer mod aSECOND) / aSECOND * 100);

var m = pad2(minute);
var s = pad2(second);
var c = pad2(ms);

// Text Position
var _x = display_get_gui_width() / 2;
var _y =  display_get_gui_height() - 20;

// Format
draw_set_halign(fa_center);

// Draw Text
draw_text(_x, _y, "Timer - " + m + ":" + s + "." + c);

// Reset Format
draw_set_halign(fa_left);