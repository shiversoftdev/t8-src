// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using script_672e5f63c92435a9;
#using script_731df012f3a3c2fc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_56dcd5e;

/*
	Name: function_89f2df9
	Namespace: namespace_56dcd5e
	Checksum: 0xE9D54012
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_4d20bdb63281c38", &__init__, undefined, #"hash_1906a0df69010a5");
}

/*
	Name: __init__
	Namespace: namespace_56dcd5e
	Checksum: 0x95BFB057
	Offset: 0xD8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_36698e3567c4b204", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_56dcd5e
	Checksum: 0x3D1101AD
	Offset: 0x118
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		character_unlock::function_d2294476(#"hash_2b254f3a3ccabfaf", 2, 3);
	}
}

