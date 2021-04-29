// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace ztutorial;

/*
	Name: main
	Namespace: ztutorial
	Checksum: 0x11F08041
	Offset: 0x68
	Size: 0x3E
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	level._zombie_gamemodeprecache = &onprecachegametype;
	level._zombie_gamemodemain = &onstartgametype;
}

/*
	Name: onprecachegametype
	Namespace: ztutorial
	Checksum: 0x5E079CC4
	Offset: 0xB0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function onprecachegametype()
{
	/#
		println("");
	#/
}

/*
	Name: onstartgametype
	Namespace: ztutorial
	Checksum: 0x56FE903A
	Offset: 0xE0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function onstartgametype()
{
	/#
		println("");
	#/
}

