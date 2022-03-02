// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using script_672e5f63c92435a9;
#using script_731df012f3a3c2fc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_18a42c03;

/*
	Name: function_89f2df9
	Namespace: namespace_18a42c03
	Checksum: 0x2B9D2BEB
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_739ff925eb6257e2", &__init__, undefined, #"hash_5ff3d0a390e9775f");
}

/*
	Name: __init__
	Namespace: namespace_18a42c03
	Checksum: 0x60EB8187
	Offset: 0xD8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_77a2176db1d8a05c", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_18a42c03
	Checksum: 0x48E756B6
	Offset: 0x118
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		character_unlock::function_d2294476(#"hash_2b1b5e3a3cc284a7", 3, 4);
	}
}

