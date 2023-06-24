// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_trial_activate_hazards;

/*
	Name: __init__system__
	Namespace: zm_trial_activate_hazards
	Checksum: 0x68789E7A
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_activate_hazards", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_activate_hazards
	Checksum: 0x621266C2
	Offset: 0xC8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"activate_hazards", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_activate_hazards
	Checksum: 0x74AF0748
	Offset: 0x130
	Size: 0x12
	Parameters: 0
	Flags: Linked, Private
*/
function private on_begin()
{
	level.var_2d307e50 = 1;
}

/*
	Name: on_end
	Namespace: zm_trial_activate_hazards
	Checksum: 0x6D8244EB
	Offset: 0x150
	Size: 0x16
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	level.var_2d307e50 = undefined;
}

