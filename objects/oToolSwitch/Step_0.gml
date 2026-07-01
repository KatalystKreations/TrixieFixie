getControls()
getGPcontrols()
var _cur_val = animcurve_channel_evaluate(curve_channel, curve_head)

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
		depth = layer_get_depth(layer) - 1
		image_blend = $FFFFFFFF
		}
}
else { // Is Inactive
	curve_head = max(curve_head-curve_speed, 0);
	if curve_head < .5{
		depth = layer_get_depth(layer) + 1
		image_blend = $FFCCCCCC
		}
}
image_set_scale(map_value(_cur_val, 0, 1, 0.5, 1))
