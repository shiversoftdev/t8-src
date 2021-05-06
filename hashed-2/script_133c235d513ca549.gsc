// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using script_731df012f3a3c2fc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_76be6fb6;

/*
	Name: function_89f2df9
	Namespace: namespace_76be6fb6
	Checksum: 0xFD57BB71
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_70b1180bdd22bf41", &__init__, undefined, #"hash_3c720bfdc5ea4ee8");
}

/*
	Name: __init__
	Namespace: namespace_76be6fb6
	Checksum: 0x906E6544
	Offset: 0xD0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_6c2a3baefe289e35", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_76be6fb6
	Checksum: 0x4B7541AA
	Offset: 0x110
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		if(isdefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659"))
		{
			namespace_b0722f43::function_e70fa91c(#"hash_34dde6670d802e92", #"hash_336749f373d0fbf7", 3);
		}
		else
		{
			namespace_b0722f43::function_e70fa91c(#"hash_34dde6670d802e92", #"hash_336749f373d0fbf7", 10);
		}
	}
}

