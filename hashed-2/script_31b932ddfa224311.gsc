// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace zm_bgb_power_vacuum;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_power_vacuum
	Checksum: 0xD54AC305
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_bgb_power_vacuum", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_power_vacuum
	Checksum: 0x7904064A
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
	bgb::register(#"zm_bgb_power_vacuum", "time", 300, &enable, &disable, undefined);
}

/*
	Name: enable
	Namespace: zm_bgb_power_vacuum
	Checksum: 0xB43BCB8E
	Offset: 0x150
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	self endon(#"disconnect", #"bled_out", #"bgb_update");
	while(true)
	{
		level waittill(#"powerup_dropped");
		self bgb::do_one_shot_use();
		level.powerup_drop_count = 0;
	}
}

/*
	Name: disable
	Namespace: zm_bgb_power_vacuum
	Checksum: 0x80F724D1
	Offset: 0x1E8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function disable()
{
}

