// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_4a553e0f995c3d23;
#using script_59f07c660e6710a5;

#namespace namespace_16541c1c;

/*
	Name: registerblightfatherinterfaceattributes
	Namespace: namespace_16541c1c
	Checksum: 0x3D3FAC36
	Offset: 0x88
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function registerblightfatherinterfaceattributes()
{
	ai::registermatchedinterface(#"blight_father", #"tongue_grab_enabled", 1, array(1, 0));
	ai::registermatchedinterface(#"blight_father", #"lockdown_enabled", 1, array(1, 0), &namespace_2ca3706d::function_b95978a7);
	ai::registermatchedinterface(#"blight_father", #"gravity", "normal", array("low", "normal"), &namespace_2ca3706d::function_3e8300e9);
}

