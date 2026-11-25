
//Player
global.spawn_x = 0;
global.spawn_y = 0;

//Storm
global.storm_x = 0;
global.storm_y = 0;
global.storm_spd = 0;
global.storm_tspd = 0;

//Room
global.current_room = room;
global.rm_change = false;
function room_is_changed(){
	return global.current_room != room
}
function make_current_room(){
	global.current_room = room;
}