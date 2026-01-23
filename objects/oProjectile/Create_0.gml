

image_xscale *= owner.image_xscale;
image_yscale = owner.image_xscale;
damage *= image_xscale
knockback *= abs(image_xscale)

active = true;
collision = [oWall]


hit_list = ds_list_create();


start_image_xscale = image_xscale;
start_image_yscale = image_yscale;