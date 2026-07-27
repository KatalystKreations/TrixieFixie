getControls()
getGPcontrols()
var _cur_val = animcurve_channel_evaluate(curve_channel, curve_head)


path_shift(pthToolSwap, getCamX(), getCamY())



// Switch
if (runKeyPressed || yBtnPressed) { 
	if (activeTool) {
		path_start(pthToolSwap, spd, path_action_stop, 1)
		
	}else {
		var newPath = undefined;
		if not path_exists(newPath) newPath = path_duplicate(pthToolSwap);
			
		path_mirror(newPath);
		path_flip(newPath);
		path_start(newPath, spd, path_action_stop, 1);
	}
	activeTool = !activeTool;
}

// Ease
if (activeTool) { // Is Active
	curve_head = min(curve_head+curve_speed, 1);
	if curve_head > .5{
		depth = -1
		image_blend = $FFFFFFFF
	}
	x = path_get_point_x(pthToolSwap, 0)
	y = path_get_point_y(pthToolSwap, 0)
}
else { // Is Inactive
	curve_head = max(curve_head-curve_speed, 0);
	if curve_head < .5{
		depth = 1
		image_blend = $FFCCCCCC
	}
	x = path_get_point_x(pthToolSwap, 2)
	y = path_get_point_y(pthToolSwap, 2)
}
image_set_scale(map_value(_cur_val, 0, 1, 0.5, 1))


path_shift(pthToolSwap, -getCamX(), -getCamY())
