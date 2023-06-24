// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_stats.gsc;

#namespace zm_bgb_aftertaste;

/*
	Name: __init__system__
	Namespace: zm_bgb_aftertaste
	Checksum: 0x9C448F6A
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_aftertaste", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_aftertaste
	Checksum: 0x190BD021
	Offset: 0xD8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_aftertaste", "event", &event, undefined, undefined, undefined);
	bgb::register_lost_perk_override(#"zm_bgb_aftertaste", &lost_perk_override, 0);
	bgb::function_1fee6b3(#"zm_bgb_aftertaste", 3);
}

/*
	Name: lost_perk_override
	Namespace: zm_bgb_aftertaste
	Checksum: 0x6D299F9E
	Offset: 0x1A0
	Size: 0x88
	Parameters: 3
	Flags: Linked
*/
function lost_perk_override(perk, var_a83ac70f = undefined, var_6c1b825d = undefined)
{
	if(isdefined(var_a83ac70f) && isdefined(var_6c1b825d) && var_a83ac70f == var_6c1b825d)
	{
		var_a83ac70f zm_stats::increment_challenge_stat(#"hash_19d6a97f1553f96f");
		return true;
	}
	return false;
}

/*
	Name: event
	Namespace: zm_bgb_aftertaste
	Checksum: 0xD4ACA51C
	Offset: 0x238
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function event()
{
	self endon(#"disconnect", #"bled_out", #"bgb_update");
	self thread bgb::run_timer(300);
	self waittilltimeout(300, #"player_revived");
	self bgb::do_one_shot_use(1);
}

