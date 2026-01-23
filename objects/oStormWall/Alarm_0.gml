
//run state code
if !gamestate_is(GAMESTATE.PLAYING)	{
	speed = 0;
}else {
	speed = target_speed;
}

target_speed += 0.25;
speed = target_speed;


alarm[0]=60
var _pro = fire_projectile_dir(x, y, point_direction(x,y,oPlayer.x,oPlayer.y), oCookie_bad , speed*2, 0)
_pro.image_xscale = .25
_pro.image_yscale = .25