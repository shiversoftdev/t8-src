// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using script_47fb62300ac0bd60;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_3d206f0a;

/*
	Name: function_89f2df9
	Namespace: namespace_3d206f0a
	Checksum: 0x5059FCA9
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5d985b766d8e5176", &__init__, undefined, #"hash_5d85cd0cfa653f3b");
}

/*
	Name: __init__
	Namespace: namespace_3d206f0a
	Checksum: 0x2F57908D
	Offset: 0xE0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_4c8083bdba5bbd92", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_3d206f0a
	Checksum: 0x3F8E31F7
	Offset: 0x120
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::add_callback(#"hash_7a9bdd3ee0ae95af", &function_c915e2a7);
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
	}
}

/*
	Name: function_1c4b5097
	Namespace: namespace_3d206f0a
	Checksum: 0x4EA6B22D
	Offset: 0x1A0
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"hash_447ad6b75cf77f8b")
	{
		if(self character_unlock::function_f0406288(#"hash_4c8083bdba5bbd92"))
		{
			if(self stats::function_441050ca(#"hash_35020c395a89befb") >= 25)
			{
				self character_unlock::function_c8beca5e(#"hash_4c8083bdba5bbd92", #"hash_28966e441535b733", 1);
			}
		}
	}
}

/*
	Name: function_c915e2a7
	Namespace: namespace_3d206f0a
	Checksum: 0xE09047C6
	Offset: 0x270
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_c915e2a7()
{
	if(self character_unlock::function_f0406288(#"hash_4c8083bdba5bbd92"))
	{
		if(self stats::function_441050ca(#"hash_35020c395a89befb") >= 25)
		{
			self character_unlock::function_c8beca5e(#"hash_4c8083bdba5bbd92", #"hash_28966e441535b733", 1);
		}
	}
}

