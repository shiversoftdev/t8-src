// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\archetype_blight_father.gsc;
#using script_59f07c660e6710a5;

#namespace blightfatherinterface;

/*
	Name: registerblightfatherinterfaceattributes
	Namespace: blightfatherinterface
	Checksum: 0x3D3FAC36
	Offset: 0x88
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function registerblightfatherinterfaceattributes()
{
	ai::registermatchedinterface(#"blight_father", #"tongue_grab_enabled", 1, array(1, 0));
	ai::registermatchedinterface(#"blight_father", #"lockdown_enabled", 1, array(1, 0), &archetypeblightfather::function_b95978a7);
	ai::registermatchedinterface(#"blight_father", #"gravity", "normal", array("low", "normal"), &archetypeblightfather::function_3e8300e9);
}

