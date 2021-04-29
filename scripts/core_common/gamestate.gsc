// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace gamestate;

/*
	Name: set_state
	Namespace: gamestate
	Checksum: 0xF3C8D505
	Offset: 0x80
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function set_state(state)
{
	game.state = state;
	function_cab6408d(state);
}

/*
	Name: function_4c5eea28
	Namespace: gamestate
	Checksum: 0xED58268A
	Offset: 0xB8
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function function_4c5eea28(state)
{
	return game.state == state;
}

/*
	Name: function_674fd868
	Namespace: gamestate
	Checksum: 0x104CF608
	Offset: 0xE0
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function function_674fd868()
{
	return game.state == "postgame" || game.state == "shutdown";
}

/*
	Name: is_shutting_down
	Namespace: gamestate
	Checksum: 0x23F8666
	Offset: 0x120
	Size: 0x18
	Parameters: 0
	Flags: None
*/
function is_shutting_down()
{
	return game.state == "shutdown";
}

