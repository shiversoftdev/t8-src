// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_traps.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_b28d86fd;

/*
	Name: __init__system__
	Namespace: namespace_b28d86fd
	Checksum: 0x165F1B2C
	Offset: 0xE8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_41cb195ec280085c", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b28d86fd
	Checksum: 0xB3472DA
	Offset: 0x130
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
	zm_trial::register_challenge(#"hash_149b9c514fee8fc3", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_b28d86fd
	Checksum: 0x6F54AE69
	Offset: 0x198
	Size: 0x34C
	Parameters: 0
	Flags: Linked, Private
*/
function private on_begin()
{
	callback::function_33f0ddd3(&function_33f0ddd3);
	foreach(player in getplayers())
	{
		player thread zm_trial_util::function_bf710271();
		player zm_trial_util::function_7dbb1712(1);
	}
	a_t_traps = getentarray("zombie_trap", "targetname");
	str_text = zm_utility::function_d6046228(#"hash_24a438482954901", #"hash_61d85c966dd9e83f");
	foreach(t_trap in a_t_traps)
	{
		if(!(isdefined(t_trap._trap_in_use) && t_trap._trap_in_use) && (isdefined(t_trap.var_b3166dc1) && t_trap.var_b3166dc1))
		{
			t_trap zm_traps::trap_set_string(str_text, t_trap.zombie_cost);
		}
	}
	a_ai = getaiteamarray(level.zombie_team);
	foreach(ai in a_ai)
	{
		if(isalive(ai) && (ai.var_6f84b820 === #"miniboss" || ai.var_6f84b820 === #"heavy"))
		{
			ai.takedamage = 1;
			ai.allowdeath = 1;
			ai kill();
		}
	}
	level.var_153e9058 = 1;
	level.var_fe2bb2ac = 1;
	level zm_trial::function_25ee130(1);
	level thread function_70594057();
}

/*
	Name: on_end
	Namespace: namespace_b28d86fd
	Checksum: 0x814D7792
	Offset: 0x4F0
	Size: 0x220
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	callback::function_824d206(&function_33f0ddd3);
	level.var_153e9058 = undefined;
	level.var_fe2bb2ac = undefined;
	level zm_trial::function_25ee130(0);
	foreach(player in getplayers())
	{
		player thread zm_trial_util::function_dc0859e();
		player zm_trial_util::function_7dbb1712(1);
	}
	a_t_traps = getentarray("zombie_trap", "targetname");
	str_text = zm_utility::function_d6046228(#"hash_23c1c09e94181fdb", #"hash_6e8ef1b690e98e51");
	foreach(t_trap in a_t_traps)
	{
		if(!(isdefined(t_trap._trap_in_use) && t_trap._trap_in_use) && (isdefined(t_trap.var_b3166dc1) && t_trap.var_b3166dc1))
		{
			t_trap zm_traps::trap_set_string(str_text, t_trap.zombie_cost);
		}
	}
}

/*
	Name: function_33f0ddd3
	Namespace: namespace_b28d86fd
	Checksum: 0xCB4D7AC2
	Offset: 0x718
	Size: 0x10C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_33f0ddd3(s_event)
{
	if(s_event.event === "give_weapon" && !zm_loadout::function_2ff6913(s_event.weapon))
	{
		self function_28602a03(s_event.weapon, 1, 1);
		if(s_event.weapon.dualwieldweapon != level.weaponnone)
		{
			self function_28602a03(s_event.weapon.dualwieldweapon, 1, 1);
		}
		if(s_event.weapon.altweapon != level.weaponnone)
		{
			self function_28602a03(s_event.weapon.altweapon, 1, 1);
		}
	}
}

/*
	Name: is_active
	Namespace: namespace_b28d86fd
	Checksum: 0xD3823157
	Offset: 0x830
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function is_active()
{
	s_challenge = zm_trial::function_a36e8c38(#"hash_149b9c514fee8fc3");
	return isdefined(s_challenge);
}

/*
	Name: function_70594057
	Namespace: namespace_b28d86fd
	Checksum: 0x159BFE38
	Offset: 0x870
	Size: 0xAE
	Parameters: 0
	Flags: Linked
*/
function function_70594057()
{
	level endon(#"hash_7646638df88a3656", #"end_game");
	level waittill(#"zombie_total_set");
	n_kills = 0;
	while(true)
	{
		level waittill(#"trap_kill", #"hash_528d7b7f7d6c51a1", #"hash_317f58ba0d580c27", #"hash_148b3ce521088846");
		n_kills++;
	}
}

