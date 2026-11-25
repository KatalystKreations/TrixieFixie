depth = -100
getControls()
messages = []
current_message = -1
current_char = 0;
draw_message = "";

char_speed = 0.5;
input_key = ord("E");
input_key_press_count = 0;

gui_w = display_get_gui_width();
gui_h = display_get_gui_height();


imageIndex = 0
if (white_bg) {
	imageIndex = 1
}