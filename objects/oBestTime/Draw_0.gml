
/// Draw Event


for (var i = 0; i < array_length(best_times); i++)
{
    var lvl_name = best_times[i][0];
    var bTime    = best_times[i][1];
	
    var total_seconds = floor(bTime / aSECOND);

	var minute = total_seconds div 60;
	var second = total_seconds mod 60;
	var ms = floor((bTime mod aSECOND) / aSECOND * 100);
	
	var m = pad2(minute);
	var s = pad2(second);
	var c = pad2(ms);
	
	if bTime == 999_999_999{
		draw_text(
	        x,
	        y + i * 18,
	        lvl_name + " - " + "No Score"
	    );
	}
	else {
		draw_text(
	        x,
	        y + i * 18,
	        lvl_name + " - " + m + ":" + s + "." + c
	    );
	}
    
}
