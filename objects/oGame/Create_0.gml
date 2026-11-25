
enum GAMESTATE {
	PAUSED,
	PLAYING,
	DEAD,
	FADING,
	RESTARTING
} 

current_game_state = GAMESTATE.PLAYING;

// ------------- GLOBALS ------------- //
global.partSystMain = part_system_create_layer("FX", true);

global.player2_joined = false

global.font_secondary_bigger = fPixel_Big



hp_max = 100
hp = hp_max
equipped_ability = function(){}



/// Draw Player HUD
function draw_player_hud(_player, _x, _y, _flip = false)
{
    if (!instance_exists(_player)) return;

    var flip = _flip ? -1 : 1;

    // portrait
    draw_sprite_ext(
        sPlayerHealth_hud,
        1,
        _x,
        _y,
        flip, 1,
        0,
        c_white,
        1
    );

    // health bar
    draw_healthbar(
        _x + 90,
        _y + 3,
        _x + 170,
        _y + 53,
        _player.hp,
        #666666,
        #D32300,
        c_red,
        0,
        1,
        0
    );

    // frame
    draw_sprite_ext(
        sPlayerHealth_hud_1,
        1,
        _x + 84,
        _y,
        flip, 1,
        0,
        c_white,
        1
    );
}


