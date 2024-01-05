// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_trial_disable_hud;

/*
	Name: __init__system__
	Namespace: zm_trial_disable_hud
	Checksum: 0x9D7B1CB
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_disable_hud", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_disable_hud
	Checksum: 0x1AFACF61
	Offset: 0x108
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"disable_hud", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_disable_hud
	Checksum: 0x7D36DD88
	Offset: 0x170
	Size: 0x1C
	Parameters: 0
	Flags: Private
*/
function private on_begin()
{
	level thread function_afe4a356();
}

/*
	Name: function_afe4a356
	Namespace: zm_trial_disable_hud
	Checksum: 0x6B437454
	Offset: 0x198
	Size: 0x100
	Parameters: 0
	Flags: None
*/
function function_afe4a356()
{
	level endon(#"hash_7646638df88a3656", #"end_game");
	wait(12);
	level.var_dc60105c = 1;
	level clientfield::set_world_uimodel("ZMHudGlobal.trials.hudDeactivated", 1);
	foreach(player in getplayers())
	{
		player function_e0c7d69(0);
		player playsoundtoplayer(#"hash_79fced3c02a68283", player);
	}
}

/*
	Name: on_end
	Namespace: zm_trial_disable_hud
	Checksum: 0x2251729D
	Offset: 0x2A0
	Size: 0x120
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	level clientfield::set_world_uimodel("ZMHudGlobal.trials.hudDeactivated", 0);
	level.var_dc60105c = undefined;
	if(level flag::get("round_reset") || level flag::get(#"trial_failed"))
	{
		return;
	}
	foreach(player in getplayers())
	{
		player function_e0c7d69(1);
		player playsoundtoplayer(#"hash_18aab7ffde259877", player);
	}
}

