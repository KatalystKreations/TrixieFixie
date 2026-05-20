
//Curves
curve_head = 0;
curve_speed = .01;
curve_struct = animcurve_get(anime_TextFlip);
curve_channel = animcurve_get_channel(curve_struct, 0)


flip_speed = 0.025; // how fast each letter progresses

// Create array of character states
char_count = string_length(locationText);
char_state = array_create(char_count);

for (var i = 0; i < char_count; i++) {
    char_state[i] = {
        target: string_char_at(locationText, i+1),
        current: "?",
        progress: 0,
        finish: random_range(1.3, 3.2) // each letter finishes at a different time
    };
}

startFade = false;