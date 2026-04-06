//Moving
	moveDir 	= 0;
	xspd 		= 0;
	yspd 		= 0;
	face 		= 1;
	moveSpd[0] 	= 5;
	moveSpd[1] 	= 7;
	runType 	= 0;
	acceleration= 0.3;
	deceleration= 0.3;


//Jumping
	onGround 	= place_meeting( x, y + 1, oWall );
	regGrav 	= 0.35;
	jumpGrav 	= 0.45;
	forceGrav	= 0.9;
	grav 		= regGrav;
	maxGravSpd 	= 10;
	dustLand 	= true;
	jumped 		= false;
	//Jump Time
		jumpTimer = 0;
		jumpTime  = 10;
	//coyote time
		coyoteTimer = 0;
		coyoteTime  = 10;
	//jump buffering
		jumpBufferTimer = 0;
		jumpBufferTime  = 5;
	//successive jumps
	maxJumps 	= 2
	jumps 		= maxJumps;
	jumpCount 	= 0;
	//Jump 1
	jumpHoldFrames[0] 	= 10;
	jumpspd[0] 			= -5;
	//Jump 2
	jumpHoldFrames[1] 	= 7;
	jumpspd[1] 			= -3.5;
	

// Combat
	hp_max = 100;
	hp = hp_max;
	hit = false;
	attacker = noone;



col_tiles = layer_tilemap_get_id("MainTiles");
collision = [oWall, col_tiles];

/// @desc Create a dust object.
/// @param {asset.gmobject} [_dust]= Dust Object
/// @param {real} [_x]= x 
/// @param {real} [_y]= y 
/// @returns {id} Description
function create_dust(_dust = oDustLand, _x = x, _y = y) {
	var landDust = instance_create_layer(_x, _y, "FX", _dust);
	return landDust;
}



//Initialize Inputs
getControls()


#region Sprites
start_image_xscale = image_xscale;
start_image_yscale = image_yscale;

#endregion