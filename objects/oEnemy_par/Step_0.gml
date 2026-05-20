

// Activate AI
if (distance_to_object(oPlayer_par) < aBLOCK*10){
	enable()
}
// Deactivate AI
if (distance_to_object(oPlayer_par) > aBLOCK*25){
	disable()
}
if disabled exit;


//Hit Stuff
if (hit)
{
	hit = false;
	hit_flashTimer = hit_flashTime
}
if (hit_flashTimer)
{
	hit_flashTimer--
	hit_flash = true
}else 
{
	hit_flash = false;
}

// Died
if (hp <= 0){
	sprite(spr_death)
	if (spr_death = sFrame) {
		effect_create_layer("FX", ef_explosion, x, y, .5, -1)
		effect_create_layer("FX", ef_firework, x, y, .5, -1)
		instance_destroy()
	}
	else{
	if sprite_index_is(spr_death, image_number-1)
	instance_destroy()
	}
}

