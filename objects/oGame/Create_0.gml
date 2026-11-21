
enum GAMESTATE {
	PAUSED,
	PLAYING,
	DEAD,
	FADING,
} 

current_game_state = GAMESTATE.PLAYING;

// ------------- GLOBALS ------------- //
global.partSystMain = part_system_create_layer("FX", true);

global.player2_joined = false



hp_max = 100
hp = hp_max


