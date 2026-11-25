
getGPcontrols()
// Pickup range
//draw_circle(x, y-32, aBLOCK*1.5, true)


if (!is_holding) {
	draw_self();
}else {
    var sprW  = sprite_get_width(sprite_index);
    var sprH  = sprite_get_height(spr_idle);

    var splitBottom = 12;          // bottom pixels to draw from original
    var splitTop    = sprH - 12;   // top pixels to draw from spr_hold

    var ox = sprite_get_xoffset(sprite_index);
    var oy = sprite_get_yoffset(sprite_index);

    var drawX = x - ox * image_xscale;
    var drawY = y - oy * image_yscale;

    // --- Draw bottom 12 pixels of original sprite ---
    draw_sprite_part_ext(
        sprite_index, image_index,
        0, splitTop,            // source x,y
        sprW, splitBottom,      // width, height
        drawX,
        drawY + splitTop * image_yscale,
        image_xscale, image_yscale,
        image_blend, image_alpha
    );

    // --- Draw top 45 pixels from spr_hold ---
    draw_sprite_part_ext(
        spr_hold, image_index,
        0, 0,                   // source x,y
        sprW, splitTop,         // width, height
        drawX,
        drawY,
        image_xscale, image_yscale,
        image_blend, image_alpha
    );
}



// Aim Iceball
	var px, py, distance=16
	var canDrawArrow = false;
	// Calculate dir
		// If using controller
		if (global.gamepad_main != undefined) {
			px = x + lengthdir_x(distance, aim_angle_rs);
			py = y-(sprite_height/2) + lengthdir_y(distance, aim_angle_rs);
			if abs(gamepad_axis_value(player_num, gp_axisrh)) > 0.2 canDrawArrow = true;
			if abs(gamepad_axis_value(player_num, gp_axisrv)) > 0.2 canDrawArrow = true;
			if rbBtn canDrawArrow = true;
			}
		// If using mouse
		else {
			px = x
			if place_meeting(x+5, y, collision) px = x-5 
			if place_meeting(x-5, y, collision) px = x+5 
			py = y -(sprite_height/2)
			aim_angle_rs = point_direction(px, py, mouse_x, mouse_y)
			if (mouse_check_button(mb_left)) { canDrawArrow = true; }
		}
	// Draw Arrow
	if canDrawArrow
	draw_sprite_ext(sAimArrow, 1, px, py, 1, 1, aim_angle_rs, -1, image_alpha)









//draw_hitFlash()


// Use a test shader for patcitce
//if downKey
//shader_set(shd_test);
//if downKeyPressed pulse_curve_head = 0.35;
//var _cur_val = animcurve_channel_evaluate(pulse_curve_channel, pulse_curve_head)
//pulse_curve_head = min(pulse_curve_head+pulse_curve_speed, 1)
//pulse_curve_head = pulse_curve_head mod 1;
//
//shader_set_uniform_f(mouse, _cur_val);
//draw_self();
//shader_reset();










// ------------------ Debug Mode ----------------- //


var 
padding_x = 3,
padding_y = 3;


if !debug_mode exit;
	
//Hitbox
//debug_draw_hitbox_frame(7, sSkeleton_Attack)


//state text back / rect
draw_roundrect_ext(
x - (string_width(state_name)/2) - padding_x, 
y - sprite_height, 
x + (string_width(state_name)/2) + padding_x,
y - sprite_height - string_height(state_name),
5, 5, 0
)
//state text 
draw_set_color(c_dkgrey)
draw_text(
x - (string_width(state_name)/2), 
y - sprite_height - string_height(state_name), 
string(state_name)
)
draw_set_color(c_white)
//
//var _text = string(sprite_index)
////state text back / rect
//draw_roundrect_ext(
//x - (string_width(_text)/2) - padding_x, 
//y - sprite_height, 
//x + (string_width(_text)/2) + padding_x,
//y - sprite_height - string_height(_text),
//5, 5, 0
//)
////state text 
//draw_set_color(c_dkgrey)
//draw_text(
//x - (string_width(_text)/2), 
//y - sprite_height - string_height(_text), 
//string(_text)
//)
//draw_set_color(c_white)