// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_trial_flag_check;

/*
	Name: __init__system__
	Namespace: zm_trial_flag_check
	Checksum: 0xD21D74F3
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_flag_check", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_flag_check
	Checksum: 0x365126EF
	Offset: 0xD8
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
	zm_trial::register_challenge(#"flag_check", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_flag_check
	Checksum: 0x4A580E45
	Offset: 0x140
	Size: 0x64
	Parameters: 2
	Flags: Private
*/
function private on_begin(str_flag, var_60bdad5f)
{
	zm_trial_util::function_7d32b7d0(0);
	level.var_5fccce01 = str_flag;
	level.var_4ce2a315 = var_60bdad5f;
	level thread monitor_flag(str_flag);
}

/*
	Name: on_end
	Namespace: zm_trial_flag_check
	Checksum: 0xD6823854
	Offset: 0x1B0
	Size: 0x64
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	zm_trial_util::function_f3dbeda7();
	if(!round_reset)
	{
		if(!level flag::get(level.var_5fccce01))
		{
			zm_trial::fail(level.var_4ce2a315);
		}
	}
}

/*
	Name: monitor_flag
	Namespace: zm_trial_flag_check
	Checksum: 0xE7F06EC6
	Offset: 0x220
	Size: 0x90
	Parameters: 1
	Flags: Private
*/
function private monitor_flag(str_flag)
{
	level endon(#"hash_7646638df88a3656");
	while(true)
	{
		level flag::wait_till(str_flag);
		zm_trial_util::function_7d32b7d0(1);
		level flag::wait_till_clear(str_flag);
		zm_trial_util::function_7d32b7d0(0);
	}
}

