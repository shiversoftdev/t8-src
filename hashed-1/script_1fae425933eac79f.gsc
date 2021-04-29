// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2118e128407b7acb;
#using script_59f07c660e6710a5;

#namespace namespace_8179cac5;

/*
	Name: registerzombiedoginterfaceattributes
	Namespace: namespace_8179cac5
	Checksum: 0x56CD641C
	Offset: 0x88
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function registerzombiedoginterfaceattributes()
{
	ai::registermatchedinterface(#"zombie_dog", #"gravity", "normal", array("low", "normal"), &namespace_5eb9b9b6::zombiedoggravity);
	ai::registermatchedinterface(#"zombie_dog", #"min_run_dist", 500);
	ai::registermatchedinterface(#"zombie_dog", #"sprint", 0, array(1, 0));
	ai::registermatchedinterface(#"zombie_dog", #"patrol", 0, array(1, 0));
}

