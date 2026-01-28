gamepads = []
gamepad_main = undefined;
gamepad_second = undefined;


function getControls( _rightkey = ord("D"), _leftKey = ord("A"), _downkey = ord("S"), _upKey = ord("W"), _runKey = vk_lshift, _player_id = 0 ) {
	// Ords
	right = _rightkey;
	left  = _leftKey;
	down  = _downkey;
	up    = _upKey;
	run	  = _runKey;
	
	//Hold Down Keys
	rightKey 	= keyboard_check( _rightkey );
	leftKey 	= keyboard_check( _leftKey );
	downKey 	= keyboard_check( _downkey );
	upKey 		= keyboard_check( _upKey );
	
	runKey 		= keyboard_check( _runKey );
	spaceKey 	= keyboard_check( vk_space );
	//Single Press Keys
	rightKeyPressed = keyboard_check_pressed( _rightkey );
	leftKeyPressed 	= keyboard_check_pressed( _leftKey );
	downKeyPressed 	= keyboard_check_pressed( _downkey );
	upKeyPressed 	= keyboard_check_pressed( _upKey );
	
	jumpKeyPressed 		= keyboard_check_pressed( _upKey );
	enterKeyPressed		= keyboard_check_pressed( vk_enter );
	startKeyPressed		= keyboard_check_pressed( vk_escape );
	
	//GAMEPAD CONTROLS
	var _gp = undefined;
	if (array_length(global.gamepads) > _player_id)
		_gp = global.gamepads[_player_id];
	
	if (_gp != undefined) 
	{
		var _deadzone = 0.2;
		//Horizontal Left Stick
		var _gp_l_ax_x_val = gamepad_axis_value(_gp, gp_axislh);
		if (_gp_l_ax_x_val > _deadzone) { rightKey += _gp_l_ax_x_val; } 
		if (_gp_l_ax_x_val < _deadzone) { leftKey  += _gp_l_ax_x_val; }
		
		//Vertical Left Stick
		var _gp_l_ax_y_val = gamepad_axis_value(_gp, gp_axislv);
		if ( gamepad_button_check(_gp, gp_face2) 
		||  _gp_l_ax_y_val >  _deadzone) downKey = 1;
		if (_gp_l_ax_y_val < -_deadzone) upKey 	 = 1;
		
		// D-pad Press
		rightKey 	+= gamepad_button_check(_gp, gp_padr);
		leftKey 	+= gamepad_button_check(_gp, gp_padl);
		upKey 		+= gamepad_button_check(_gp, gp_padu);
		downKey 	+= gamepad_button_check(_gp, gp_padd);
		// D-pad Single Press
		rightKeyPressed += gamepad_button_check_pressed(_gp, gp_padr);
		leftKeyPressed 	+= gamepad_button_check_pressed(_gp, gp_padl);
		upKeyPressed 	+= gamepad_button_check_pressed(_gp, gp_padu);
		downKeyPressed 	+= gamepad_button_check_pressed(_gp, gp_padd);
		
		enterKeyPressed += gamepad_button_check_pressed(_gp, gp_start);
		startKeyPressed += gamepad_button_check_pressed(_gp, gp_start);
		
		
		//Gamepad Alternative Buttons
		upKey 			+= gamepad_button_check(_gp, gp_shoulderlb)
		runKey 			+= gamepad_button_check(_gp, gp_stickl)
		jumpKeyPressed 	+= gamepad_button_check_pressed(_gp, gp_shoulderlb) + gamepad_button_check_pressed(_gp, gp_face1)
	}
	//Clamp Values to one Input at a time.
	runKey 		= clamp(runKey, 	0, 1);
	rightKey 	= clamp(rightKey, 	0, 1);
	leftKey 	= clamp(leftKey, 	0, 1);
	upKey 		= clamp(upKey, 		0, 1);
	downKey 	= clamp(downKey, 	0, 1);
	
	rightKeyPressed = clamp(rightKeyPressed,	0, 1);
	leftKeyPressed 	= clamp(leftKeyPressed, 	0, 1);
	upKeyPressed 	= clamp(upKeyPressed, 		0, 1);
	downKeyPressed 	= clamp(downKeyPressed, 	0, 1);
	enterKeyPressed	= clamp(enterKeyPressed, 	0, 1);
	startKeyPressed	= clamp(startKeyPressed, 	0, 1);

}
function getGPcontrols(_gp = 0){
	//Controller btns
	aBtn = gamepad_button_check(_gp, gp_face1)
	bBtn = gamepad_button_check(_gp, gp_face2)
	xBtn = gamepad_button_check(_gp, gp_face3)
	yBtn = gamepad_button_check(_gp, gp_face4)
	//Controller btns preessed
	aBtnPressed = gamepad_button_check_pressed(_gp, gp_face1)
	bBtnPressed = gamepad_button_check_pressed(_gp, gp_face2)
	xBtnPressed = gamepad_button_check_pressed(_gp, gp_face3)
	yBtnPressed = gamepad_button_check_pressed(_gp, gp_face4)
	//Controller shoulders value
	rtBtn_val = gamepad_button_value(_gp, gp_shoulderrb) 
	ltBtn_val = gamepad_button_value(_gp, gp_shoulderlb) 
	//Controller shoulders
	rtBtn = gamepad_button_check(_gp, gp_shoulderrb) 
	rbBtn = gamepad_button_check(_gp, gp_shoulderr) 
	ltBtn = gamepad_button_check(_gp, gp_shoulderlb) 
	lbBtn = gamepad_button_check(_gp, gp_shoulderl) 
	
	rtBtn_pressed = gamepad_button_check_pressed(_gp, gp_shoulderrb) 
	rbBtn_pressed = gamepad_button_check_pressed(_gp, gp_shoulderr) 
	ltBtn_pressed = gamepad_button_check_pressed(_gp, gp_shoulderlb) 
	lbBtn_pressed = gamepad_button_check_pressed(_gp, gp_shoulderl) 
	//Controller Axis
	static _aim_angle_rs 	= 0;
	static _aim_angle_ls 	= 0;
			aim_angle_rs 	= _aim_angle_rs;
			aim_angle_ls 	= _aim_angle_ls;
	
	var aim_x_rs = gamepad_axis_value(_gp, gp_axisrh); // Right stick horizontal
	var aim_y_rs = gamepad_axis_value(_gp, gp_axisrv); // Right stick vertical
	
	var aim_x_ls = gamepad_axis_value(_gp, gp_axislh); // Left stick horizontal
	var aim_y_ls = gamepad_axis_value(_gp, gp_axislv); // Left stick vertical
	//aim rs
	if (abs(aim_x_rs) > 0.2 || abs(aim_y_rs) > 0.2) {
	    _aim_angle_rs = point_direction(0, 0, aim_x_rs, aim_y_rs);
	}/*else aim_angle_rs = 0;*/
	//aim ls
	if (abs(aim_x_ls) > 0.2 || abs(aim_y_ls) > 0.2) {
	    _aim_angle_ls = point_direction(0, 0, aim_x_ls, aim_y_ls);
	}/*else gle_lsgle_ls = 0;*/

}

