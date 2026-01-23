hit_list = ds_list_create();

contacted = []
hit = false;

sword_snd_played = false;
audio_play_sound(choose(snd_swing_attack_01, snd_swing_attack_02), .8, 0, 1, 0, random_range(.8, 1.7))