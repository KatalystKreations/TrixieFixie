// Start Alarm 
if !alarm[0] alarm[0] = 3*aSECOND;

for (var i = 0; i < char_count; i++) {
    var c = char_state[i];

    if (c.progress < c.finish) {
        c.progress += flip_speed;

        // Random glyph while flipping
        var glyph = irandom_range(33, 126); // printable ASCII
        c.current = chr(glyph);
		
		// Stop alarm if still flipping characters
		alarm[0] = -1;
		
		// Play sound while flipping
		if !audio_is_playing(sndAudio_for_video_editing) playsound(sndAudio_for_video_editing, false, 1, .9, 1.2, 1, 2.5)
    }
    else {
        // Lock in final letter
        c.current = c.target;
    }

    char_state[i] = c;
}

if (alarm[0]) {
	audio_stop_sound(sndAudio_for_video_editing)
}

if (startFade) {
	fadetoDeath(.015)
}