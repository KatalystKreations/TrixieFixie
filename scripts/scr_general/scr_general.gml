#macro aSecond 60 

/// map_value(value, in_min, in_max, out_min, out_max)
function map_value(val, in_min, in_max, out_min, out_max) {
    return out_min + ((val - in_min) / (in_max - in_min)) * (out_max - out_min);
}

/// is_even(num)
function is_even(num) {
    return num mod 2 == 0;
}



function room_is(_room){
	if (room == _room) return true;
		return false;
}


/**
 *  Places everything back at it's spawnpoint.
 */
function restart(){
    with all
	{
    x = xstart;
    y = ystart;
    }
    
    with oPlayer
	{
    x = global.spawn_x;
    y = global.spawn_y;
	hp = hp_max
    }
	if instance_exists(oPlayer_2){
	 	with oPlayer_2
		{
	    x = global.spawn_x-32;
	    y = global.spawn_y;
		hp = hp_max
    }}
	with (oToolSwitch) {
		
	}
	set_gamestate(GAMESTATE.PLAYING)
    
}