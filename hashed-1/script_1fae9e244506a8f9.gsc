// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using script_731df012f3a3c2fc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_7aa9aa73;

/*
	Name: function_89f2df9
	Namespace: namespace_7aa9aa73
	Checksum: 0x21B30802
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_29d607517753436d", &__init__, undefined, #"hash_2b729a318b495ddc");
}

/*
	Name: __init__
	Namespace: namespace_7aa9aa73
	Checksum: 0x383082C0
	Offset: 0xD0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_14743213b896d2e5", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_7aa9aa73
	Checksum: 0xE033EC1A
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
			namespace_b0722f43::function_e70fa91c(#"hash_2e8c8c85b6034ab3", #"hash_d245b711188db4c", 1);
		}
		else
		{
			namespace_b0722f43::function_e70fa91c(#"hash_4bfbb656e63b17ae", #"hash_d245b711188db4c", 6);
		}
	}
}

