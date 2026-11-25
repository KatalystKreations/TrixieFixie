

image_xscale *= owner.image_xscale;
image_yscale = owner.image_xscale;
damage *= image_xscale
knockback *= abs(image_xscale)

active = true;
col_layer = layer_tilemap_get_id("MainTiles");
collision = [oWall, col_layer];

hit_entities = [];


start_image_xscale = image_xscale;
start_image_yscale = image_yscale;