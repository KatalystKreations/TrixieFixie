if instance_exists(other.owner) && can_deflect{
	direction = point_direction(other.owner.x, other.owner.y, x, y)
}