// Store the starting position
ystart_pos = y; 
target_y = ystart_pos;

// Customization settings
return_speed = 0.05; // Returning smoothness (0 to 1)
sink_speed /= 10;
moveDist *= aBLOCK;
restTime *= aSECOND;
sink_distance *= aBLOCK;

target_x = face == RIGHT ? xstart + moveDist : xstart - moveDist
xspd = 0;
is_resting = false;