// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using script_672e5f63c92435a9;
#using script_731df012f3a3c2fc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_f56c4eb1;

/*
	Name: function_89f2df9
	Namespace: namespace_f56c4eb1
	Checksum: 0x25D9EE6B
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_5baed9f2dca9a4df", &__init__, undefined, #"hash_5313bfeaba8f80ee");
}

/*
	Name: __init__
	Namespace: namespace_f56c4eb1
	Checksum: 0x7188F315
	Offset: 0xD8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_798e4261c9a11b0b", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_f56c4eb1
	Checksum: 0xCCA0D0C0
	Offset: 0x118
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		character_unlock::function_d2294476(#"hash_7f75d13d0c20331e", 2, 3);
	}
}

