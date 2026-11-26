// Create Event of obj_spring_pad
launch_angle = image_angle+90;      // 90 = straight up, 45 = up-right, 135 = up-left
min_launch_spd = 5;    // Base bounce power if the player gently walks onto it
//momentum_mult = 1.15;   // Multiplier applied to incoming speed (1.15 = 15% boost)
max_launch_spd = 15;    // Cap to prevent clipping through walls at extreme speeds
cooldown = 0;           // Prevents triggering multiple times in one bounce

squishCurvex = curve_new()
squishCurvey = curve_new()

created_by_player = false;