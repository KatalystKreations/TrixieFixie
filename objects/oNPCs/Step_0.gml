// Facing
	if (moveDir != 0) {face = sign(moveDir)}
// Talking check
	if instance_exists(oDialogue) talking = true; else talking = false;

getControls()
getCollisions()
getGPcontrols()

#region
if !instance_exists(oDialogue) {
// Getting close to npc
	if instance_exists(oPlayer) && canInteract() && dialogue != -1
	{
		//press interact to talk
		if (keyboard_check_pressed(interact) || bBtnPressed) 
		{
			var messages = create_dialogue(dialogue);
			// Loop through dialogue to see who the first speaker(not me) is.
			for (var i = 0; i < array_length(dialogue); ++i) {
				 // Check to find speaker
				if (dialogue[i].name != "Me") {
					global.talkingTo = dialogue[i].name
					break;
				}
			}
			// Loop again to find a change to variable
			for (var i = 0; i < array_length(dialogue); ++i) {
				// Check to remove dialogue
				if (variable_instance_exists(dialogue[i], "change_dialogue_to" ) ) {
					dialogue = dialogue[i].change_dialogue_to
					
				}
			}
		}
	}
}
#endregion


#region //Sprite Control
if spr_idle != noone {
		mask_index = spr_idle 
		image_xscale = face;
	if (!onGround) {
		if (yspd > 0){
			sprite_index = spr_fall
		}
		else if (yspd <= 0 ){
			sprite_index = spr_jump
		}
	}
	else if (onGround) {
		if (xspd != 0) { 
		    sprite_index = spr_run
		}
		else {
		    sprite_index = spr_idle;
		}
	}
	
	
	//start on first frame
	if (current_sprite != sprite_index) {
	current_sprite = sprite_index;
	image_index = 0
	}
}
#endregion


//Apply Movement
	x += xspd;
	xmoving = xspd != 0
	y += yspd;

image_xscale = face;
