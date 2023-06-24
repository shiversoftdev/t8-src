// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\archetype_brutus.gsc;
#using script_59f07c660e6710a5;

#namespace brutusinterface;

/*
	Name: registerbrutusinterfaceattributes
	Namespace: brutusinterface
	Checksum: 0xB4CE821A
	Offset: 0x78
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function registerbrutusinterfaceattributes()
{
	ai::registermatchedinterface(#"brutus", #"can_ground_slam", 0, array(1, 0));
	ai::registermatchedinterface(#"brutus", #"scripted_mode", 0, array(1, 0), &archetypebrutus::function_f8aa76ea);
	ai::registermatchedinterface(#"brutus", #"patrol", 0, array(1, 0));
}

