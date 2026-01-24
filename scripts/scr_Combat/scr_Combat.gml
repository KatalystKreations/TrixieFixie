



enum FX_TYPE {
    NONE,
    ICE,
    FIRE,
    DISTORT,
    RIPPLE
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
    var inst = instance_create_layer(origin_x, origin_y, "Objects", obj_proj);
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
 * @param {asset.gmobject} [obj_proj]=oProjectile) What to shoot out.
 * @param {real} [speed]=5) How fast the projectile is.
 * @param {real} [damage]=0) How much damage it does.
 * @param {id.instance} [_owner]=id) Who shot it.
 * @returns instance ID of the projectile
 */
function fire_projectile(origin_x, origin_y, target_x, target_y, obj_proj=oProjectile, speed=5, damage=0, _owner=id) {
    var dir = point_direction(origin_x, origin_y, target_x, target_y);
    var inst = instance_create_layer(origin_x, origin_y, "Player", obj_proj);
    inst.direction = dir;
    inst.speed = speed;
    inst.damage = damage;
    inst.owner = _owner;
    return inst;
}

function fire_projectile_ext(origin_x, origin_y, target_x, target_y, obj_proj, config) {
	
    var dir = point_direction(origin_x, origin_y, target_x, target_y);
    
	var inst = instance_create_layer(origin_x, origin_y, "PlayerLevel", obj_proj);
    
    inst.direction = dir;
    
	
	
	inst.speed     = config.speed     ?? 1;
    inst.damage    = config.damage    ?? 0;
    inst.knockback = config.knockback ?? 0;
    inst.fx_type   = config.fx_type   ?? FX_TYPE.NONE;
    inst.lifetime  = config.lifetime  ?? 10;
    inst.owner     = config.owner     ?? id;
    
    return inst;
}

function apply_config(_default) {
    return {
        speed:     _default.speed     ?? 1,
        damage:    _default.damage    ?? 0,
        knockback: _default.knockback ?? 0,
        fx_type:   _default.fx_type   ?? FX_TYPE.NONE,
        lifetime:  _default.lifetime  ?? 10,
        owner:     _default.owner     ?? id 
    };
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
 * @param {real} [_x]=0 How much in front.
 * @param {real} [_y]=0 How much down.
 * @param {real} [_damage]=20 How much damage it does.
 * @param {real} [_frames]=1 How long it last.
 * @param {real} [xSize]=1 x Scale
 * @param {real} [ySize]=1 y Scale
 * @param {any*} [_owner]=id self
 * @returns  Description
 */
function spawn_hitbox(_x = 0 , _y = 0, _damage = 20, _frames = 1, xSize = 1, ySize = 1, _owner = id, _knockback = 5, _knockup = true){
    var hb = instance_create_layer(x + (_x * sign(image_xscale)), y + _y, "FX", oAttackHitbox);
    hb.owner = _owner;
    hb.damage = _damage;
    hb.life = _frames;
	hb.image_xscale = xSize
	hb.image_yscale = ySize
	hb.knockback = _knockback
	hb.knockup = _knockup
	return hb;

}



function get_hp_etc(_hp_max = 100){
	self.hp_max = _hp_max;
	self.hp = hp_max;
	
	hit = false;
}

/**
 * Function Description
 * @param {any*} _target Description
 * @param {real} [_damage]=1 Description
 */
function deal_damage(_target, _damage = 1){
	if oGame.alarm[0] exit;
	_target.hp -= _damage
	_target.hit = true
	
	global.camShake = true; 
	global.camShakeTimer = global.camShakeTime;
}


function get_hit(_damage){
	if oGame.alarm[0] exit;
	self.hit = true
	self.hp -= _damage

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
	uni_add = shader_get_uniform(shd_Flash, "add")	
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

function draw_hitFlash(){
	//get hit 
	var _col = c_white;
	//if (hp <= hp_danger_zone) _col = c_red
	if (hit_flash){
		draw_one_glow(0.5, _col)
		shader_set(shd_Flash);
	}

	
	shader_set_uniform_f(uni_add, sha_add, 0)
	
	draw_self();
	
	shader_reset();
	sha_add = 1
}

