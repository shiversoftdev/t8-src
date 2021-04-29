// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.csc;

#namespace zgrief;

/*
	Name: main
	Namespace: zgrief
	Checksum: 0xD2EE872E
	Offset: 0x70
	Size: 0x5C
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	level._zombie_gamemodeprecache = &onprecachegametype;
	level._zombie_gamemodemain = &onstartgametype;
	/#
		println("");
	#/
}

/*
	Name: onprecachegametype
	Namespace: zgrief
	Checksum: 0x57ADF8A3
	Offset: 0xD8
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
	Namespace: zgrief
	Checksum: 0xEC81B674
	Offset: 0x108
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

