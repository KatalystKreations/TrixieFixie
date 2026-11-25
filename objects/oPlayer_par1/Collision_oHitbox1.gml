if invincible exit;
	
if (other.owner != id) {
	with (other) {
	if (ds_list_find_index(hit_list, other.id) == -1) {
    // Not hit yet — deal damage
	deal_damage(other, damage)
	if (instance_nearest(x, y, oHitbox).owner){
		var _owner :=  instance_nearest(x, y, oHitbox).owner
		other.attacker = _owner
		apply_knockback( 
			_owner, 
			other,
			oHitbox.knockback, 
			oHitbox.knockup
		)
	}
    ds_list_add(hit_list, other.id);
}
}
    //instance_destroy(other); // optional: destroy after hit
}
