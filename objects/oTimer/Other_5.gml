

if room_is(rm_Initialization, rm_StartFade) exit;
	

if (timer < load_section("Times", room_get_name(room) + "_BestTime", 999_999_999, true) )
{
    best_time = timer;
    save_section("Times", room_get_name(room) + "_BestTime", best_time, true);
}

