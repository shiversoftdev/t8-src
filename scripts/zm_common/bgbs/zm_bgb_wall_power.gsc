// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6e3c826b1814cab6;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_stats.gsc;

#namespace zm_bgb_wall_power;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_wall_power
	Checksum: 0x60AD3FB9
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_bgb_wall_power", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_wall_power
	Checksum: 0xAF74B1A5
	Offset: 0xE0
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_wall_power", "event", &event, undefined, undefined, &validation);
}

/*
	Name: event
	Namespace: zm_bgb_wall_power
	Checksum: 0x7DD4F796
	Offset: 0x158
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function event()
{
	self endon(#"disconnect", #"bgb_update");
	self waittill(#"zm_bgb_wall_power_used");
	self playsoundtoplayer(#"zmb_bgb_wall_power", self);
	self zm_stats::increment_challenge_stat(#"gum_gobbler_wall_power");
	self bgb::do_one_shot_use();
}

/*
	Name: validation
	Namespace: zm_bgb_wall_power
	Checksum: 0x617EB3D2
	Offset: 0x1F8
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	if(!namespace_59ff1d6c::function_901b751c(#"hash_51a2cf319e12d9ae"))
	{
		return false;
	}
	return true;
}

