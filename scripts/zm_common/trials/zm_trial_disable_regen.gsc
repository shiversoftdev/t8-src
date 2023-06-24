// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\player\player_shared.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace zm_trial_disable_regen;

/*
	Name: __init__system__
	Namespace: zm_trial_disable_regen
	Checksum: 0x584F26BC
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_disable_regen", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_disable_regen
	Checksum: 0xE7F40035
	Offset: 0x108
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"disable_regen", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_disable_regen
	Checksum: 0x1678FC6D
	Offset: 0x170
	Size: 0x90
	Parameters: 0
	Flags: Private
*/
function private on_begin()
{
	foreach(player in getplayers())
	{
		player val::set("trials_disable_regen", "health_regen", 0);
	}
}

/*
	Name: on_end
	Namespace: zm_trial_disable_regen
	Checksum: 0xC1DDD899
	Offset: 0x208
	Size: 0x98
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	foreach(player in getplayers())
	{
		player val::reset("trials_disable_regen", "health_regen");
	}
}

/*
	Name: is_active
	Namespace: zm_trial_disable_regen
	Checksum: 0x148765F9
	Offset: 0x2A8
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function is_active(var_34f09024 = 0)
{
	challenge = zm_trial::function_a36e8c38(#"disable_regen");
	return isdefined(challenge);
}

