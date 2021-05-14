// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_59f07c660e6710a5;
#using script_d8b1f4ee30e5fc5;

#namespace namespace_93b6af30;

/*
	Name: registertigerinterfaceattributes
	Namespace: namespace_93b6af30
	Checksum: 0xFEF8FD4B
	Offset: 0x88
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function registertigerinterfaceattributes()
{
	ai::registermatchedinterface(#"tiger", #"gravity", "normal", array("low", "normal"), &namespace_dea34b6a::function_c0b7f4ce);
	ai::registermatchedinterface(#"tiger", #"min_run_dist", 500);
	ai::registermatchedinterface(#"tiger", #"sprint", 0, array(1, 0));
}

