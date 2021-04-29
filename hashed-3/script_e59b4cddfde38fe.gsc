// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_5f342394;

/*
	Name: function_89f2df9
	Namespace: namespace_5f342394
	Checksum: 0x355AC0C0
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_6c9de9db7f3e44a3", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_5f342394
	Checksum: 0xEB6C4061
	Offset: 0xF0
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
	namespace_f551babc::register_challenge(#"hash_6c9de9db7f3e44a3", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_5f342394
	Checksum: 0x35773C68
	Offset: 0x158
	Size: 0x22C
	Parameters: 9
	Flags: Linked, Private
*/
private function function_d1de6a85(var_a84ac7c8, str_archetype, n_kill_count, str_destination, str_zone1, str_zone2, var_588808b1, var_91e2fb66, var_84245fe9)
{
	var_1968096a = array::remove_undefined(array(str_zone1, str_zone2, var_588808b1, var_91e2fb66, var_84245fe9), 0);
	level.var_8c6f70d0 = [];
	foreach(str_zone in var_1968096a)
	{
		if(!isdefined(level.var_8c6f70d0))
		{
			level.var_8c6f70d0 = [];
		}
		else if(!isarray(level.var_8c6f70d0))
		{
			level.var_8c6f70d0 = array(level.var_8c6f70d0);
		}
		if(!isinarray(level.var_8c6f70d0, str_zone))
		{
			level.var_8c6f70d0[level.var_8c6f70d0.size] = str_zone;
		}
	}
	level.var_c23449d8 = namespace_f551babc::function_5769f26a(n_kill_count);
	self.var_925854c7 = var_a84ac7c8;
	level.var_fbca3288 = 0;
	namespace_b22c99a5::function_2976fa44(level.var_c23449d8);
	namespace_b22c99a5::function_dace284(0);
	callback::on_ai_killed(&on_ai_killed);
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_5f342394
	Checksum: 0xFD41331B
	Offset: 0x390
	Size: 0xA4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	namespace_b22c99a5::function_f3dbeda7();
	n_remaining = level.var_c23449d8;
	level.var_c23449d8 = undefined;
	level.var_925854c7 = undefined;
	level.var_fbca3288 = undefined;
	callback::remove_on_ai_killed(&on_ai_killed);
	if(n_remaining > 0)
	{
		namespace_f551babc::fail(self.var_925854c7, level.players);
	}
}

/*
	Name: on_ai_killed
	Namespace: namespace_5f342394
	Checksum: 0x86F93FAB
	Offset: 0x440
	Size: 0x10C
	Parameters: 1
	Flags: Linked, Private
*/
private function on_ai_killed(params)
{
	if(self.archetype === #"gladiator" && level.var_c23449d8 > 0)
	{
		var_d217c89e = 0;
		foreach(str_zone in level.var_8c6f70d0)
		{
			if(self zm_zonemgr::entity_in_zone(str_zone, 1))
			{
				var_d217c89e = 1;
			}
		}
		if(var_d217c89e)
		{
			level.var_c23449d8--;
			level.var_fbca3288++;
			namespace_b22c99a5::function_dace284(level.var_fbca3288);
		}
	}
}

/*
	Name: function_492f4c79
	Namespace: namespace_5f342394
	Checksum: 0x47331AAE
	Offset: 0x558
	Size: 0x3C
	Parameters: 0
	Flags: Private
*/
private function function_492f4c79()
{
	level endon(#"hash_7646638df88a3656");
	wait(12);
	zm_utility::function_75fd65f9(self.var_f7f308cd, 1);
}

