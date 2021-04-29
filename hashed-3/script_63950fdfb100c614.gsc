// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47495939f228e438;
#using script_4a88aba9724a1fa1;
#using script_6021ce59143452c3;
#using script_7fb9f17f6fab98e3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_187676eb;

/*
	Name: function_89f2df9
	Namespace: namespace_187676eb
	Checksum: 0xEF1E7BBF
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_c8fee57efaec958", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_187676eb
	Checksum: 0xA1B3EC4B
	Offset: 0x120
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!namespace_f551babc::function_b47f6aba())
	{
		return;
	}
	namespace_f551babc::register_challenge(#"hash_1c600f8141a34a9", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_187676eb
	Checksum: 0xD5AC9F1F
	Offset: 0x188
	Size: 0x3C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d1de6a85()
{
	if(!isdefined(level.var_27a02034))
	{
		level.var_27a02034 = 0;
	}
	level thread function_9bf92e71();
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_187676eb
	Checksum: 0xDE95D40F
	Offset: 0x1D0
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	if(round_reset)
	{
		level.var_27a02034 = 1;
		namespace_65dba40e::function_3690781e();
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
	Name: function_9bf92e71
	Namespace: namespace_187676eb
	Checksum: 0x2C924659
	Offset: 0x278
	Size: 0x1F0
	Parameters: 0
	Flags: Linked, Private
*/
private function function_9bf92e71()
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
		namespace_765d6379::function_dfaf17c8();
		level thread namespace_765d6379::function_3a2efd4e(0, 0, 0);
	}
	else
	{
		wait(12);
		level lui::screen_fade_out(1);
		level thread namespace_765d6379::function_3a2efd4e(0, 0, 1);
		wait(0.5);
		level thread lui::screen_fade_in(1);
	}
	level flag::wait_till(#"hash_293ba2e98a617133");
	level flag::clear(#"infinite_round_spawning");
	level flag::clear(#"pause_round_timeout");
	level.zombie_total = 0;
	wait(5);
	level notify(#"kill_round_wait");
}

/*
	Name: function_7d23aaf2
	Namespace: namespace_187676eb
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

