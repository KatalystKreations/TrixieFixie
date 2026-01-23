
if !fadedin{
	if fadein(1, fadeinSpd) {
		fadedin = true;
		alarm[fade_out_alarm] = second;
		
	} else {
		volume-=fadeinSpd
		audio_master_gain(volume)
	}
}

if time_to_fade_out {
	volume+=fadeoutSpd
	audio_master_gain(volume)
	fadetoDeath(fadeoutSpd)
}