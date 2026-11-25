if (instance_exists(collider)){
	if (!instance_exists(oCutscene)){
		if (place_meeting(x, y, collider)){
			create_cutscene(t_scene_info);
			if (!permanent){
				set_global_flag(string(id)+"triggered")
				instance_deactivate_object(id)
			}
		}
	}
}
