// Get value
var _cur_val = animcurve_channel_evaluate(curve_channel, curve_head)

//Open and Add to value
if open{
	curve_head = min(curve_head+curve_speed, 1); 
	image_index = 1;
}
// Close and Remove from value
else{
	curve_head = max(curve_head-curve_speed, 0);
	call_later(100, time_source_units_frames, function(){
		image_index = 0;
		//create_dust();
		//camera_shake()
	}) 
}

// Move by 3 Blocks
y = ystart - (_cur_val*(aBLOCK*3));
