// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2dc48f46bfeac894;
#using scripts\core_common\system_shared.gsc;

#namespace gadget_other;

/*
	Name: function_89f2df9
	Namespace: gadget_other
	Checksum: 0x44EFEA1F
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"gadget_other", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: gadget_other
	Checksum: 0x61339F15
	Offset: 0xC0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	ability_player::register_gadget_is_inuse_callbacks(1, &gadget_other_is_inuse);
	ability_player::register_gadget_is_flickering_callbacks(1, &gadget_other_is_flickering);
}

/*
	Name: gadget_other_is_inuse
	Namespace: gadget_other
	Checksum: 0x894702BA
	Offset: 0x110
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function gadget_other_is_inuse(slot)
{
	return self gadgetisactive(slot);
}

/*
	Name: gadget_other_is_flickering
	Namespace: gadget_other
	Checksum: 0xC0117DB2
	Offset: 0x140
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function gadget_other_is_flickering(slot)
{
	return self gadgetflickering(slot);
}

/*
	Name: set_gadget_other_status
	Namespace: gadget_other
	Checksum: 0x905E104E
	Offset: 0x170
	Size: 0xBC
	Parameters: 3
	Flags: None
*/
function set_gadget_other_status(weapon, status, time)
{
	/#
		timestr = "";
		if(isdefined(time))
		{
			timestr = ("" + "") + time;
		}
		if(getdvarint(#"scr_cpower_debug_prints", 0) > 0)
		{
			self iprintlnbold(((("" + weapon.name) + "") + status) + timestr);
		}
	#/
}

