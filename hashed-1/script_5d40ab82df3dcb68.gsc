// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2dc48f46bfeac894;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_6815e036;

/*
	Name: function_89f2df9
	Namespace: namespace_6815e036
	Checksum: 0x40B1FDC
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_323633e8ef642349", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_6815e036
	Checksum: 0xF5AA78A3
	Offset: 0xC0
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function __init__()
{
	ability_player::register_gadget_is_inuse_callbacks(28, &function_5f53485c);
	ability_player::register_gadget_is_flickering_callbacks(28, &function_26290a94);
}

/*
	Name: function_5f53485c
	Namespace: namespace_6815e036
	Checksum: 0x55428F86
	Offset: 0x110
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function function_5f53485c(slot)
{
	return self gadgetisactive(slot);
}

/*
	Name: function_26290a94
	Namespace: namespace_6815e036
	Checksum: 0xB31F8C11
	Offset: 0x140
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function function_26290a94(slot)
{
	return self gadgetflickering(slot);
}

