
if (!place_meeting(x, y, oEnemy_par) && !roomClear) {
	roomClear = true;
	with (oMachineDoor) {
		if (room_id == other.room_id) {
			open()
		}
	}
}
else 
if ( place_meeting(x, y, oEnemy_par) && roomClear){
	roomClear = false;
	with (oMachineDoor) {
		if (room_id == other.room_id) {
			close()
		}
	}
}
