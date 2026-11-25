active = false;
getCollisionVars()

var r = scr_raycast(x,bbox_top,x,0, collision, false, id)
max_detection_point_y = r ? r.y : 0

function activate(){
	global.spawn_x = x;
	global.spawn_y = y;
	
	with (oPlayer_par) {
		if (state_is(stateDead)) {
			hp = hp_max
			x = other.x
			y = other.y
			particle(psCheckPoint)
		}
	}
	with (oStormWall) {
		if !other.active {
		global.storm_x = x - (10*aBLOCK);
		global.storm_y = y;
		global.storm_spd = speed;
		global.storm_tspd = target_speed
		}
	}
	
	//Stop Timer if level completed.
	if last {
		oTimer.active = false
		oTimer.save_time()
	};
		
	active = true
	
}