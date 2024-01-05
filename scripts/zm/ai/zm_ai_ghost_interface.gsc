// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_59f07c660e6710a5;
#using scripts\zm\ai\zm_ai_ghost.gsc;

#namespace zm_ai_ghost_interface;

/*
	Name: function_fd76c3b
	Namespace: zm_ai_ghost_interface
	Checksum: 0x983F6BE4
	Offset: 0x78
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_fd76c3b()
{
	ai::registermatchedinterface(#"ghost", #"run", 0, array(1, 0), &zm_ai_ghost::function_cea6c2e0);
}

