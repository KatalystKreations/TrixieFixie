if (layer_instance_get_instance(event_data[? "element_id"]) != id) exit;

switch (event_data[? "message"]) {
	 case "spawn_capsule": 
		var dir = point_direction(x,y+25,oPlayer.x,oPlayer.y);
			dir = clamp(dir, 250,290)
			var pro = fire_projectile_dir(x,y+25, 270, oRobotDropperCapsule, 3, 10);
			with (pro)
			{
				stop_on_collide = true;
				destroy_on_collision = false;
				destroy_on_hit = false;
				lifetime = aSECOND*2;
				turn_along_arc = false;
				image_xscale = 1.7;
				image_yscale = image_xscale;
				enemy = choose(noone, oRobotSlug, oRobotSlug, oRobotSlug)
			}
		break;
}