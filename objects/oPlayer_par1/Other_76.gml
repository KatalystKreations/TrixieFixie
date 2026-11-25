if (layer_instance_get_instance(event_data[? "element_id"]) != id) exit


switch (event_data[? "message"]) {
	
	case "footstep": {
	footstep_snd++
		if (is_even(footstep_snd)){
			audio_play_sound(snd_footstep_01, 1, false, 1, 0, random_range(0.8, 1.3))
		}
		else {
			audio_play_sound(snd_footstep_02, 1, false, 1, 0, random_range(0.8, 1.3))
		}
	}
	break;
	case "holding":
		is_holding = true;
		is_picking_up = false;
		break;
	// ... more cases for other messages
}

