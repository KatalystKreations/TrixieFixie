
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