
#region //X Collisions
		var _subPixel = .5;
		if place_meeting( x + xspd, y, oWall )
		{	
					//check for tiny gaps between walls and player
						var _pixelCheck = _subPixel * sign(xspd);
						while ( !place_meeting( x + _pixelCheck, y, oWall ) ) { x += _pixelCheck }
					//Collide
					xspd = 0
			
				
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
