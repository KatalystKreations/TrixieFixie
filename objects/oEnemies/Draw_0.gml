//get hit 
	var _col = c_green;
	if (hp <= hp_danger_zone) _col = c_red
	if (hit_flash){
		draw_one_glow(2, _col)
		shader_set(shd_Flash);
	}
shader_set_uniform_f(uni_add, sha_add, 0)
draw_self();
shader_reset();
sha_add = 1