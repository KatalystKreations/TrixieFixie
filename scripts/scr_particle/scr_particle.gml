
/// @desc Short hand for part_particles_burst.
/// @param {asset.gmparticlesystem} _particle Particle System Asset to burst.
/// @param {real} [_x]=x X coordinate.
/// @param {real} [_y]=y Y coordinate.
function particle(_particle, _x = x, _y = y){
	part_particles_burst(global.partSystMain, _x, _y, _particle)
}

