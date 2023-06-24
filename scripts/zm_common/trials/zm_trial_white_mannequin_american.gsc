// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm\zm_white_private_mannequin.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace zm_trial_white_mannequin_american;

/*
	Name: __init__system__
	Namespace: zm_trial_white_mannequin_american
	Checksum: 0xB1567B8E
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_white_mannequin_american", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_white_mannequin_american
	Checksum: 0xDBDDC67C
	Offset: 0x160
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge("mannequin_american", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_white_mannequin_american
	Checksum: 0xA6055D74
	Offset: 0x1C0
	Size: 0x228
	Parameters: 0
	Flags: Linked, Private
*/
function private on_begin()
{
	var_a2c75164 = getent("mannequin_ally_door", "targetname");
	var_a2c75164 zm_white_private_mannequin::function_a51b6403(1);
	wait(1);
	level.var_1a612d42 = getplayers()[0];
	level.var_1a612d42.eligible_leader = 1;
	mannequin_ally_spawner = getent("mannequin_american_spawner", "targetname");
	if(isdefined(mannequin_ally_spawner))
	{
		level.mannequin_ally = mannequin_ally_spawner spawnfromspawner();
		util::magic_bullet_shield(level.mannequin_ally);
		level.mannequin_ally.aioverridedamage = array(&function_26edbcdc);
		level thread function_7532e17c(level.mannequin_ally);
	}
	var_a2c75164 zm_white_private_mannequin::function_a51b6403(0);
	callback::function_33f0ddd3(&function_33f0ddd3);
	level zm_trial::function_25ee130(1);
	if(isdefined(level.mannequin_ally))
	{
		foreach(player in getplayers())
		{
			player thread function_545d53bf();
		}
	}
}

/*
	Name: on_end
	Namespace: zm_trial_white_mannequin_american
	Checksum: 0x20356E11
	Offset: 0x3F0
	Size: 0x13C
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	callback::function_824d206(&function_33f0ddd3);
	level zm_trial::function_25ee130(0);
	foreach(player in getplayers())
	{
		player thread zm_trial_util::function_dc0859e();
	}
	if(isdefined(level.mannequin_ally) && isalive(level.mannequin_ally))
	{
		level.mannequin_ally notify(#"revive_terminated");
		util::stop_magic_bullet_shield(level.mannequin_ally);
		level.mannequin_ally kill();
	}
}

/*
	Name: function_26edbcdc
	Namespace: zm_trial_white_mannequin_american
	Checksum: 0xB480260
	Offset: 0x538
	Size: 0x66
	Parameters: 12
	Flags: Linked
*/
function function_26edbcdc(inflictor, attacker, damage, flags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	return false;
}

/*
	Name: function_545d53bf
	Namespace: zm_trial_white_mannequin_american
	Checksum: 0xA7C8CE21
	Offset: 0x5A8
	Size: 0x10E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_545d53bf()
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	var_407eb07 = 0;
	while(true)
	{
		var_972e1f84 = 0;
		dist = distancesquared(self.origin, level.mannequin_ally.origin);
		if(dist <= 40000)
		{
			var_972e1f84 = 1;
		}
		if(var_972e1f84 && var_407eb07)
		{
			self zm_trial_util::function_dc0859e();
			var_407eb07 = 0;
		}
		else if(!var_972e1f84 && !var_407eb07)
		{
			self zm_trial_util::function_bf710271();
			var_407eb07 = 1;
		}
		waitframe(1);
	}
}

/*
	Name: function_33f0ddd3
	Namespace: zm_trial_white_mannequin_american
	Checksum: 0x705EF076
	Offset: 0x6C0
	Size: 0x124
	Parameters: 1
	Flags: Linked, Private
*/
function private function_33f0ddd3(s_event)
{
	if(s_event.event === "give_weapon")
	{
		var_972e1f84 = 0;
		dist = distancesquared(self.origin, level.mannequin_ally.origin);
		if(dist <= 40000)
		{
			var_972e1f84 = 1;
		}
		if(!var_972e1f84 && !zm_loadout::function_2ff6913(s_event.weapon))
		{
			self function_28602a03(s_event.weapon, 1, 1);
			if(s_event.weapon.dualwieldweapon != level.weaponnone)
			{
				self function_28602a03(s_event.weapon.dualwieldweapon, 1, 1);
			}
		}
	}
}

/*
	Name: function_7532e17c
	Namespace: zm_trial_white_mannequin_american
	Checksum: 0xB0B27D54
	Offset: 0x7F0
	Size: 0x14C
	Parameters: 1
	Flags: Linked
*/
function function_7532e17c(ai_mannequin)
{
	level endon(#"end_game");
	obj_id = gameobjects::get_next_obj_id();
	if(!isdefined(self.a_n_objective_ids))
	{
		self.a_n_objective_ids = [];
	}
	else if(!isarray(self.a_n_objective_ids))
	{
		self.a_n_objective_ids = array(self.a_n_objective_ids);
	}
	self.a_n_objective_ids[self.a_n_objective_ids.size] = obj_id;
	objective_add(obj_id, "active", ai_mannequin, #"hash_423a75e2700a53ab");
	function_da7940a3(obj_id, 1);
	while(isdefined(ai_mannequin))
	{
		waitframe(1);
	}
	objective_setinvisibletoall(obj_id);
	objective_delete(obj_id);
	gameobjects::release_obj_id(obj_id);
}

