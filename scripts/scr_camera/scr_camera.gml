
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
function camera_shake_create(){
	camShake = {
	    active: false,
	    timer: 0,
	    duration: 0,
	    magnitude: 0,
	    curve: undefined,
	    smoothness: 1,
	    frequency: 1,
	    seed: 0,
		prev_xoff: 0,
		prev_yoff: 0
	};
}

/// Goes in oCamera Step Event
function camera_shake_step(cam=0)
{
    if (!camShake.active) return;

    var t = camShake.timer / camShake.duration;

    // Apply animation curve if provided
    if (camShake.curve != -1) {
        t = animcurve_channel_evaluate(animcurve_get_channel(camShake.curve, 0), 1 - t);
    }

    // Falloff (shake gets weaker over time)
	var falloff = camShake.timer / camShake.duration;

	if (camShake.curve != -1) {
	    falloff = t
	}

	var xoff = smooth_noise(camShake.seed, camShake.frequency)
	           * camShake.magnitude * falloff;

	var yoff = smooth_noise(camShake.seed + 1000, camShake.frequency)
	           * camShake.magnitude * falloff;


    // Apply to camera
	camera_set_view_pos(cam, finalCamX + xoff, finalCamY + yoff);

    // Countdown
    camShake.timer--;

    if (camShake.timer <= 0) {
        camShake.active = false;
    }
}

/// @desc Start a camera shake with full control.
/// @param duration     6  How long the shake lasts (frames)
/// @param magnitude    2  Max shake offset
/// @param smoothness   .5 How soft the shake moves (0 = jitter, 1 = smooth)
/// @param curve        -1 Animation curve asset (optional)
/// @param frequency    1  How fast the shake oscillates
function camera_shake(duration = 6, magnitude = 2, smoothness = 0.5, curve = -1, frequency = 1)
{
	with (oCamera) {
	    camShake.active    = true;
	    camShake.duration  = max(1, ceil(duration));
	    camShake.timer     = camShake.duration;
	    camShake.magnitude = magnitude;
	    camShake.smoothness = smoothness;
	    camShake.curve     = curve;
	    camShake.frequency = frequency;
	    camShake.seed      = irandom(999999); // unique shake pattern
	}
}


#endregion









