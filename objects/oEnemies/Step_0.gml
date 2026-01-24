
#region //X Collisions
	var _subPixel = 0.5;
	if place_meeting( x + xspd, y, oWall )
	{	
		// Check for up slopes
		if (!place_meeting(x + xspd, y - (1 + abs(xspd)), oWall) ) { 
			//Move up by small amount if moving on slope
			while place_meeting(x + xspd, y, oWall) { y -= _subPixel; }
		}
		// If no up slope, check for ceiling slopes 
		else
		{
			//Ceiling slopes
			if (!place_meeting(x + xspd, y + abs(xspd)+1, oWall))
			{
				while place_meeting(x+xspd, y, oWall) {y += _subPixel}
			}
			//normal collison
			else
			{
				//Check for tiny gaps between walls and player
				var _pixelCheck = _subPixel * sign(xspd);
				while !place_meeting(x + _pixelCheck, y, oWall) { x += _pixelCheck; }
				
				//"Collide"
				xspd = 0;
			}
		}
	}
	// Check for Down Slopes
	if  (yspd >= 0 && !place_meeting( x + xspd, y + 1, oWall ) && place_meeting( x + xspd, y + abs(xspd)+1, oWall ))
	{
		//precisely move down slope
		while !place_meeting(x + xspd, y + _subPixel, oWall) {y += _subPixel;}
	}



	//Apply X Movement
	x += xspd;
#endregion



//Hit Stuff
if (hit)
{
	
	hit = false;
	hit_flashTimer = hit_flashTime
}
if (hit_flashTimer)
{
	hit_flashTimer--
	hit_flash = true
}else 
{
	hit_flash = false;
}
