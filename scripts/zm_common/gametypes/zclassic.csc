// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.csc;

#namespace zclassic;

/*
	Name: main
	Namespace: zclassic
	Checksum: 0xD25ECAC5
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
	Namespace: zclassic
	Checksum: 0xBA7E0427
	Offset: 0xD8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function onprecachegametype()
{
	/#
		println("");
	#/
}

/*
	Name: onstartgametype
	Namespace: zclassic
	Checksum: 0x8A8910EB
	Offset: 0x108
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function onstartgametype()
{
	/#
		println("");
	#/
}

