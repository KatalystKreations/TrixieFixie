#macro aSecond 60 




/// @description Handles broadcast messages sent through event_data and runs a callback when matched. (goes in 'Broadcast Message 'event)
/// @param {string} _msg  The message string to listen for.
/// @param {function} _func  Function to execute when the message matches.
/// @returns {boolean} True if the message matched and the callback executed.
function broadcastReceive(_msg, _func = function(){}) {
	if (layer_instance_get_instance(event_data[? "element_id"]) != id) return false;
		
	if (event_data[? "message"] == _msg){
		_func()
		return true
	}
}


/** @desc Finds the nearest instance out of an array of instances.
 * 
*/
function instance_nearest_array(_x, _y, _inst = []){
	
	// Return noone if array is empty
	if array_first(_inst) == undefined return noone;
		
	var enemies = _inst
	var len = array_length(enemies);
	var _nearestInst = enemies[0];
	var _nearestVal = point_distance(_x, _y, _nearestInst.x, _nearestInst.y);
	
	for (var i = 1; i < len; i++) {
		var e = enemies[i];
		var _distance = point_distance(_x, _y, e.x, e.y);
		if (_distance < _nearestVal) {
			_nearestInst = e
			_nearestVal = _distance
		}
	}
	
	return _nearestInst;
}


function exists(_id){
	return instance_exists(_id)
}

function spawn(_inst, _x=x, _y=y, _depth=depth, _struct={}){
	return instance_create_depth(_x, _y, _depth, _inst, _struct)
}
function spawnLayer(_inst, _x=x, _y=y, _layer=layer, _struct={}){
	return instance_create_layer(_x, _y, _layer, _inst, _struct)
}

///** @desc Spawn a counter with variables.
/// * @param {real} _number The Number
/// * @param {string} _string The String
/// * @param {color} _fontCol The Font Color
/// * @param {asset.GMFont} _font The Font
//*/
//function counter(_number = 0, _string = "", _fontCol=c_white, _font = -1){
	//var _i = instance_create_layer(x, y, "FX", oCounter, {
		//num: _number,
		//str: _string,
		//font: _font,
		//fontCol: _fontCol
	//})
	//return _i
//}

/// @desc Initializes shake variables for an object.
function objectShake_create()
{
    shake_active     = false;
    shake_timer      = 0;
    shake_duration   = 0;
    shake_magnitude  = 0;
    shake_seed       = 0;

    shake_offset_x   = 0;
    shake_offset_y   = 0;

    shake_freq       = 0.12;   // how fast the shake moves
    shake_smoothness = 0.5;    // 0 = jitter, 1 = smooth
}

/// @desc Updates shake offsets each frame.
function objectShake_step()
{
    if (!shake_active) {
        shake_offset_x = 0;
        shake_offset_y = 0;
        return;
    }

    var t = shake_timer / shake_duration;   // falloff
    var falloff = t;

    // Smooth noise function
    var nx = smooth_noise(shake_seed, shake_freq);
    var ny = smooth_noise(shake_seed + 1000, shake_freq);

    // Apply magnitude + falloff
    shake_offset_x = nx * shake_magnitude * falloff;
    shake_offset_y = ny * shake_magnitude * falloff;

    shake_timer--;

    if (shake_timer <= 0) {
        shake_active = false;
        shake_offset_x = 0;
        shake_offset_y = 0;
    }
	return {
		_sx: shake_offset_x,
		_sy: shake_offset_y
	}
}


/// @desc Starts a shake effect on the object.
/// @param duration  How long the shake lasts (frames)
/// @param magnitude How strong the shake is
function objectShake(duration = 6, magnitude = 2)
{
    shake_active    = true;
    shake_duration  = duration;
    shake_timer     = duration;
    shake_magnitude = magnitude;
    shake_seed      = irandom(999999);
}





/// @desc  Maps a value to another range using a ratio. Returns value of second range based on the value in the first range.
/// @param {any*} val input_value
/// @param {any*} in_min range1 min
/// @param {any*} in_max range1 max
/// @param {any*} out_min range2 min
/// @param {any*} out_max range2 max
function map_value(val, in_min, in_max, out_min, out_max) {
    return out_min + ((val - in_min) / (in_max - in_min)) * (out_max - out_min);
}

/**
 * 
 * @desc Generates smooth, continuous pseudo‑noise using blended sine waves.
 *       Useful for camera shake, procedural animation, idle motion, and any effect requiring organic, non‑jittery randomness.
 * 
 * ---
 *  Example 1: 
 * Apply smooth idle bobbing to an object
 *  y += smooth_noise(id, 0.01) * 2;
 *
 * ---
 *  Example 2: 
 * Use smooth noise for camera shake 
 *  var xoff = smooth_noise(camShake.seed, camShake.frequency) * camShake.magnitude;
 *  var yoff = smooth_noise(camShake.seed + 1000, camShake.frequency) * camShake.magnitude;
 *
 * @param {real} seed A unique value used to offset the noise pattern. Different seeds produce different noise curves.
 * @param {real} freq Frequency multiplier controlling how fast the noise changes over time. Higher values = faster oscillation.
 * @returns {real} A smooth value typically between -1 and 1.
 */
function smooth_noise(seed, freq) {
    var t = (current_time + seed) * freq;
    return sin(t) * 0.6 + sin(t * 0.5) * 0.3 + sin(t * 0.25) * 0.1;
}


/// is_even(num)
function is_even(num) {
    return num mod 2 == 0;
}



function room_is(_room){
	if (room == _room) return true;
		return false;
}


/**
 *  Places everything back at it's spawnpoint.
 */
function restart(){
    with all
	{
    x = xstart;
    y = ystart;
    }
    
    with oPlayer
	{
    x = global.spawn_x;
    y = global.spawn_y;
	hp = hp_max
    }
	if instance_exists(oPlayer_2){
	 	with oPlayer_2
		{
		    x = global.spawn_x-32;
		    y = global.spawn_y;
			hp = hp_max
	    }
	}
	if instance_exists(oStormWall){
	 	with oStormWall
		{
		    x = global.storm_x -32;
		    y = global.storm_y;
			speed = global.storm_spd;
			target_speed = global.storm_tspd
	    }
	}
	with (oToolSwitch) {
		
	}
	set_gamestate(GAMESTATE.PLAYING)
    
}