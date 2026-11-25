
if (place_meeting(x,y,oPlayer_par) && spawn_interval <= 0) {
	spawn_interval = 10
	if instance_number(oRobotPlane) >= 3 exit;
	
	spawnPlane()
	uses--
	if uses <= 0
	instance_destroy()
	
}
// Count down
spawn_interval = max(spawn_interval-1, 0)