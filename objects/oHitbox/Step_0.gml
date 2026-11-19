life--;
if (life <= 0) {
    instance_destroy();
}

if (object_is_ancestor(owner.object_index, oPlayer_par)) {
	//show_debug_message("Player made me!")
	if (did_hit) {
		with (owner) {
			if (!grounded) {
				yspd = jspd*1.35;
			}
		}
		instance_destroy()
	}
}