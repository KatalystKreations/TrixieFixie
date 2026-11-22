// Inherit the parent event
event_inherited();

xspd = image_xscale * moveSpd

x += xspd;
getCollisions(1,1,1,
	function(){
		deal_damage(self, hp_max/1)
		image_xscale = -image_xscale
	}
)