function getPowerControls( _player_id = 0, power_1 = ord("F"), power_2 = ord("G"), power_3 = ord("H") ) {
	powerkey1 		 = keyboard_check( power_1 );
	powerkey2 		 = keyboard_check( power_2 );
	powerkey3 		 = keyboard_check( power_3 );
	powerkey1pressed = keyboard_check_pressed( power_1 );
	powerkey2pressed = keyboard_check_pressed( power_2 );
	powerkey3pressed = keyboard_check_pressed( power_3 );
	var _gp = undefined;
	if (array_length(global.gamepads) > _player_id)
		_gp = global.gamepads[_player_id];
	if (_gp != undefined) 
	{
	powerkey1 		 += gamepad_button_check(_player_id, gp_face3);
	powerkey2 		 += gamepad_button_check(_player_id, gp_face4);
	powerkey3 		 += gamepad_button_check(_player_id, gp_face2);
	powerkey1pressed += gamepad_button_check_pressed(_player_id, gp_face3);
	powerkey2pressed += gamepad_button_check_pressed(_player_id, gp_face4);
	powerkey3pressed += gamepad_button_check_pressed(_player_id, gp_face2);
		
	powerkey1 		 = clamp(powerkey1, 0, 1)
	powerkey2 		 = clamp(powerkey2, 0, 1)
	powerkey3 		 = clamp(powerkey3, 0, 1)
	powerkey1pressed = clamp(powerkey1pressed, 0, 1)
	powerkey2pressed = clamp(powerkey2pressed, 0, 1)
	powerkey3pressed = clamp(powerkey3pressed, 0, 1)
	}
}

/**
 * Checks if a key has been pressed twice.
 * @param {any} _key The key to check for.
 * @param {any} _max_time The allowed time before resetting.
 * @returns {bool} 
 */
function key_double_tap(_key, _max_time=10) {
	//Save last tap in a struct
    static last_tap = {};
	
    // Create entry if missing
    if (!variable_struct_exists(last_tap, string(_key))) {
        last_tap[$ string(_key)] = -9999;
    }
	
    var now = current_time div 16; // convert ms → frames
    var last = last_tap[$ string(_key)];
	
    // Check for double tap
    if (keyboard_check_pressed(_key)) {
        last_tap[$ string(_key)] = now;
		
        if (now - last <= _max_time) {
            return true;
        }
    }
	
    return false;
}

/**
 * Checks if a keyboardcheck is true twice.
 * @param {any} _key The key to check for.
 * @param {any} _max_time The allowed time before resetting.
 * @returns {bool} 
 */
function input_double_tap(_key, _max_time=10) {
	//Save last tap in a struct
    static last_tap = {};
	
    // Create entry if missing
    if (!variable_struct_exists(last_tap, string(_key))) {
        last_tap[$ string(_key)] = -9999;
    }
	
    var now = current_time div 16; // convert ms → frames
    var last = last_tap[$ string(_key)];
	
    // Check for double tap
    if (keyboard_check_pressed(_key)) {
        last_tap[$ string(_key)] = now;
		
        if (now - last <= _max_time) {
            return true;
        }
    }
	
    return false;
}