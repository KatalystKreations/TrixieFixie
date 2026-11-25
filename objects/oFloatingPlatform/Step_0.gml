// 1. Check if the player is landing on top of the platform
var _player_on_top = instance_place(x, y - 1, oPlayer_par);

if (_player_on_top != noone) {
    // Player is standing on it, sink down
    target_y = ystart_pos + sink_distance;
    
    // Smoothly interpolate to the sink position
    var _old_y = y;
    y = lerp(y, target_y, sink_speed);
    
    // Move the player down by the same amount so they don't fall through
    var _y_difference = y - _old_y;
    _player_on_top.y += _y_difference;
} else {
    // Player is gone, return to original position
    target_y = ystart_pos;
    y = lerp(y, target_y, return_speed);
}


// Move side to side
if (canMove) {
	if (distance_to_point(target_x, y) < moveSpd) {
		if !is_resting && alarm[0] <= 0 {
			is_resting = true;
			alarm[0] = restTime;
		}
		
		if (face == RIGHT) {
			target_x = xstart - moveDist;
			face = LEFT
		}
		else {
			target_x = xstart + moveDist
			face = RIGHT;
		}
	}
	
	
	if !is_resting {
		xspd = face * moveSpd;
		if (_player_on_top != noone) {
			_player_on_top.x += xspd
		}
		//Apply
		x += xspd;
		image_xscale = face;
		sprite(sRobot_Trolly_Walk)
	}
	else
	sprite(sRobot_Trolly_Idle)
}
else {
	sprite(sRobot_Trolly_Idle)
}