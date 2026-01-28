
if instance_exists(oDialogue) talking = true; else talking = false;

getControls()

#region
if instance_exists(oDialogue) exit;
//getting close to npc

if instance_exists(oPlayer) && canInteract()
{
	//press interact to talk
	if (global.accessibility_.markers && interact && distance_to_object(oInteract)<3) || interact
	{
		var mesage = create_dialogue(dialogue);
		 //Feather disable once GM1041
		for (var i = 0; i < array_length(dialogue); ++i) {
			if dialogue[i].name != "Me"{
			global.talkingTo = dialogue[i].name
			break;}
		}

	}
}
#endregion
