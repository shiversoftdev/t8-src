// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using script_731df012f3a3c2fc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_f364fbe7;

/*
	Name: function_89f2df9
	Namespace: namespace_f364fbe7
	Checksum: 0xCE9CE0A0
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_39f483eb35f789a1", &__init__, undefined, #"hash_5f346d1d9a7b2a08");
}

/*
	Name: __init__
	Namespace: namespace_f364fbe7
	Checksum: 0xECED5268
	Offset: 0xD0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_772c78d5db0889f1", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_f364fbe7
	Checksum: 0x29FB2538
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
			namespace_b0722f43::function_e70fa91c(#"hash_2e8c8c85b6034ab3", #"hash_d245e711188e065", 1);
		}
		else
		{
			namespace_b0722f43::function_e70fa91c(#"hash_4bfbb656e63b17ae", #"hash_d245e711188e065", 6);
		}
	}
}

