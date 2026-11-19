

draw_hitFlash(function (){
	if (!can_float) {
	    draw_self()
	} else {
		var val = hover(0.08 + choose(0.001, -0.001, 0.00))
	    draw_sprite_ext(
			sprite_index, image_index, x, y+val, face, image_yscale, image_angle, image_blend, image_alpha
		)
	}
})

if !debug_mode exit
//Debug
if target_x >= x
draw_circle(xstart+patrol_range, y, 1, false);
if target_x <= x
draw_circle(xstart-patrol_range, y, 1, false);