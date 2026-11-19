
/// Create Event

best_times = []
levels = tag_get_assets("level")

for (var i = 0; i < array_length(levels); i++)
{
    var room_asset = levels[i];
    var lvl_name = room_asset;

    var lvl_time = load_section(
		"Times", 
        lvl_name + "_BestTime",
        999_999_999,
        true
    );

    best_times[i] = [lvl_name, lvl_time];
}