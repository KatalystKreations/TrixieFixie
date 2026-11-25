if current_message < 0 exit;



if (variable_instance_exists(messages[current_message], "change_dialogue_to") ) {
	instance_destroy();
	exit;
}

var _str = messages[current_message].msg;

if current_char < string_length(_str)
{
	current_char += char_speed;
	if ((keyboard_check_pressed(input_key) ) && input_key_press_count > 0 ) || (mouse_check_button_pressed(mb_any)) || gamepad_button_check_pressed(0, gp_face2) || gamepad_button_check_pressed(0, gp_shoulderr)
	{
		current_char = string_length(_str)
	}
	//Avoid skipping through the first page
	else if keyboard_check_pressed(input_key) && input_key_press_count <= 0
	{
		input_key_press_count++
	}
	draw_message = string_copy(_str, 0, current_char);
}
else if (instance_exists(oCutscene)) {
		if (oCutscene.timer <= 0) {
			if keyboard_check_pressed(input_key) 
			|| mouse_check_button_pressed(mb_any) 
			|| gamepad_button_check_pressed(0, gp_face2) 
			|| gamepad_button_check_pressed(0, gp_shoulderrb)
			|| gamepad_button_check_pressed(0, gp_shoulderr)
			{
				current_message++;
				if current_message >= array_length(messages)
				{
					instance_destroy();
					cutscene_end_action()
				}
				else 
				{
					current_char = 0;
				}
			}
		}
	}
	else{ 
	if keyboard_check_pressed(input_key) 
	|| mouse_check_button_pressed(mb_any) 
	|| gamepad_button_check_pressed(0, gp_face2) 
	|| gamepad_button_check_pressed(0, gp_shoulderrb)
		|| gamepad_button_check_pressed(0, gp_shoulderr)
	{	
		current_message++;
		if current_message >= array_length(messages)
		{
			instance_destroy();
		}
		else 
		{
			current_char = 0;
		}
	}
	
}
