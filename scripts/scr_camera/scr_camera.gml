
#region Camera Functions


///Retrieves the X of a camera.
///@param {real} number =  View camera to access.
function getCamX(number = 0)
{
    return camera_get_view_x(view_camera[number]);
}

///Retrieves the Y of a camera.
///@param {real} number =  View camera to access.
function getCamY(number = 0)
{
    return camera_get_view_y(view_camera[number]);
}


///Retrieves the Width of a camera.
///@param {real} number =  View camera to acces
function getCamW(number = 0)
{
    return camera_get_view_width(view_camera[number]);
}

///Retrieves the Height of a camera.
///@param {real} number =  View camera to access.
function getCamH(number = 0)
{
    return camera_get_view_height(view_camera[number]);
}

///Retrieves the the middle of the camera horizontaly
///@param {real} number View camera to access.
function getCamMidX(number = 0)
{
    var nameX = camera_get_view_x(view_camera[number]);
    var nameW = camera_get_view_width(view_camera[number]);
    return nameX+(nameW/2);
}

///Retrieves the the middle of the camera vertically 
///@param {real} number View camera to access.
function getCamMidY(number = 0)
{
    var nameY = camera_get_view_y(view_camera[number]);
    var nameH = camera_get_view_height(view_camera[number]);
    return nameY+(nameH/2);
}

#endregion



#region Camera Shake
	global.camShake = false;
	global.camShakeTimer = 0;
	global.camShakeTime = 6;
	global.camShakeMagnitude = 2;
	global.camShakemax = 4;
	global.camShakemin = 1;


/// @desc Create Camera Shake
/// @param {any*} _time Frames to stay active.
/// @param {any*} _magnitude How big to shake.
function camera_shake(_time = 6, _magnitude = 2){
	global.camShakeTime = _time;
	global.camShakeMagnitude = _magnitude;
	global.camShake = true; 
	global.camShakeTimer = global.camShakeTime;
}

/// @desc Place in persistant or current Object (only for intializing)
function initialize_camera_shake(number = 0){
//camera shake
	if (global.camShake) {
		global.camShakeMagnitude = clamp(global.camShakeMagnitude, global.camShakemin, global.camShakemax)	
		
	    var cam = view_camera[number];
	    var x_offset = random_range(-global.camShakeMagnitude, global.camShakeMagnitude);
	    var y_offset = random_range(-global.camShakeMagnitude, global.camShakeMagnitude);
	    camera_set_view_pos(cam, camera_get_view_x(cam) + x_offset, camera_get_view_y(cam) + y_offset);
	    global.camShakeTimer -= 1;
	    if (global.camShakeTimer <= 0) global.camShake = false;
	}
}

#endregion









