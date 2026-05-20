


function get_hp(_hp = 20) {
	hp = _hp;
}

/**
 * Shoots a projectile in a direction.
 * @param {real} origin_x Spawn x
 * @param {real} origin_y Spawn y
 * @param {any*} dir Direction to lauch
 * @param {id.instance<oprojectile>} [obj_proj]=oProjectile) What to shoot out.
 * @param {real} [speed]=5) How fast the projectile is.
 * @param {real} [damage]=0) How much damage it does.
 * @param {id.instance} [_owner]=id) Who shot it.
 * @returns {id.instance<oprojectile>} oProjectile
 */
function fire_projectile_dir(origin_x, origin_y, dir, obj_proj=oProjectile, speed=5, damage=0, _owner=id) {
    var inst = instance_create_layer(origin_x, origin_y, "FX", obj_proj);
    inst.direction = dir;
    inst.speed = speed;
    inst.damage = damage;
    inst.owner = _owner;
    return inst;
}

/**
 * Shoots a projectile in a direction based on two coords.
 * @param {real} origin_x Spawn x
 * @param {real} origin_y Spawn y
 * @param {any*} target_x x2
 * @param {any*} target_y y2
 * @param {id.instance<oprojectile>} [obj_proj]=oProjectile) What to shoot out.
 * @param {real} [speed]=5) How fast the projectile is.
 * @param {real} [damage]=0) How much damage it does.
 * @param {id.instance} [_owner]=id) Who shot it.
 * @returns instance ID of the projectile
 */
function fire_projectile(origin_x, origin_y, target_x, target_y, obj_proj=oProjectile, speed=5, damage=0, _owner=id) {
    var dir = point_direction(origin_x, origin_y, target_x, target_y);
    var inst = instance_create_layer(origin_x, origin_y, "FX", obj_proj);
    inst.direction = dir;
    inst.speed = speed;
    inst.damage = damage;
    inst.owner = _owner;
    return inst;
}

/// @function apply_knockback(attacker, target, force)
/// @param attacker - instance causing the knockback
/// @param target - instance receiving the knockback
/// @param force - knockback strength

function apply_knockback(attacker, target, force, bouce_up = true) {
    var dir = point_direction(attacker.x, attacker.y+10, target.x, target.y-10);
    target.xspd = lengthdir_x(force, dir);
    target.yspd = lengthdir_y(force, dir);
	if (bouce_up) {
		target.yspd = -(force/2)
	}
	show_debug_message(lengthdir_x(force, dir))
	show_debug_message(lengthdir_y(force, dir))
}


/**
 * Spawn a customizable hit box.
 * @param {real} [_x]=0)  How much in front.
 * @param {real} [_y]=0)  How much down.
 * @param {real} [_damage]=1)  How much damage it does.
 * @param {real} [_frames]=1)  How long it last.
 * @param {real} [xSize]=1)  xScale
 * @param {real} [ySize]=1)  yScale
 * @param {real} [_knockback]=0)  How much knockback.
 * @param {real} [_knockup]=true)  If to knock up.
 * @param {any*} [_owner]=id)  self
 * @returns  Description
 */
function spawn_hitbox(_x = 0 , _y = 0, _damage = 20, _frames = 1, xSize = 1, ySize = 1, _knockback = 5, _knockup = true, _owner = id){
    var hb = instance_create_layer(x + (_x * sign(image_xscale)), y + _y, "FX", oHitbox);
    hb.owner = _owner;
    hb.damage = _damage;
    hb.life = _frames;
	hb.image_xscale = xSize
	hb.image_yscale = ySize
	hb.knockback = _knockback
	hb.knockup = _knockup
	return hb;
}

