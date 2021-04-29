// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_18a9e529264a3d29;
#using scripts\core_common\system_shared.csc;

#namespace namespace_ea4e2c95;

/*
	Name: function_89f2df9
	Namespace: namespace_ea4e2c95
	Checksum: 0x54A035E9
	Offset: 0xF8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"bowie_knife", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ea4e2c95
	Checksum: 0x80F724D1
	Offset: 0x148
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
}

/*
	Name: __main__
	Namespace: namespace_ea4e2c95
	Checksum: 0xBFA561A4
	Offset: 0x158
	Size: 0xC6
	Parameters: 0
	Flags: Linked, Private
*/
private function __main__()
{
	level.var_8e4168e9 = "bowie_knife";
	level.var_63af3e00 = "bowie_flourish";
	var_57858dd5 = "zombie_fists_bowie";
	if(namespace_cb7cafc3::function_166646a6() == 1)
	{
		level.var_8e4168e9 = "bowie_knife_story_1";
		level.var_63af3e00 = "bowie_flourish_story_1";
		var_57858dd5 = "zombie_fists_bowie_story_1";
	}
	level.var_1c0d76f8 = getweapon(hash(level.var_8e4168e9));
}

