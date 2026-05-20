if !alarm[0] alarm[0] = 3*aSECOND;

for (var i = 0; i < char_count; i++) {
    var c = char_state[i];

    if (c.progress < c.finish) {
        c.progress += flip_speed;

        // Random glyph while flipping
        var glyph = irandom_range(33, 126); // printable ASCII
        c.current = chr(glyph);
		
		alarm[0] = -1;
    }
    else {
        // Lock in final letter
        c.current = c.target;
		
    }

    char_state[i] = c;
}


if (startFade) {
	fadetoDeath(.015)
}