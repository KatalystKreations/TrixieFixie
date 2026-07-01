
spd = 2;

//Curves
curve_head = 1;
curve_speed = .05 * spd;
curve_struct = animcurve_get(anim_ToolSwap);
curve_channel = animcurve_get_channel(curve_struct, 0)

if instance_number(object_index) == 1
with (instance_create_depth(x+sprite_width/2, y-sprite_height/2, depth+1, object_index))
{	
	image_blend = $FFCCCCCC
	image_set_scale(.5)
	activeTool = false;
	isSecondary = true;
	curve_head = 0;
}


