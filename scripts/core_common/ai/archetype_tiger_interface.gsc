// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_59f07c660e6710a5;
#using scripts\core_common\ai\archetype_tiger.gsc;

#namespace tigerinterface;

/*
	Name: registertigerinterfaceattributes
	Namespace: tigerinterface
	Checksum: 0xFEF8FD4B
	Offset: 0x88
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function registertigerinterfaceattributes()
{
	ai::registermatchedinterface(#"tiger", #"gravity", "normal", array("low", "normal"), &tigerbehavior::function_c0b7f4ce);
	ai::registermatchedinterface(#"tiger", #"min_run_dist", 500);
	ai::registermatchedinterface(#"tiger", #"sprint", 0, array(1, 0));
}

