// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace zm_bgb_temporal_gift;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_temporal_gift
	Checksum: 0xDAA5138F
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_bgb_temporal_gift", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_temporal_gift
	Checksum: 0x791EFC5
	Offset: 0xD0
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
	bgb::register(#"zm_bgb_temporal_gift", "time", 300, &enable, &disable, undefined);
}

/*
	Name: enable
	Namespace: zm_bgb_temporal_gift
	Checksum: 0x80F724D1
	Offset: 0x150
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function enable()
{
}

/*
	Name: disable
	Namespace: zm_bgb_temporal_gift
	Checksum: 0x80F724D1
	Offset: 0x160
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function disable()
{
}

