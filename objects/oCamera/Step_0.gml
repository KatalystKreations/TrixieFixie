//fullscreen
if keyboard_check_pressed(vk_alt)||gamepad_button_check_pressed(0, gp_start)
{window_set_fullscreen(!window_get_fullscreen())}

//find player first
if !instance_exists(oCamFollow) exit;

//get cam size
var _camWidth = camera_get_view_width(view_camera[0]);
var _camHeight = camera_get_view_height(view_camera[0]);

//get camera target coords
var _camX = oCamFollow.x - _camWidth/2;
var _camY = oCamFollow.y - _camHeight/2;

//keep in room
_camX = clamp(_camX,0,room_width-_camWidth)
_camY = clamp(_camY,0,room_height-_camHeight)

//set cam coord var
finalCamX += (_camX - finalCamX) * camTrailSpd;
finalCamY += (_camY - finalCamY) * camTrailSpd;


//set cam coords
camera_set_view_pos(view_camera[0],finalCamX,finalCamY)





