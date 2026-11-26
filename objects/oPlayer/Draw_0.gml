
//get hit 
	var _col = c_white;
	if (hp <= hp_danger_zone) _col = c_red
	if (hit_flash){
		draw_one_glow(0.5, _col)
		shader_set(shd_Flash);
	}
// Allow shader to affect
shader_set_uniform_f(uni_add, sha_add, 0)


if (state_is(stateZipline)) {
    draw_set_color(c_ltgray);
    draw_line_width(x, bbox_top - 8, zip_end_x, zip_end_y, 2); // -8 offsets to hands/chest
    draw_set_color(c_white);
}

//Draw self ext
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



