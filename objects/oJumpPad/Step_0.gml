// Step Event of obj_spring_pad
if (cooldown > 0) cooldown--;

squishCurvex.step()
squishCurvey.step()

if (place_meeting(x,y-1,oPlayer_par)) {
	squishCurvex.start(anim_squish, 20)
	squishCurvey.start(anim_squish, 20, 1, 1)
}
var vx = squishCurvex.curve_value
var vy = squishCurvey.curve_value
if squishCurvex.curve_value {
	image_yscale = vy
	image_xscale = vx
}

