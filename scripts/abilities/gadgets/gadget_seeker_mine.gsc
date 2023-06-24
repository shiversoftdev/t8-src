// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\abilities\ability_player.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace gadget_seeker_mine;

/*
	Name: __init__system__
	Namespace: gadget_seeker_mine
	Checksum: 0x40B1FDC
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
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
	ability_player::register_gadget_is_inuse_callbacks(28, &gadget_seeker_mine_is_inuse);
	ability_player::register_gadget_is_flickering_callbacks(28, &gadget_seeker_mine_is_flickering);
}

/*
	Name: gadget_seeker_mine_is_inuse
	Namespace: gadget_seeker_mine
	Checksum: 0x55428F86
	Offset: 0x110
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function gadget_seeker_mine_is_inuse(slot)
{
	return self gadgetisactive(slot);
}

/*
	Name: gadget_seeker_mine_is_flickering
	Namespace: gadget_seeker_mine
	Checksum: 0xB31F8C11
	Offset: 0x140
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function gadget_seeker_mine_is_flickering(slot)
{
	return self gadgetflickering(slot);
}

