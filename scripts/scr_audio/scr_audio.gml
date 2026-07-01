
/// @desc This function play an Sound Asset in your game like Minecraft. 
/// @param {asset.gmsound} _index The index of the sound to play.
/// @param {bool} [_loop]=false Weather Loop the sound or not.
/// @param {real} [_gain]=1 The volume for the sound.
/// @param {real} [_low_pitch]=0.9 The lower pitch range for the sound to play at.
/// @param {real} [_high_pitch]=1.2 The higher pitch range for the sound to play at.
/// @param {real} [_priority]=1 Set the channel priority for the sound
/// @param {real} [_offset]=0 The time (in seconds) to start playing.
function playsound(_index, _loop=false, _gain=1, _low_pitch=0.9, _high_pitch=1.2, _priority=1, _offset=0){
	return audio_play_sound(_index, _priority, _loop, _gain, _offset, random_range(_low_pitch, _high_pitch))
}


