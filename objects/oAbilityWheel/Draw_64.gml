if (wheel_open_anim <= 0.01) exit;

var _cx = display_get_gui_width() * 0.5;
var _cy = display_get_gui_height() * 0.5;
var _slice = 360 / slot_count;
var _gap = 3; // Degrees of empty space between wedges

for (var i = 0; i < slot_count; i++) {
    var _anim = slot_hover_anim[i];
    var _center_ang = 90 - (i * _slice);
    
    // Expand outward slightly when hovered
    var _r_in  = (inner_radius + (_anim * 6)) * wheel_open_anim;
    var _r_out = (outer_radius + (_anim * 14)) * wheel_open_anim;
    
    var _start_ang = _center_ang - (_slice * 0.5) + (_gap * 0.5);
    var _end_ang   = _center_ang + (_slice * 0.5) - (_gap * 0.5);
    
    var _bg_col = merge_color(c_black, make_color_rgb(35, 190, 220), _anim);
    var _bg_alpha = lerp(0.72, 0.92, _anim) * wheel_open_anim;
    
    draw_ring_wedge(_cx, _cy, _r_in, _r_out, _start_ang, _end_ang, 16, _bg_col, _bg_alpha);
    
    // Draw Power Icon in the middle of the wedge
    var _mid_r = (_r_in + _r_out) * 0.5;
    var _ix = _cx + lengthdir_x(_mid_r, _center_ang);
    var _iy = _cy + lengthdir_y(_mid_r, _center_ang);
    var _icon_scale = (1.0 + (_anim * 0.25)) * wheel_open_anim;
    
    if (i < array_length(powers) && sprite_exists(powers[i].sprite)) {
        draw_sprite_ext(
            powers[i].sprite, 0,
            _ix, _iy,
            _icon_scale, _icon_scale,
            0, c_white, wheel_open_anim
        );
    }
}

// Draw selected power name in the center of the ring
if (selected_index != -1 && wheel_open) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(_cx, _cy, powers[selected_index].name);
	    draw_set_halign(fa_left);
	    draw_set_valign(fa_top);
	    draw_set_color(c_white);
}
