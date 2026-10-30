if (!instance_exists(other.owner)) exit;
// See if hitbox's owner is your own or a friend's or targeted towards you
if (other.owner != id /*
	&& !object_is_ancestor(other.owner.object_index, oPlayer_par) */
	&& (other.target == object_index 
		|| other.target == id
		|| other.target == object_get_parent(object_index)
		|| other.target == all)
) 
{
	// With Hitbox
	with (other) {
	// If not found on hit_list (if not hit yet)
	if (ds_list_find_index(hit_list, other.id) == -1) {
    // Deal damage to self (enemy)
	deal_damage(other, damage, false)
	objectShake(10, 10);
	did_hit = true;
		
		//// If the hitbox belongs to the Player
		//if (owner == oPlayer_par) {
			//with (oPlayer_par) {
				//if (!grounded && _h.did_hit) {
					//yspd = jspd*2;
				//}
			//}
			//// Affect Player with recoil
		//if _owner_id == oPlayer_par
		//apply_knockback(other, _owner_id, _owner_id.jspd, true)
		//}
		
	// Check if the owner of the hitbox still exists
	if (instance_nearest(x, y, oHitbox).owner){
		// Get the id of the owner
		var _owner_id :=  instance_nearest(x, y, oHitbox).owner
		// Set enemy's attacker to owner of hitbox
		other.attacker = _owner_id
		
		// Apply configured knockback to self(enemy) from hitbox
		apply_knockback( 
			_owner_id, 
			other,
			oHitbox.knockback, 
			oHitbox.knockup
		)
	}
	// Add to already hit list
    ds_list_add(hit_list, other.id);
	}
}
    //instance_destroy(other); // optional: destroy after hit
}