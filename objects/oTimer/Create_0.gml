timer = 0;
this_time = 0


best_times = []
levels = tag_get_assets("level")

for (var i = 0; i < array_length(levels); i++)
{
    var room_asset = levels[i];
    var lvl_name = room_asset;

    var lvl_time = load_progress(
        lvl_name + "_BestTime",
        999_999_999,
        true
    );

    best_times[i] = [lvl_name, lvl_time];
}

second = 0;
minute = 0;
hour   = 0;

active = true;

function save_time(){
	if room_is(rm_Initialization, rm_StartFade) {exit;};
	
	
	if (timer < load_section("Times", room_get_name(room) + "_BestTime", 999_999_999, true) )
	{
	    best_time = timer;
	    save_section("Times", room_get_name(room) + "_BestTime", best_time, true);
	}
}