// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\struct.csc;

#namespace ztcm;

/*
	Name: main
	Namespace: ztcm
	Checksum: 0xBD011B61
	Offset: 0x78
	Size: 0xA4
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	level._zombie_gamemodeprecache = &onprecachegametype;
	level._zombie_gamemodemain = &onstartgametype;
	if(!level flag::exists(#"ztcm"))
	{
		level flag::init(#"ztcm", 1);
	}
	/#
		println("");
	#/
}

/*
	Name: onprecachegametype
	Namespace: ztcm
	Checksum: 0xD8AADCDA
	Offset: 0x128
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
	Namespace: ztcm
	Checksum: 0xF1F56CD5
	Offset: 0x158
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

