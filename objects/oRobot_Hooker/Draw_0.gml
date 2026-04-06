// Draw self with face
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale*face, image_yscale, image_angle, image_blend, image_alpha);

//Debug
draw_circle(xstart+patrol_range, y, 1, false);
draw_circle(xstart-patrol_range, y, 1, false);