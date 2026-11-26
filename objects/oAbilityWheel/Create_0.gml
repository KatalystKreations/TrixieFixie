wheel_open = false;
slot_count = 3;
inner_radius = 75;
outer_radius = 165;
deadzone = 35; // Minimum mouse distance (px) or stick tilt
selected_index = -1;

// Power definitions (replace sprites with your own)
powers = [
    { name: "Jump Pad",	   sprite: sJumpPad_3d_temp, 
		func: function(){
			with (oJumpPad) {
				if (created_by_player) instance_destroy()
			}
			var jp = spawn(oJumpPad,x,bbox_bottom)
			jp.launch_angle = point_direction(x,y, x+xspd, y+yspd)
			jp.image_angle  = jp.launch_angle-90
			jp.created_by_player = true
			show_debug_message("PadJumped")
		} },
    { name: "Grapple Up", sprite: sFrame, func: function(){} },
    { name: "Zip Line",      sprite: sFrame, func: function(){
		 
		var _shoot_angle = (face == 1) ? zip_tilt : (180 - zip_tilt);
	    
	    var _hit = false;
	    var _check_x = x;
	    var _check_y = bbox_top;
	    
	    // Step along the ray in 4-pixel increments until hitting a wall or max range
	    for (var _d = 16; _d <= zip_max_dist; _d += 4) {
	        _check_x = x + lengthdir_x(_d, _shoot_angle);
	        _check_y = bbox_top + lengthdir_y(_d, _shoot_angle);
	        
	        if (place_meeting(_check_x, _check_y, collision)) {
	            _hit = true;
	            break;
	        }
	    }
	    
	    // If a wall was hit, lock in the endpoints and switch states
	    if (_hit) {
	        zip_start_x = x;
	        zip_start_y = bbox_top;
	        zip_end_x = _check_x;
	        zip_end_y = _check_y;
	        zip_angle = point_direction(zip_start_x, zip_start_y, zip_end_x, zip_end_y);
	        
	        xspd = 0;
	        yspd = 0;
	        state_to(stateZipline);
			dashTimer = 0
			dashCooldown = dashCooldownMax;
	    }
		
	} },
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
