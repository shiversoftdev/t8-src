// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;

#namespace tracker;

/*
	Name: init_shared
	Namespace: tracker
	Checksum: 0x5F665AA7
	Offset: 0xB8
	Size: 0x14
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	registerclientfields();
}

/*
	Name: registerclientfields
	Namespace: tracker
	Checksum: 0x3DFB760D
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: Private
*/
function private registerclientfields()
{
	clientfield::register("clientuimodel", "huditems.isExposedOnMinimap", 1, 1, "int", undefined, 0, 0);
}

