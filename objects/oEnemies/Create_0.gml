spd = 1
xspd = 0;
yspd = 0;
face = choose(1, -1);
patrol_range = 100

//hit
	hit = false;
	hit_flash = false;
	hit_flashTimer = 0;
	hit_flashTime = 10;

//flash
image_index_previous = 0;
	sha_add = 0.2
	uni_add = shader_get_uniform(shd_Flash, "add")	