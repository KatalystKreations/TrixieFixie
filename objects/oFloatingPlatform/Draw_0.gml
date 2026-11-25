var _player_on_top = instance_place(x, y - 1, oPlayer_par);


if (_player_on_top != noone) {
    draw_self()
} else {
	var val = hover(0.05 + choose(0.001, -0.001, 0.00))
    draw_sprite_ext(
		sprite_index, image_index, x, y+val, face, image_yscale, image_angle, image_blend, image_alpha
	)
    
}

if !debug_mode exit
//Debug
draw_circle(xstart+moveDist, y, 1, false);
draw_circle(xstart-moveDist, y, 1, false);