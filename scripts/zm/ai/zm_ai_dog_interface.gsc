// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_59f07c660e6710a5;
#using scripts\zm\ai\zm_ai_dog.gsc;

#namespace zm_ai_dog_interface;

/*
	Name: registerzombiedoginterfaceattributes
	Namespace: zm_ai_dog_interface
	Checksum: 0x56CD641C
	Offset: 0x88
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function registerzombiedoginterfaceattributes()
{
	ai::registermatchedinterface(#"zombie_dog", #"gravity", "normal", array("low", "normal"), &zm_ai_dog::zombiedoggravity);
	ai::registermatchedinterface(#"zombie_dog", #"min_run_dist", 500);
	ai::registermatchedinterface(#"zombie_dog", #"sprint", 0, array(1, 0));
	ai::registermatchedinterface(#"zombie_dog", #"patrol", 0, array(1, 0));
}

