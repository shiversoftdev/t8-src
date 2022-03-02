// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2dc48f46bfeac894;
#using scripts\core_common\system_shared.gsc;

#namespace gadget_seeker_mine;

/*
	Name: function_89f2df9
	Namespace: gadget_seeker_mine
	Checksum: 0x40B1FDC
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"gadget_seeker_mine", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: gadget_seeker_mine
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
	Namespace: gadget_seeker_mine
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
	Namespace: gadget_seeker_mine
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

