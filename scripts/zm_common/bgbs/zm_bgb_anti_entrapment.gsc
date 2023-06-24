// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace zm_bgb_anti_entrapment;

/*
	Name: __init__system__
	Namespace: zm_bgb_anti_entrapment
	Checksum: 0xAF773440
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_anti_entrapment", &__init__, undefined, "bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_anti_entrapment
	Checksum: 0x7C0DF641
	Offset: 0xD0
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_anti_entrapment", "time", 30, &enable, &disable, undefined, undefined);
	bgb::function_1fee6b3(#"zm_bgb_anti_entrapment", 11);
}

/*
	Name: enable
	Namespace: zm_bgb_anti_entrapment
	Checksum: 0x80F724D1
	Offset: 0x178
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function enable()
{
}

/*
	Name: disable
	Namespace: zm_bgb_anti_entrapment
	Checksum: 0x80F724D1
	Offset: 0x188
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function disable()
{
}

