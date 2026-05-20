if owner == other.id exit;
if !active exit;
//if friendly exit;
	
with (other) {
	if (ds_list_find_index(other.hit_list, id) == -1) {
    // Not hit yet — deal damage
	apply_knockback(other, self, other.knockback)
	deal_damage(self, other.damage)
    ds_list_add(other.hit_list, id);
		attacker = other.owner
}
}
//Destroy after hit
if (destroy_on_hit){
	effect_create_layer("FX", on_hit_particle, x, y, .5, break_col)
	instance_destroy(self);
}
    
