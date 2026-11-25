wheel_open = false;
slot_count = 3;
inner_radius = 75;
outer_radius = 165;
deadzone = 35; // Minimum mouse distance (px) or stick tilt
selected_index = -1;

// Power definitions (replace sprites with your own)
powers = [
    { name: "Jump Pad",	   sprite: sRobot_Trolly_Idle_sml, 
		func: function(){
			spawn(oFloatingPlatform_sml,x,bbox_bottom-10)
			show_debug_message("PadJumped")
		} },
    { name: "Grapple Up", sprite: sFrame, func: function(){} },
    { name: "Zip Line",      sprite: sFrame, func: function(){} },
    { name: "Electric Arc", sprite: sFrame, func: function(){} },
    //{ name: "Mesmerize",   sprite: sFrame, func: function(){} },
    //{ name: "Shuriken",    sprite: sFrame, func: function(){} }
];

// Smooth animation arrays
slot_hover_anim = array_create(slot_count, 0);
wheel_open_anim = 0;

// Gamepad slot (0 is usually primary controller)
pad_id = 0;

// Helper function to draw a curved ring segment (wedge)
draw_ring_wedge = function(_cx, _cy, _r_in, _r_out, _start_ang, _end_ang, _steps, _col, _alpha) {
    draw_set_alpha(_alpha);
    draw_set_color(_col);
    draw_primitive_begin(pr_trianglestrip);
    
    var _step_ang = (_end_ang - _start_ang) / _steps;
    for (var i = 0; i <= _steps; i++) {
        var _a = _start_ang + (i * _step_ang);
        draw_vertex(_cx + lengthdir_x(_r_in, _a),  _cy + lengthdir_y(_r_in, _a));
        draw_vertex(_cx + lengthdir_x(_r_out, _a), _cy + lengthdir_y(_r_out, _a));
    }
    
    draw_primitive_end();
    draw_set_alpha(1.0);
	draw_set_color(c_white);
};
