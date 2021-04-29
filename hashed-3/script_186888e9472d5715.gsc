// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_devgui.gsc;

#namespace namespace_879c1bee;

/*
	Name: function_89f2df9
	Namespace: namespace_879c1bee
	Checksum: 0x813CEADE
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_731ab037ad2e053c", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_879c1bee
	Checksum: 0x49D19151
	Offset: 0xD0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	spawner::add_archetype_spawn_function(#"zombie", &function_c381536b);
	/#
		zm_devgui::function_c7dd7a17("", "");
	#/
}

/*
	Name: __main__
	Namespace: namespace_879c1bee
	Checksum: 0x80F724D1
	Offset: 0x138
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_c381536b
	Namespace: namespace_879c1bee
	Checksum: 0xD593BED8
	Offset: 0x148
	Size: 0x36
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c381536b()
{
	if(isdefined(self.var_9fde8624) && self.var_9fde8624 == #"mannequin")
	{
		self.var_80d367d8 = 1;
	}
}

