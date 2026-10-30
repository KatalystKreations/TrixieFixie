
if instance_exists(other.owner){
	direction = point_direction(other.owner.x, other.owner.y, x, y)
	if (variable_instance_exists(other.owner, "xspd"))
	other.owner.xspd = -other.owner.xspd
}
is_good = true
image_blend = c_red