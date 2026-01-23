if (!instance_exists(oPlayer)) exit;
	
if (ds_list_find_index(hit_list, other.id) == -1) {
    // Not hit yet — deal damage
    deal_damage(other, oPlayer.damage)
    ds_list_add(hit_list, other.id);
}
if (!sword_snd_played){
	sword_snd_played = true;
	audio_play_sound(choose(snd_sword_impact_01, snd_sword_impact_02), .8, 0, 1, 0, random_range(.8, 1.7))
	
}