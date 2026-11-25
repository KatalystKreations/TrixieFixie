getControls()
getGPcontrols(0)

// Check keyboard (F) or Gamepad Left Bumper (gp_shoulderl)
var _open_pressed  = keyboard_check_pressed(ord("F"))  || gamepad_button_check_pressed(pad_id, gp_shoulderl);
var _open_released = keyboard_check_released(ord("F")) || gamepad_button_check_released(pad_id, gp_shoulderl);

if (_open_pressed && !wheel_open) {
    wheel_open = true;
    selected_index = -1;
    
    // Center the mouse cursor in the window so any movement picks a slice immediately
    window_mouse_set(window_get_width() * 0.5, window_get_height() * 0.5);
    
    // Slow down game speed to 25% (assuming default 60 FPS)
    game_set_speed(15, gamespeed_fps);
}

// Smoothly animate wheel scale in/out (using real-time delta so slow-mo doesn't sluggishly slow UI)
var _real_dt = delta_time / 1000000;
var _target_open = wheel_open ? 1.0 : 0.0;
wheel_open_anim = lerp(wheel_open_anim, _target_open, clamp(_real_dt * 18, 0, 1));

if (wheel_open) {
    var _cx = display_get_gui_width() * 0.5;
    var _cy = display_get_gui_height() * 0.5;
    
    // 1. Check Gamepad Right Stick first
    var _rx = gamepad_axis_value(pad_id, gp_axisrh);
    var _ry = gamepad_axis_value(pad_id, gp_axisrv);
    var _stick_mag = point_distance(0, 0, _rx, _ry);
    
    var _has_input = false;
    var _input_dir = 0;
    
    if (_stick_mag > 0.35) {
        _has_input = true;
        _input_dir = point_direction(0, 0, _rx, _ry);
    } else {
        // 2. Fallback to Mouse position relative to screen center
        var _mx = device_mouse_x_to_gui(0);
        var _my = device_mouse_y_to_gui(0);
        if (point_distance(_cx, _cy, _mx, _my) >= deadzone) {
            _has_input = true;
            _input_dir = point_direction(_cx, _cy, _mx, _my);
        }
    }
    
    // Calculate hovered slice
    if (!_has_input) {
        selected_index = -1;
    } else {
        var _slice = 360 / slot_count;
        // Shift angle so 90 degrees (top) is the center of Slot 0, going clockwise
        var _shifted = (90 - _input_dir + (_slice * 0.5) + 360) mod 360;
        selected_index = floor(_shifted / _slice);
    }
}

// Animate individual slice hover expansion
for (var i = 0; i < slot_count; i++) {
    var _target = (wheel_open && i == selected_index) ? 1.0 : 0.0;
    slot_hover_anim[i] = lerp(slot_hover_anim[i], _target, clamp(_real_dt * 20, 0, 1));
}

// Confirm selection on release
if (_open_released && wheel_open) {
    wheel_open = false;
    
    // Restore normal 60 FPS game speed
    game_set_speed(60, gamespeed_fps);
    
    if (selected_index != -1) {
        var _chosen = powers[selected_index];
        show_debug_message("Equipped: " + _chosen.name);
        // Set your player's active power variable here!
		with (oPlayer) equipped_ability = method(oPlayer, _chosen.func)
		with (oGame)   equipped_ability = method(oPlayer, _chosen.func)
		
    }
}
