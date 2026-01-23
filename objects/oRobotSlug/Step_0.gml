event_inherited();



//run state code
if gamestate_is(GAMESTATE.PLAYING)	state();

//var state_name = "";
//switch (state) {
    //case stateIdle:  	state_name = "idle"; break;
    //case statePatrol: 	state_name = "patrol"; break;
    //case stateAgro: 	state_name = "agro"; break;
    //case stateCooldown: state_name = "cooldown"; break;
//}
//show_debug_message(string(state_name))

//agro
if (distance_to_object(oPlayer) < 10 && (state == statePatrol || state == stateIdle) && state != stateAgro) {
	state = stateAgro
}


//died
if (hp <= 0){
	effect_create_above(ef_explosion, x, y, .5, -1)
	effect_create_above(ef_firework, x, y, .5, -1)
	instance_destroy()
}
//start on first frame
	if (current_sprite != sprite_index) {
	current_sprite = sprite_index;
	image_index = 0
	}