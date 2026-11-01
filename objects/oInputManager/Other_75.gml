var _gamepad = async_load[? "pad_index"];

switch (async_load[? "event_type"]) {
	case "gamepad discovered":
		array_push(global.gamepads, _gamepad);
		gamepad_set_axis_deadzone(_gamepad, 0.2);
	break;
	case "gamepad lost":
		var _array_index = array_get_index(global.gamepads, _gamepad);
		if (_array_index >= 0)
		{
			array_delete(global.gamepads, _array_index, 1)
		}
	break;
}
if (array_length(global.gamepads) > 0)
{
	global.gamepad_main = global.gamepads[0]
}
else {
	global.gamepad_main = undefined;
}

	//---HOW TO USE---//
/*
var _gp = global.gamepad_main;
if (_gp != undefined) 
{
	move = gamepad_button_value(_gp, gp_shoulderrb);
	hor = gamepad_axis_value(_gp, gp_axisrh);
	fire = gamepad_button_check_pressed(_gp, gp_face1) || gamepad_button_check_pressed(_gp, gp_shoulderlb);
}
*/