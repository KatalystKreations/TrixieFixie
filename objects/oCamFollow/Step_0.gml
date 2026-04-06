if instance_exists(oPlayer){
	x = oPlayer.x;
	y = oPlayer.y -50;
}
if instance_exists(oPlayer_2){
	x = (oPlayer.x + oPlayer_2.x ) /2;
	y = ((oPlayer.y + oPlayer_2.y ) /2)-5;
}

with oPlayer_2 {
	if x < getCamX() {xspd++}
	if x > getCamX()+getCamW() {xspd--}
}