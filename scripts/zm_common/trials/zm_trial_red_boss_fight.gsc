// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_red_fasttravel.gsc;
#using scripts\zm\zm_red_boss_battle.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_aoe.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_trial_red_boss_fight;

/*
	Name: __init__system__
	Namespace: zm_trial_red_boss_fight
	Checksum: 0xEF1E7BBF
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_red_boss_fight", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_red_boss_fight
	Checksum: 0xA1B3EC4B
	Offset: 0x120
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"red_boss_fight", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_red_boss_fight
	Checksum: 0xD5AC9F1F
	Offset: 0x188
	Size: 0x3C
	Parameters: 0
	Flags: Linked, Private
*/
function private on_begin()
{
	if(!isdefined(level.var_27a02034))
	{
		level.var_27a02034 = 0;
	}
	level thread start_boss_fight();
}

/*
	Name: on_end
	Namespace: zm_trial_red_boss_fight
	Checksum: 0xDE95D40F
	Offset: 0x1D0
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	if(round_reset)
	{
		level.var_27a02034 = 1;
		zm_aoe::function_3690781e();
	}
	else
	{
		level.check_for_valid_spawn_near_team_callback = level.var_5b175281;
		level.var_5b175281 = undefined;
	}
	level flag::clear(#"infinite_round_spawning");
	level flag::clear(#"pause_round_timeout");
}

/*
	Name: start_boss_fight
	Namespace: zm_trial_red_boss_fight
	Checksum: 0x2C924659
	Offset: 0x278
	Size: 0x1F0
	Parameters: 0
	Flags: Linked, Private
*/
function private start_boss_fight()
{
	level endon(#"end_game", #"hash_7646638df88a3656");
	/#
		level flag::set("");
		level flag::set(#"pap_quest_completed");
		level flag::set(#"zm_red_fasttravel_open");
	#/
	level.var_5b175281 = level.check_for_valid_spawn_near_team_callback;
	level.check_for_valid_spawn_near_team_callback = &function_7d23aaf2;
	if(level.var_27a02034)
	{
		red_boss_battle::function_dfaf17c8();
		level thread red_boss_battle::function_3a2efd4e(0, 0, 0);
	}
	else
	{
		wait(12);
		level lui::screen_fade_out(1);
		level thread red_boss_battle::function_3a2efd4e(0, 0, 1);
		wait(0.5);
		level thread lui::screen_fade_in(1);
	}
	level flag::wait_till(#"boss_battle_complete");
	level flag::clear(#"infinite_round_spawning");
	level flag::clear(#"pause_round_timeout");
	level.zombie_total = 0;
	wait(5);
	level notify(#"kill_round_wait");
}

/*
	Name: function_7d23aaf2
	Namespace: zm_trial_red_boss_fight
	Checksum: 0x83B01A1D
	Offset: 0x470
	Size: 0x60
	Parameters: 2
	Flags: Linked
*/
function function_7d23aaf2(player, var_feed7374)
{
	var_62b2df56 = struct::get_array("s_boss_arena_teleport");
	n_ent_num = player getentitynumber();
	return var_62b2df56[n_ent_num];
}

