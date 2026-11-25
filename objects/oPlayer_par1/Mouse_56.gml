 
///Ice Ball
// Don't work during dialogue.
 if instance_exists(oDialogue) exit;
	
// Make variables to set based on if using a controller or not
var px, py, distance=16
// If using controller
if (global.gamepad_main != undefined) {
	px = x + lengthdir_x(distance, aim_angle_rs);
	if place_meeting(x+5, y, collision) px = x-5 + lengthdir_x(distance, aim_angle_rs);
	if place_meeting(x-5, y, collision) px = x+5 + lengthdir_x(distance, aim_angle_rs);
	py = y-(sprite_height/2) + lengthdir_y(distance, aim_angle_rs);

	}
// If using mouse
else {
	px = x
	if place_meeting(x+5, y, collision) px = x-5
	if place_meeting(x-5, y, collision) px = x+5
	py = y -(sprite_height/2)
	aim_angle_rs = point_direction(px, py, mouse_x, mouse_y)
	
}



// Set the cost for this projectile
var essence_cost = 1;

// If you have sufficient essence
if essence >= essence_cost{
	// Shoot Projectile
	var _spd = 15;
	var _dam = 0;
	var _pro = fire_projectile_dir(px, py, aim_angle_rs, character.projectile, _spd, _dam);
	
	// Consume essence
	essence -= essence_cost;
}