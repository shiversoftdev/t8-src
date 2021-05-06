// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace zm_bgb_arsenal_accelerator;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_arsenal_accelerator
	Checksum: 0x4310A77E
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_bgb_arsenal_accelerator", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_arsenal_accelerator
	Checksum: 0xD207DE82
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
	bgb::register(#"zm_bgb_arsenal_accelerator", "time", 120, &enable, &disable, undefined);
	bgb::function_1fee6b3(#"zm_bgb_arsenal_accelerator", 23);
}

/*
	Name: enable
	Namespace: zm_bgb_arsenal_accelerator
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
	Namespace: zm_bgb_arsenal_accelerator
	Checksum: 0x80F724D1
	Offset: 0x188
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function disable()
{
}

