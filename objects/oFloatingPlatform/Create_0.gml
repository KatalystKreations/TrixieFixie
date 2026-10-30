// Store the starting position
ystart_pos = y; 
target_y = ystart_pos;

// Customization settings
sink_distance = aBLOCK/2;  // How many pixels it sinks
sink_speed = 0.1;    // Sinking smoothness (0 to 1)
return_speed = 0.05; // Returning smoothness (0 to 1)


target_x = face == RIGHT ? xstart + moveDist : xstart - moveDist
xspd = 0;
is_resting = false;