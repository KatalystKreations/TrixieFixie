var _camx = camera_get_view_x(view_camera[0])
var _camy = camera_get_view_y(view_camera[0])

//smaller numbers mean more movement
var _col = #FFFFFF
var _p0 = 0.5;
var _p1 = 0.25;
var _p2 = 0.1;
var _p3 = 0.01;


_col = #555555
draw_sprite_tiled_ext(current_bg, 1, _camx*_p0, _camy*_p0, image_xscale, image_yscale, _col, 1)

_col = #7D7D7D
draw_sprite_tiled_ext(current_bg, 2, _camx*_p1, _camy*_p1, image_xscale, image_yscale, _col, 1)

_col = #B7B7B7
draw_sprite_tiled_ext(current_bg, 3, _camx*_p2, _camy*_p2, image_xscale, image_yscale, _col, 1)

_col = #FFFFFF
draw_sprite_tiled_ext(current_bg, 4, _camx*_p3, _camy*_p3, image_xscale, image_yscale, _col, 1)