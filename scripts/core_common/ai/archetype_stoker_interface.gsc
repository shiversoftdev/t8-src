// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\archetype_stoker.gsc;
#using script_59f07c660e6710a5;

#namespace stokerinterface;

/*
	Name: registerstokerinterfaceattributes
	Namespace: stokerinterface
	Checksum: 0x99C5EDD9
	Offset: 0x88
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function registerstokerinterfaceattributes()
{
	ai::registermatchedinterface(#"stoker", #"gravity", "normal", array("low", "normal"), &archetype_stoker::function_e4ef4e27);
}

