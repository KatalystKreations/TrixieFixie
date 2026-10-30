global.spawn_x = x;
global.spawn_y = y;

with (oStormWall) {
	if !other.active {
	global.storm_x = x - (10*aBLOCK);
	global.storm_y = y;
	global.storm_spd = speed;
	global.storm_tspd = target_speed
	}
}

//Stop Timer if level completed.
if last oTimer.active = false;
	
active = true
