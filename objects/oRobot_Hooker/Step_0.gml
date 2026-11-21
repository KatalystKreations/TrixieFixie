event_inherited();
if (disabled) {exit};
if (moveDir != 0) {face = sign(moveDir);};
if hp > 0 {state();};

decelerate()

mask_index = spr_idle;
