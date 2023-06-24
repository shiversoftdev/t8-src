// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;

#namespace namespace_e7fb1aea;

/*
	Name: __init__system__
	Namespace: namespace_e7fb1aea
	Checksum: 0xCCA35D9F
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_6e4fd4c82cd73524", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_e7fb1aea
	Checksum: 0x69E22B4B
	Offset: 0xE8
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
	zm_trial::register_challenge(#"hash_6e4fd4c82cd73524", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_e7fb1aea
	Checksum: 0xA4FCA65B
	Offset: 0x150
	Size: 0x12C
	Parameters: 1
	Flags: Private
*/
function private on_begin(n_kill_count)
{
	level.var_f7e95a13 = zm_trial::function_5769f26a(n_kill_count);
	foreach(player in getplayers())
	{
		player.var_76bb4a3e = 0;
		player zm_trial_util::function_c2cd0cba(level.var_f7e95a13);
		player zm_trial_util::function_2190356a(player.var_76bb4a3e);
		player callback::on_death(&on_death);
	}
	callback::on_ai_killed(&on_ai_killed);
}

/*
	Name: on_end
	Namespace: namespace_e7fb1aea
	Checksum: 0x5266C4C8
	Offset: 0x288
	Size: 0x306
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	var_7df0eb27 = level.var_f7e95a13;
	level.var_f7e95a13 = undefined;
	foreach(player in getplayers())
	{
		player zm_trial_util::function_f3aacffb();
		player callback::remove_on_death(&on_death);
	}
	callback::remove_on_ai_killed(&on_ai_killed);
	if(!round_reset)
	{
		var_acba5af0 = [];
		foreach(player in getplayers())
		{
			if(isdefined(player.var_76bb4a3e) && player.var_76bb4a3e < var_7df0eb27)
			{
				if(!isdefined(var_acba5af0))
				{
					var_acba5af0 = [];
				}
				else if(!isarray(var_acba5af0))
				{
					var_acba5af0 = array(var_acba5af0);
				}
				if(!isinarray(var_acba5af0, player))
				{
					var_acba5af0[var_acba5af0.size] = player;
				}
			}
		}
		if(var_acba5af0.size == 1)
		{
			zm_trial::fail(#"hash_18fa90427a117729", var_acba5af0);
			function_d99b4aa5();
		}
		else if(var_acba5af0.size > 1)
		{
			zm_trial::fail(#"hash_68076ef1f7244678", var_acba5af0);
			function_d99b4aa5();
		}
	}
	else
	{
		function_d99b4aa5();
	}
	foreach(player in getplayers())
	{
		player.var_76bb4a3e = undefined;
	}
}

/*
	Name: on_ai_killed
	Namespace: namespace_e7fb1aea
	Checksum: 0x7293900F
	Offset: 0x598
	Size: 0x13C
	Parameters: 1
	Flags: Private
*/
function private on_ai_killed(params)
{
	e_attacker = params.eattacker;
	if(!isplayer(e_attacker))
	{
		e_attacker = params.einflictor;
	}
	if(isdefined(params.weapon) && isplayer(e_attacker) && (zm_loadout::is_hero_weapon(params.weapon) || zm_hero_weapon::function_6a32b8f(params.weapon)) && (isdefined(e_attacker.var_76bb4a3e) && e_attacker.var_76bb4a3e < level.var_f7e95a13))
	{
		e_attacker.var_76bb4a3e++;
		e_attacker zm_trial_util::function_2190356a(e_attacker.var_76bb4a3e);
		if(e_attacker.var_76bb4a3e == level.var_f7e95a13)
		{
			e_attacker zm_trial_util::function_63060af4(1);
		}
	}
}

/*
	Name: function_d99b4aa5
	Namespace: namespace_e7fb1aea
	Checksum: 0x10158D50
	Offset: 0x6E0
	Size: 0x90
	Parameters: 0
	Flags: Private
*/
function private function_d99b4aa5()
{
	foreach(e_player in getplayers())
	{
		e_player gadgetpowerset(level.var_a53a05b5, 100);
	}
}

/*
	Name: on_death
	Namespace: namespace_e7fb1aea
	Checksum: 0xC78D03C1
	Offset: 0x778
	Size: 0x64
	Parameters: 1
	Flags: Private
*/
function private on_death(params)
{
	if(isdefined(self.var_76bb4a3e) && self.var_76bb4a3e < level.var_f7e95a13)
	{
		zm_trial::fail(#"hash_18fa90427a117729", array(self));
	}
}

