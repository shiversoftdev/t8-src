// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using script_672e5f63c92435a9;
#using script_731df012f3a3c2fc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_3c896405;

/*
	Name: function_89f2df9
	Namespace: namespace_3c896405
	Checksum: 0xE0B57CF9
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_237e85b93ac55104", &__init__, undefined, #"hash_34914d2056ad0039");
}

/*
	Name: __init__
	Namespace: namespace_3c896405
	Checksum: 0x8A29EA4C
	Offset: 0xD8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_4ba4e9e33f3d95a6", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_3c896405
	Checksum: 0xB804BEF8
	Offset: 0x118
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		character_unlock::function_d2294476(#"hash_2b1b5d3a3cc282f4", 2, 3);
	}
}

