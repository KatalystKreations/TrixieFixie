if (room_music != noone) {
	if (!audio_is_playing(room_music)) {
		 audio_play_sound(room_music, 0.5, 1, volume)
	}
}else if room_music == noone{
	audio_stop_all()
}

