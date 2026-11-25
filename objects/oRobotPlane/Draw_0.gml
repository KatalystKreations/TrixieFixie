
var x_aim = 0
with (oPlayer_par) {
	x_aim = -xspd*20
}
//draw_line(x+x_aim, y, x+x_aim, room_height)
if (collision_line(x+x_aim, y, x+x_aim, room_height, oPlayer_par,false,true)) {
	sprite(sRobot_Plane_Drop)
	fire_projectile_dir(x,y,270, oPlane_Bomb, 5, 10)
}

draw_hitFlash(function(){
	var val = hover(0.05 + choose(0.001, -0.001, 0.00))
    draw_sprite_ext(
		sprite_index, image_index, x, y+val, image_xscale, image_yscale, image_angle, image_blend, image_alpha
	)
})
