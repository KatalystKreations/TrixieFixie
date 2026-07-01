draw_self()

if !isSecondary
	draw_sprite_ext(sToolSwitch, 	 1, x, y, image_xscale, image_yscale, 0, image_blend, image_alpha)
else {
	draw_sprite_ext(sToolSwitch, 	 2, x, y, image_xscale, image_yscale, 0, image_blend, image_alpha)
}


//Debug//
//draw_text(x, y, string(activeTool ? "Active" : "Unactive"))