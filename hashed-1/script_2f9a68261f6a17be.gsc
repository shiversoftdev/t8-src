// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_traps.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_b28d86fd;

/*
	Name: function_89f2df9
	Namespace: namespace_b28d86fd
	Checksum: 0x165F1B2C
	Offset: 0xE8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
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
	if(!namespace_f551babc::function_b47f6aba())
	{
		return;
	}
	namespace_f551babc::register_challenge(#"hash_149b9c514fee8fc3", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_b28d86fd
	Checksum: 0x6F54AE69
	Offset: 0x198
	Size: 0x34C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d1de6a85()
{
	callback::function_33f0ddd3(&function_33f0ddd3);
	foreach(player in getplayers())
	{
		player thread namespace_b22c99a5::function_bf710271();
		player namespace_b22c99a5::function_7dbb1712(1);
	}
	var_ec9e2b1d = getentarray("zombie_trap", "targetname");
	str_text = zm_utility::function_d6046228(#"hash_24a438482954901", #"hash_61d85c966dd9e83f");
	foreach(var_9bda8088 in var_ec9e2b1d)
	{
		if(!(isdefined(var_9bda8088._trap_in_use) && var_9bda8088._trap_in_use) && (isdefined(var_9bda8088.var_b3166dc1) && var_9bda8088.var_b3166dc1))
		{
			var_9bda8088 zm_traps::trap_set_string(str_text, var_9bda8088.zombie_cost);
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
	level namespace_f551babc::function_25ee130(1);
	level thread function_70594057();
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_b28d86fd
	Checksum: 0x814D7792
	Offset: 0x4F0
	Size: 0x220
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	callback::function_824d206(&function_33f0ddd3);
	level.var_153e9058 = undefined;
	level.var_fe2bb2ac = undefined;
	level namespace_f551babc::function_25ee130(0);
	foreach(player in getplayers())
	{
		player thread namespace_b22c99a5::function_dc0859e();
		player namespace_b22c99a5::function_7dbb1712(1);
	}
	var_ec9e2b1d = getentarray("zombie_trap", "targetname");
	str_text = zm_utility::function_d6046228(#"hash_23c1c09e94181fdb", #"hash_6e8ef1b690e98e51");
	foreach(var_9bda8088 in var_ec9e2b1d)
	{
		if(!(isdefined(var_9bda8088._trap_in_use) && var_9bda8088._trap_in_use) && (isdefined(var_9bda8088.var_b3166dc1) && var_9bda8088.var_b3166dc1))
		{
			var_9bda8088 zm_traps::trap_set_string(str_text, var_9bda8088.zombie_cost);
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
private function function_33f0ddd3(s_event)
{
	if(s_event.event === "give_weapon" && !namespace_2ba51478::function_2ff6913(s_event.weapon))
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
	s_challenge = namespace_f551babc::function_a36e8c38(#"hash_149b9c514fee8fc3");
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
	while(true)
	{
		level waittill(#"trap_kill", #"hash_528d7b7f7d6c51a1", #"hash_317f58ba0d580c27", #"hash_148b3ce521088846");
		n_kills++;
	}
}