//Debug Hitbox
/// @desc  Draw the area that a hitbox will take up.
/// @param {real} [_image_index]=-1 The frame to display as reference.
/// @param {asset.gmsprite} [_sprite_index]=sprite_index The sprite to show a frame from.
function debug_draw_hitbox_frame(_image_index = -1, _sprite_index = sprite_index){
	
	// Draw the image index that needs a hitbox
	if (_image_index != -1) {
		image_alpha = .25
		draw_sprite_ext(_sprite_index, _image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, .95);
	}
	
	// Get Controls
	getControls(vk_right, vk_left, vk_down, vk_up)
	
	// Initialize variables
	static hb_x = 0
	static hb_y = 0
	static hb_xsize = 1
	static hb_ysize = 1
	
	// Adjust Position and Scale
	if (runKey) {
		if upKey    hb_ysize+= 0.025;
		if downKey  hb_ysize-= 0.025;
		if rightKey hb_xsize+= 0.025;
		if leftKey  hb_xsize-= 0.025;
	}else {
		if upKey    hb_y--;
		if downKey  hb_y++;
		if rightKey hb_x++;
		if leftKey  hb_x--;
	}
	
	
	var _x1 = hb_x 
	var _y1 = hb_y 
	var _x2 = hb_x + (hb_xsize*sprite_get_width(sHitbox))
	var _y2 = hb_y - (hb_ysize*sprite_get_width(sHitbox))
	
	// Draw Spawn Area
	draw_set_colour(c_purple);
	draw_rectangle(
		x + _x1 * sign(image_xscale) ,
		y + _y1, 
		x + _x2 * sign(image_xscale), 
		y + _y2, 
		true
	)
	draw_set_colour(c_white); // Reset Color
	
	// Hitbox Origin
	var _originX = (_x1+_x2)/2
	var _originY = (_y1+_y2)/2
	
	//Draw a line to Hitbox orgin for tracking off-screen
	var _lx = x + _originX * sign(image_xscale);
	var _ly = y + _originY
	draw_set_colour(c_purple);
	draw_line(_lx, _ly, x, y)
	draw_circle(_lx, _ly, 1, false)
	draw_set_colour(c_white); // Reset Color
	
	// Draw the Hitbox Info
	draw_set_font(fPixel);
	draw_text(
		x+_x1 * sign(image_xscale), 
		y+_y1, 
		string(
			"X: {0} XS:{2} \nY: {1} YS: {3}", 
			_originX, 
			_originY, 
			hb_xsize, 
			hb_ysize
		)
	)
	// Copy Info
	if (keyboard_check_pressed(ord("C"))) {
    	var _text = string(
			"var \n_x = {0}, \n_y = {1}, \n_xs = {2}, \n_ys = {3}",
			_originX, 
			_originY, 
			hb_xsize, 
			hb_ysize
		)
		clipboard_set_text(_text);
		show_debug_message("Copied: \n" + _text);
	}

	// Draw the Controls
	draw_set_font(fPixel);
	draw_text(
		getCamX()+5, 
		getCamY()+5, 
		string(
			"Spawn Hitbox: H \nReset: R \nTranslate: ArrowKeys \nScale: Shift+ArrowKeys \nCopy: C"
		)
	)
	//Spawn Debug Hitbox
	if (keyboard_check_pressed( ord("H") )) {
		var _inst = spawn_hitbox(
			_originX, 
			_originY, 
			0, 
			10, 
			hb_xsize, 
			hb_ysize
		)
	}
	// Reset Variables
	if (keyboard_check_pressed(ord("R"))) {
		hb_x = 0
		hb_y = 0
		hb_xsize = 1
		hb_ysize = 1
	}
}


function inititialize_combat_stats(_hp_max = 100){
	hp_max = _hp_max;
	hp = hp_max;
	
	attacker = false;
	hit = false;
}

/**
 * Function Description
 * @param {any*} _target Description
 * @param {real} [_damage]=1 Description
 */
function deal_damage(_target, _damage = 1, _cam_shake=true){
	if !gamestate_is(GAMESTATE.PLAYING) exit;
	_target.hp -= _damage
	_target.hit = true
	
	if (_cam_shake){
	global.camShake = true; 
	global.camShakeTimer = global.camShakeTime;
	}
}


function get_hit(_damage){
	if !gamestate_is(GAMESTATE.PLAYING) exit;
	self.hit = true
	self.hp -= _damage

	camera_shake()
	global.camShake = true; 
	global.camShakeTimer = global.camShakeTime;
}

//flash
function get_hitFlash(){
	hit = false;
	hit_flash = false;
	hit_flashTimer = 0;
	hit_flashTime = 10;
	
	alred_hit = false;
	hit_time = 10;
	hit_timer = 0;
	
	sha_add = 0.2
	uni_add = shader_get_uniform(shd_flash, "add")	
}

function hit_stuff(hit_flashTime=10, hit_time=6){
	
//Hit Stuff
if (hit)
{
	hit = false;
	hit_flashTimer = hit_flashTime
	hit_timer = hit_time
	alred_hit = true;
}
if (hit_flashTimer)
{
	hit_flashTimer--
	hit_flash = true
}else 
{
	hit_flash = false;
}

if (hit_timer)
{
	hit_timer--
	
}else 
{
	alred_hit = false;
}
}

function draw_hitFlash(_useFace=true){
	//get hit 
	var _col = c_white;
	//if (hp <= hp_danger_zone) _col = c_red
	if (hit_flash){
		draw_one_glow(0.5, _col)
		shader_set(shd_Flash);
	}

	
	shader_set_uniform_f(uni_add, sha_add, 0)
	
	// Draw self with face
	if variable_instance_exists(id, "face") && _useFace
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale*face, image_yscale, image_angle, image_blend, image_alpha);
	else draw_self();
		
	shader_reset();
	sha_add = 1
}



