var player = instance_nearest(x, y, oPlayer_par)
if player == noone exit;
	
if (distance_to_object(player) <= 10) {
	if !vertical
	player.xspd = -player.xspd * 2
	else
	player.yspd = -player.yspd - 0.5
}

