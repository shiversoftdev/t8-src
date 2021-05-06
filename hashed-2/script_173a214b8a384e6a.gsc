// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using script_731df012f3a3c2fc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_55bde9ea;

/*
	Name: function_89f2df9
	Namespace: namespace_55bde9ea
	Checksum: 0xD4DC92B
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_6accb974878ca75c", &__init__, undefined, #"hash_3aded3fedbbfc401");
}

/*
	Name: __init__
	Namespace: namespace_55bde9ea
	Checksum: 0x7373FB73
	Offset: 0xD0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_35708904c4af42d0", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_55bde9ea
	Checksum: 0xCADA640
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
			namespace_b0722f43::function_e70fa91c(#"hash_5d3928f724e1cadf", #"hash_2b1e613a3cc4bf97", 2);
		}
		else
		{
			namespace_b0722f43::function_e70fa91c(#"hash_5d3928f724e1cadf", #"hash_2b1e613a3cc4bf97", 6);
		}
	}
}

