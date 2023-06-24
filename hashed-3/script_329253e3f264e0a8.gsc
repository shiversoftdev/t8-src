// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_87ea1cc;

/*
	Name: __init__system__
	Namespace: namespace_87ea1cc
	Checksum: 0xD9770D87
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_445fb98049b74edc", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_87ea1cc
	Checksum: 0x515DC094
	Offset: 0xF8
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
	zm_trial::register_challenge(#"board_everything", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_87ea1cc
	Checksum: 0x38E136F4
	Offset: 0x160
	Size: 0x34
	Parameters: 0
	Flags: Private
*/
function private on_begin()
{
	zm_powerups::function_74b8ec6b("carpenter");
	level thread function_4172344e();
}

/*
	Name: on_end
	Namespace: namespace_87ea1cc
	Checksum: 0xFD858BDA
	Offset: 0x1A0
	Size: 0x8C
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	if(!round_reset && level.var_3de460b1 < level.var_70135c38)
	{
		zm_trial::fail(#"hash_e0fa688fb248886");
	}
	level.var_3de460b1 = undefined;
	level.var_70135c38 = undefined;
	zm_trial_util::function_f3dbeda7();
	zm_powerups::function_41cedb05("carpenter");
}

/*
	Name: function_4172344e
	Namespace: namespace_87ea1cc
	Checksum: 0xEDFA5980
	Offset: 0x238
	Size: 0x17A
	Parameters: 0
	Flags: None
*/
function function_4172344e()
{
	level endon(#"hash_7646638df88a3656");
	while(true)
	{
		level.var_70135c38 = level.exterior_goals.size;
		level.var_3de460b1 = 0;
		foreach(s_barrier in level.exterior_goals)
		{
			if(zm_utility::all_chunks_intact(s_barrier, s_barrier.barrier_chunks) || zm_utility::no_valid_repairable_boards(s_barrier, s_barrier.barrier_chunks))
			{
				level.var_3de460b1++;
			}
		}
		zm_trial_util::function_2976fa44(level.var_70135c38);
		zm_trial_util::function_dace284(level.var_3de460b1, 1);
		var_be17187b = undefined;
		var_be17187b = level waittill(#"zombie_board_tear", #"board_repaired", #"carpenter_finished");
	}
}

