
//get hit 
	var _col = c_white;
	if (hp <= hp_danger_zone) _col = c_red
	if (hit_flash){
		draw_one_glow(0.5, _col)
		shader_set(shd_Flash);
	}


shader_set_uniform_f(uni_add, sha_add, 0)

//draw_self();
draw_sprite_ext(
		sprite_index, 
		image_index, 
		x, 
		y, 
		image_xscale, 
		image_yscale - curve_value, 
		image_angle, 
		image_blend, 
		image_alpha
	)

shader_reset();
sha_add = 1

//debug_draw_hitbox_frame()

//draw_line(x, y-15, x, y-sprite_get_height(spr_idle))
//show_debug_message(head_clear ? "Clear": "Conjested")



