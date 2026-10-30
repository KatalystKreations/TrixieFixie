var h = string_format(hour,   2, 0);
var m = string_format(minute, 2, 0);
var s = string_format(second, 2, 0);

save_open(true)

this_time = timer

if (this_time < best_time) {
	
}
save_progress(string(room_get_name(room)) + "_Time", "Timer - " + h + ":" + m + ":" + s)

save_open(false)

