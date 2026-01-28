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
	"Complete": c_yellow,
	"Me": c_aqua,
	"Cain": c_yellow,
	"Abel": c_lime,
	"Holy Spirit": #F49AC2,
	"Stranger": #FFFFFF,
	"Sarayu": #F49AC2,
}
#endregion



if (!variable_global_exists("player_name")) {
    global.player_name = "Reso"; // Assign a fallback name if not set
}






#region Holy Spirit Dialogue 1 - Introduction
sarayu_intro = [
{
	name: "Stranger",
	msg: "Shalom! Hi! \nSo nice to see you in person."
},
{
	name: "Me",
	msg: "Oh, hi!"
},
{
	name: "Me",
	msg: "..."
},
{
	name: "Stranger",
	msg: "I was hoping you'd remember me at least a little... . \n I am the holy spirit."
},
{
    name: "Me",
    msg: "Um, yeah. Of course I remember you... holy spirit."
},
{
    name: "Holy Spirit",
    msg: "You can call me something more memorable. Just call me..."
},
{
    name: "Sarayu",
    msg: "Sarayu!"
},
{
    name: "Me",
    msg: "Well it's nice to meet you... again, Sarayu!"
},
{
    name: "Sarayu",
    msg: string("Hehehe. Likewise, {0}.", global.player_name)
},
{
    name: "Me",
    msg: "!!!"
},
]
#endregion



#region Abel Dialogue 1 - loves bro
abel_1 = [
{
	name: "Abel",
	msg: "I would've really liked Cain's gift. \nWhy didn't God like it?"
},
{
	name: "Me",
	msg: "..."
},
{
	name: "Me",
	msg: "I don't know. That's a good question."
},
{
	name: "Abel",
	msg: "Maybe Cain did something to it that I didn't see?"
},
{
    name: "Me",
    msg: "I'll try to figure it out."
},
]
#endregion
#region Abel Dialogue 2 - ask to go to field
abel_2 = [
{
	name: "Abel",
	msg: "Do you need something?"
},
{
	name: "Me",
	msg: "YES! I mean... Cain wants to meet you. In the big field."
},
{
	name: "Abel",
	msg: "Oh okay! Thank you."
},
]
#endregion
#region Abel Dialogue 3 - im going
abel_3 = [
{
	name: "Abel",
	msg: "I'm going. Just hold on a minute."
},
]
#endregion
#region Abel Dialogue default - nothing
abel_0 = [
{
	name: "Abel",
	msg: "..."
},
]
#endregion

#region Cain Dialogue 1 - go tell
cain_1 = [
{
	name: "Cain",
	msg: "*sigh*"
},
{
	name: "Me",
	msg: "Are you... okay?"
},
{
	name: "Cain",
	msg: "Can you do something for me?"
},
{
	name: "Me",
	msg: "What's up?"
},
{
	name: "Cain",
	msg: "Can you tell my brother to meet me in the big field? \nYou know the one."
},
{
    name: "Me",
    msg: "Got it."
},
]
#endregion
#region Cain Dialogue 2 - did you tell(no)
cain_2 = [
{
	name: "Cain",
	msg: "Did you do it?"
},
{
	name: "Me",
	msg: "Not yet."
},
{
	name: "Cain",
	msg: "Well? Go do it."
},
{
    name: "Me",
    msg: "I'm about to."
},
]
#endregion
#region Cain Dialogue 3 - did you tell(yes)
cain_3 = [
{
	name: "Cain",
	msg: "Did you do it?"
},
{
	name: "Me",
	msg: "Yup! You're welcome ;)"
},
{
	name: "Cain",
	msg: "Right. You're free to go."
},
{
    name: "Me",
    msg: "Thanks?"
},
]
#endregion
#region Cain Dialogue 4 - leave alone but question
cain_4 = [
{
	name: "Cain",
	msg: "Leave me be."
},
{
    name: "Me",
    msg: "Ok, but first I have a question."
},
{
    name: "Cain",
    msg: "...Ok?"
},
{
    name: "Me",
    msg: "This is gonna sound blunt but:\nDo you know why God didn't like your offering?"
},
{
    name: "Cain",
    msg: "...I, um... don't know. Sorry."
},
{
    name: "Me",
    msg: "Oh, Ok. Thanks anyway. \nSee you later."
},
{
    name: "Cain",
    msg: "See you later..."
},
]
#endregion
#region Cain Dialogue default - nothing
cain_0 = [
{
	name: "Cain",
	msg: "..."
},
]
#endregion