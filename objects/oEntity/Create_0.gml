 
// Movement
	xspd = 0;
	yspd = 0;
	face = 1;
	moveDir = 1;
	moveSpd = 1;
	start_spd = moveSpd;
	
	grav = .35
	maxGravSpd = 10;

// Collisions
	fake_layer = layer_tilemap_get_id("Tiles_Fake");
	col_layer = layer_tilemap_get_id("Tiles_Ground");
	collision = [oWall, col_layer, oIceBlock];
	onGround = place_meeting( x, y+1, collision);
	ground = instance_place(x, y+1, collision[0]);

// Combat
	hp_max = 1;
	hp = hp_max;



// Cutscene State
stateCutscene = function(){
	if (!instance_exists(oCutscene) && !instance_exists(oDialogue)) { state = stateIdle; }

}
// Idle State
stateIdle = function()
{ }

// Dead State
stateDead = function()
{ }

stateFrozen = function()
{
	freeze()
	image_speed = 0;
	image_blend = c_freezeBlue;
	alarm_set(2, -1)
	
	can_hold = true;
}

state = stateIdle;
prev_state = state;