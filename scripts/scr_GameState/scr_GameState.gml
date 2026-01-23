
/// Function that returns the current gamestate as a string
function get_gamestate()
{
	switch(oGame.current_game_state)
	{
		case GAMESTATE.PAUSED:
			return "Paused"; 
		case GAMESTATE.PLAYING:
			return "Playing";
		case GAMESTATE.DEAD:
			return "Dead";
		case GAMESTATE.FADING:
			return "Fading";
			
		default: return "Unset"
	}
	
}

/// @desc Set the Gamestate.
/// @param {any*} _state The state of the game to change to.
function set_gamestate(_state)
{
	if (_state != undefined) {
		oGame.current_game_state = _state;
	}
}

/// @desc Check if the game state is _state.
/// @param {any*} _state The state to check for.
function gamestate_is(_state)
{
	return oGame.current_game_state == _state;
}


function toggle_pause(){
		 if (gamestate_is(GAMESTATE.PLAYING)) set_gamestate(GAMESTATE.PAUSED);
	else if (gamestate_is(GAMESTATE.PAUSED) ) set_gamestate(GAMESTATE.PLAYING);
		
	return get_gamestate();
}