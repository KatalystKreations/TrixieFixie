can_interact = false
talking = false
interact = ord("E")

//Moving
	moveDir = 0;
	moveSpd[0] = 5;
	moveSpd[1] = 6.5;
	moveSpd[2] = 2.5;	//crawlspd
	moveSpd[3] = 7.5;	//slideboost spd
	moveSpd[4] = 7.5;	//dodge spd
	xspd = 0;
	yspd = 0;
	runType = 0;
	xmoving = false;
	acceleration = .2	//the lower the slower
	deceleration = .3 	//the lower the slower
	face = 1;

//Sprites
	spr_idle = _spr_idle;
	spr_run = _spr_run;
	spr_fall = _spr_fall;
	spr_jump = _spr_jump;
	current_sprite = sprite_index;

getCollisionVars()

/// @desc Checks if Player is close (10 pixals)  to the calling object.
/// @returns {bool} Description
function canInteract()
{
	return distance_to_object(oPlayer) < aBLOCK*3
}

function drawInteractMarker()
{
	draw_self()
	if (canInteract() && !exists(oDialogue, oCutscene) && dialogue != -1) {
		draw_sprite(sTalkBubble, 0, x, bbox_top - (sprite_get_height(sTalkBubble)/2 ) - hover(0.025, 3) - 5 )
	}
}