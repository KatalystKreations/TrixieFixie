var margin = 0;
if !debug_mode exit;

margin += 30;
draw_text(500, margin, string(xspd));

margin += 30;
draw_text(500, margin, string(face));

margin += 30;
draw_text(500, margin, string(moveDir));

margin += 30;
draw_text(500, margin, string(attacker));
margin += 30;
draw_text(500, margin, string((attacker != -4 ? attacker.object_index : -4)));
