spawn_interval = 0;

function spawnPlane() {
	var _top = getCamY() + 50
	var _cam_left = getCamX();
	var _cam_width = getCamW();
	var _half_plane_width = sprite_get_width(sRobot_Plane) * 0.5;
	var _from_left = choose(true, false);

	for (var _attempt = 0; _attempt < 2; _attempt++) {
		var _spawn_from_left = (_attempt == 0) ? _from_left : !_from_left;
		var _spawn_x = _spawn_from_left
			? _cam_left - _half_plane_width
			: _cam_left + _cam_width + _half_plane_width;
		var _plane = instance_create_layer(_spawn_x, _top, layer, oRobotPlane);

		_plane.image_xscale = _spawn_from_left ? 1 : -1;

		var _blocked = false;
		with (_plane) {
			_blocked = place_meeting(x, y, collision)
				|| place_meeting(x, y, oRobotPlane);
		}

		if (!_blocked) {
			return _plane;
		}

		with (_plane) {
			instance_destroy();
		}
	}

	return noone;
}
