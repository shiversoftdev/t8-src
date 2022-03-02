// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using script_47fb62300ac0bd60;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_470fa642;

/*
	Name: function_89f2df9
	Namespace: namespace_470fa642
	Checksum: 0xCE98A125
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_70e8e157c84263d4", &__init__, undefined, #"hash_39ff5cb883fb68c9");
}

/*
	Name: __init__
	Namespace: namespace_470fa642
	Checksum: 0x27F66CB1
	Offset: 0xE0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::add_callback(#"hash_67dd51a5d529c64c", &function_2a798d57);
	namespace_fa6b9ef8::function_90ee7a97(#"hash_4cfd2023adf3da70", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_470fa642
	Checksum: 0xF3A32B29
	Offset: 0x150
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
	}
}

/*
	Name: function_2a798d57
	Namespace: namespace_470fa642
	Checksum: 0x9D80E218
	Offset: 0x1A0
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_2a798d57()
{
	if(self character_unlock::function_f0406288(#"hash_4cfd2023adf3da70"))
	{
		if(self stats::function_441050ca(#"destroy_equipment") >= 50)
		{
			self character_unlock::function_c8beca5e(#"hash_4cfd2023adf3da70", #"hash_178b421c5b67b4d5", 1);
		}
	}
}

/*
	Name: function_1c4b5097
	Namespace: namespace_470fa642
	Checksum: 0xD64F3DE1
	Offset: 0x230
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"hash_71890d1ecc35f71e")
	{
		if(self character_unlock::function_f0406288(#"hash_4cfd2023adf3da70"))
		{
			if(self stats::function_441050ca(#"destroy_equipment") >= 50)
			{
				self character_unlock::function_c8beca5e(#"hash_4cfd2023adf3da70", #"hash_178b421c5b67b4d5", 1);
			}
		}
	}
}

