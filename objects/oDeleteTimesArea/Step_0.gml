if place_meeting(x,y,oPlayer_par){
	if (!colliding) {
		colliding = true;
		save_open()
		ini_section_delete("Times")
		save_open(false)
		
		with (oBestTime) { event_perform(ev_create, 0) }
		
		show_debug_message("You deleted the Best Times.")
		particle(psDeleteSave)
	}
}
else {
	colliding = false;
}