// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\perks.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace zm_bgb_head_drama;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_head_drama
	Checksum: 0x27459FC3
	Offset: 0xB0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_bgb_head_drama", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_head_drama
	Checksum: 0x8C9460FA
	Offset: 0x100
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_head_drama", "time", 300, &enable, &disable, undefined);
}

/*
	Name: enable
	Namespace: zm_bgb_head_drama
	Checksum: 0xEE415823
	Offset: 0x180
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	self perks::function_7637bafa("specialty_locdamagecountsasheadshot");
}

/*
	Name: disable
	Namespace: zm_bgb_head_drama
	Checksum: 0xA4A0B6FD
	Offset: 0x1B0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function disable()
{
	self perks::function_45d12554("specialty_locdamagecountsasheadshot");
}

