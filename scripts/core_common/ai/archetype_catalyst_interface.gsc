// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\zombie.gsc;
#using script_59f07c660e6710a5;

#namespace catalystinterface;

/*
	Name: registercatalystinterfaceattributes
	Namespace: catalystinterface
	Checksum: 0x63D2DE71
	Offset: 0x88
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function registercatalystinterfaceattributes()
{
	ai::registermatchedinterface(#"catalyst", #"gravity", "normal", array("low", "normal"), &zombiebehavior::function_db26137a);
}

