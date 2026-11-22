var top = getCamY()+50
var side = 0
var choose_side = choose(LEFT, RIGHT)
switch (choose_side) {
	case LEFT:
		side = getCamX()
	break;
	case RIGHT:
		side = getCamX()+getCamW()
	break;
}

var p = instance_create_depth(side, top, depth, oRobotPlane)
p.image_xscale = choose_side == RIGHT ? -1 : 1 ;



instance_destroy()
