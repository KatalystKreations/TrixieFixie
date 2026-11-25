#region <--Create Dialogue Function-->
function create_dialogue(_messages){
	if instance_exists(oDialogue) return;
	
	var _inst = instance_create_depth(0, 0, 0, oDialogue);
	_inst.messages = _messages;
	_inst.current_message = 0;
	return _messages;
}
	
#endregion

#region <--Character Name Colors-->
char_colors = 
{
	" ": c_white,
	"Complete": c_yellow,
	"Message Board": c_aqua,
	"Me": #9E0B0F,
	"Lyra": #9E0B0F,
	"Trixie": c_red,
	"Villian": #F49AC2,
	"Stranger": #FFFFFF,
	"Ivy": #F49AC2,
}
#endregion



if (!variable_global_exists("player_name")) {
    global.player_name = "Reso"; // Assign a fallback name if not set
}



#region Msg Board 1 - Picture
msgBoard_eyePic = [
{
	name: "Message Board",
	msg: "*It's a picture of an anime eye...*"
},
{
	name: "Me",
	msg: "Of course. \n*chuckle*"
},
]
#endregion

#region Ivy 1 - Introduction to Level
Ivy1_Intro = [
{
	name: "Ivy",
	msg: "Yo! Let's see how fast you can go through this factory."
},
{
	name: "Lyra",
	msg: "Bet!"
},
{
	change_dialogue_to: -1
}

]
#endregion




