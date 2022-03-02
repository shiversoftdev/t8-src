// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_3f9e0dc8454d98e1;
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_6f53a9bb;

/*
	Name: function_89f2df9
	Namespace: namespace_6f53a9bb
	Checksum: 0x3A373AE6
	Offset: 0x140
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_530f1e3dbb50b5f6", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_6f53a9bb
	Checksum: 0xB95E9AFC
	Offset: 0x188
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	clientfield::register("scriptmover", "" + #"hash_530f1e3dbb50b5f6", 16000, 1, "int");
	zm_trial::register_challenge(#"hash_6f720e698e84015d", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_6f53a9bb
	Checksum: 0x7FD88030
	Offset: 0x230
	Size: 0xCC
	Parameters: 0
	Flags: Private
*/
function private function_d1de6a85()
{
	function_58fc4e38(8);
	level flag::set(#"hash_1b9ecc7979b0fcfb");
	var_57ba058f = getentarray("gondola_call_trigger", "targetname");
	var_9ce0aba1 = getentarray("gondola_move_trigger", "targetname");
	array::run_all(var_57ba058f, &setinvisibletoall);
	array::run_all(var_9ce0aba1, &setinvisibletoall);
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_6f53a9bb
	Checksum: 0xBBDA85B5
	Offset: 0x308
	Size: 0xCC
	Parameters: 1
	Flags: Private
*/
function private function_9e7b3f4d(round_reset)
{
	level flag::clear(#"hash_1b9ecc7979b0fcfb");
	var_57ba058f = getentarray("gondola_call_trigger", "targetname");
	var_9ce0aba1 = getentarray("gondola_move_trigger", "targetname");
	array::run_all(var_57ba058f, &setvisibletoall);
	array::run_all(var_9ce0aba1, &setvisibletoall);
	function_92f23ef0();
}

/*
	Name: is_active
	Namespace: namespace_6f53a9bb
	Checksum: 0x5B00F1B1
	Offset: 0x3E0
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	s_challenge = zm_trial::function_a36e8c38(#"hash_6f720e698e84015d");
	return isdefined(s_challenge);
}

/*
	Name: function_58fc4e38
	Namespace: namespace_6f53a9bb
	Checksum: 0x9A4938D3
	Offset: 0x420
	Size: 0x190
	Parameters: 1
	Flags: None
*/
function function_58fc4e38(n_delay = 0)
{
	level endon(#"hash_7646638df88a3656");
	wait(n_delay);
	var_d2af5572 = struct::get_array("trials_door_lockdown_clip");
	foreach(s_blocker in var_d2af5572)
	{
		if(!isdefined(s_blocker.mdl_blocker))
		{
			s_blocker.mdl_blocker = util::spawn_model((isdefined(s_blocker.model) ? s_blocker.model : #"collision_player_wall_128x128x10"), s_blocker.origin, s_blocker.angles);
		}
		s_blocker.mdl_blocker ghost();
		util::wait_network_frame();
		s_blocker.mdl_blocker clientfield::set("" + #"hash_530f1e3dbb50b5f6", 1);
	}
}

/*
	Name: function_92f23ef0
	Namespace: namespace_6f53a9bb
	Checksum: 0x6CAC6F61
	Offset: 0x5B8
	Size: 0x128
	Parameters: 1
	Flags: None
*/
function function_92f23ef0(n_delay = 0)
{
	level endon(#"hash_7646638df88a3656");
	wait(n_delay);
	var_d2af5572 = struct::get_array("trials_door_lockdown_clip");
	foreach(s_blocker in var_d2af5572)
	{
		if(isdefined(s_blocker.mdl_blocker))
		{
			s_blocker.mdl_blocker clientfield::set("" + #"hash_530f1e3dbb50b5f6", 0);
			util::wait_network_frame();
			s_blocker.mdl_blocker delete();
		}
	}
}

