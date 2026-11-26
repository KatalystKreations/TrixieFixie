

/// @desc Fades the screen to black and optionally takes you to a room.
/// @param {any*} _room_to_goto Room to goto to. (optional)
/// @param {Real} _fadeinSpd 0.025 Speed to fade in. (optional)
/// @param {Real} _fadeoutSpd 0.05 Speed to fade out. (optional)
function spawn_fade(_room_to_goto = undefined, _fadeinSpd = 0.025, _fadeoutSpd = 0.05, white=false){
	if instance_exists(oFade) exit;
	if (instance_exists(oPlayer)){
		
	}
	var _inst = instance_create_depth(0, 0, -9999, oFade)
	_inst.room_to_goto = _room_to_goto;
	_inst.fadeinSpd = _fadeinSpd;
	_inst.fadeoutSpd = _fadeoutSpd;
	if white
	_inst.image_index = 1;
	return _inst;
}


/// @desc  Fades an object
/// @param {real} [fadeTo]=(0) What to fade to.
/// @param {real} [fadeSpd]=(0.025) How fast is fades.
/// @returns {bool} Description
function fade(fadeTo = 0, fadeSpd = 0.025){
	if image_alpha > fadeTo
	{
		image_alpha -= fadeSpd;
	}else return true;
}

/// @desc  Fades an object and destroys it when done.
/// @param {real} [fadeSpd]=0.05 | How fast is fades.
function fadetoDeath(fadeSpd = 0.05){
		image_alpha -= fadeSpd;
	if image_alpha <= 0 instance_destroy()
	if image_alpha == fadeSpd return true else return false 
}

/// @desc  Fades an object in.
/// @param {real} [fadeInTo]=1 | What to fade in to.
/// @param {real} [fadeSpd]=0.025 | How fast is fades in.
/// @returns {bool} Description
function fadein(fadeInTo = 1, fadeSpd = 0.025){
	if image_alpha < fadeInTo
	{
		image_alpha += fadeSpd;
	}else return true;
}

/**
 * Makes objects hover in place. (spd mulitplies by amplitude)
* @desc Smooth per-instance hover motion.
* @param spd        0.05 How fast it moves up/down.
* @param amplitude  1 How far it moves.
*/
function hover(spd = 0.05, amplitude = 1)
{
    if (!variable_instance_exists(id, "__hover_timer"))
        __hover_timer = irandom(10000); // random start offset so objects don't sync

    __hover_timer += spd;

    return sin(__hover_timer) * amplitude;
}
