var margin = 20;

if (instance_exists(oPlayer)){
draw_healthbar(110, 23, 190, 73, oPlayer.hp, #666666, #D32300, c_red, 0, 1, 0)

//player img
draw_sprite_ext(sPlayerHealth_hud, 1, margin, margin, 1, 1, 0, -1, 1)

//healthbar rim
draw_sprite_ext(sPlayerHealth_hud_1, 1, margin+84, margin, 1, 1, 0, -1, 1)

}
