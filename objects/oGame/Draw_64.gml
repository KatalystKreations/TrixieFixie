display_set_gui_size(getCamW(1), getCamH(1))

var margin = 20;
var gui_w = getCamW();

// Top-left
draw_player_hud(
    oPlayer,
    margin,
    margin,
    false
);

// Top-right (mirrored)
draw_player_hud(
    oPlayer_2,
    gui_w - margin,
    margin,
    true
);

display_set_gui_size(-1, -1);


