// Main
	moveDir 	= 0;
	moveSpd 	= 5;
	xspd 		= 0;
	yspd 		= 0;
	face 		= 1;
	patrol_range = 100

//Sprites
	spr_idle = sFrame
	spr_walk = sFrame
	spr_land = sFrame
	spr_death = sFrame


//hit
	hit = false;
	hit_flash = false;
	hit_flashTimer = 0;
	hit_flashTime = 10;

//flash
image_index_previous = 0;
	sha_add = 0.2
	uni_add = shader_get_uniform(shd_Flash, "add")	


disabled = false;
function disable(){
	disabled = true
}
function enable(){
	disabled = false;
}