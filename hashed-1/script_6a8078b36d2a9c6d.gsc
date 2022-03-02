// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_35598499769dbb3d;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm\zm_lightning_chain.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_2cbb6c62;

/*
	Name: function_89f2df9
	Namespace: namespace_2cbb6c62
	Checksum: 0x80E015A6
	Offset: 0x148
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_4b8517108556612", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_2cbb6c62
	Checksum: 0x905D2D4A
	Offset: 0x190
	Size: 0x33C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_25c1f211 = getweapon(#"ww_tesla_sniper_t8");
	level.var_77b3abb1 = getweapon(#"ww_tesla_sniper_upgraded_t8");
	level.var_79959866 = spawnstruct();
	level.var_79959866.base = spawnstruct();
	level.var_79959866.upgraded = spawnstruct();
	level.var_79959866.base.var_38cd3d0e = lightning_chain::create_lightning_chain_params(10, 11, 256);
	level.var_79959866.base.var_38cd3d0e.head_gib_chance = 0;
	level.var_79959866.base.var_38cd3d0e.network_death_choke = 4;
	level.var_79959866.base.var_38cd3d0e.should_kill_enemies = 0;
	level.var_79959866.base.var_38cd3d0e.no_fx = 1;
	level.var_79959866.base.var_38cd3d0e.clientside_fx = 0;
	level.var_79959866.base.var_38cd3d0e.str_mod = "MOD_ELECTROCUTED";
	level.var_79959866.base.var_38cd3d0e.n_damage_max = 20000;
	level.var_79959866.base.var_38cd3d0e.var_a9255d36 = #"hash_1003dc8cc0b680f2";
	level.var_79959866.upgraded.var_38cd3d0e = lightning_chain::create_lightning_chain_params();
	zm::function_84d343d(#"ww_tesla_sniper_t8", &function_5ff12a45);
	zm::function_84d343d(#"ww_tesla_sniper_upgraded_t8", &function_5ff12a45);
	callback::function_f77ced93(&function_f77ced93);
	clientfield::register("toplayer", "" + #"hash_3aad9502fc3b54f2", 24000, 1, "int");
	clientfield::register("actor", "zm_weapons/fx8_ww_tesla_sniper_impact_lg", 24000, 1, "counter");
}

/*
	Name: function_5ff12a45
	Namespace: namespace_2cbb6c62
	Checksum: 0xA4305665
	Offset: 0x4D8
	Size: 0xEC
	Parameters: 12
	Flags: Linked
*/
function function_5ff12a45(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	b_result = self function_fd1a163d(attacker, damage, meansofdeath, weapon, shitloc);
	if(!b_result)
	{
		b_result = self function_de59b16a(attacker, meansofdeath, level.var_79959866.base.var_38cd3d0e, weapon);
	}
	if(!b_result)
	{
		return damage;
	}
	return 1;
}

/*
	Name: function_f77ced93
	Namespace: namespace_2cbb6c62
	Checksum: 0x551E8E66
	Offset: 0x5D0
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_f77ced93(s_params)
{
	if(function_b7a6f208(s_params.weapon))
	{
		self clientfield::set_to_player("" + #"hash_3aad9502fc3b54f2", 1);
	}
	else if(function_b7a6f208(s_params.last_weapon))
	{
		self clientfield::set_to_player("" + #"hash_3aad9502fc3b54f2", 0);
	}
}

/*
	Name: function_de59b16a
	Namespace: namespace_2cbb6c62
	Checksum: 0xF18E4BDD
	Offset: 0x680
	Size: 0xA4
	Parameters: 4
	Flags: Linked
*/
function function_de59b16a(e_source, str_mod, var_8e05c280, weapon)
{
	if(isplayer(e_source) && str_mod == "MOD_RIFLE_BULLET" && !self ai::is_stunned())
	{
		e_source.tesla_enemies_hit = 1;
		self thread function_9f86f360(e_source, 3, 128);
		return true;
	}
	return false;
}

/*
	Name: function_fd1a163d
	Namespace: namespace_2cbb6c62
	Checksum: 0xDA1109DF
	Offset: 0x730
	Size: 0x1AC
	Parameters: 5
	Flags: Linked
*/
function function_fd1a163d(e_source, damage, meansofdeath, weapon, shitloc)
{
	if(isplayer(e_source) && (weapon == level.var_25c1f211 || weapon == level.var_77b3abb1) && self.archetype === #"zombie" && zm_utility::is_headshot(weapon, shitloc, meansofdeath, 1) && damage >= self.health && !self ai::is_stunned())
	{
		self clientfield::increment("zm_weapons/fx8_ww_tesla_sniper_impact_lg");
		self clientfield::set("zm_aat_kill_o_watt" + "_zap", 1);
		if(self.no_gib !== 1)
		{
			gibserverutils::gibhead(self);
		}
		self ai::stun();
		self thread function_487ae8a7(e_source, meansofdeath, weapon, shitloc);
		level thread function_e0525d4e(self, e_source, meansofdeath, weapon, shitloc);
		return true;
	}
	return false;
}

/*
	Name: function_e0525d4e
	Namespace: namespace_2cbb6c62
	Checksum: 0x5A077E4B
	Offset: 0x8E8
	Size: 0x21E
	Parameters: 5
	Flags: Linked
*/
function function_e0525d4e(var_6a3758f2, e_source, meansofdeath, weapon, shitloc)
{
	level endon(#"end_game");
	a_zombies = getaiteamarray(level.zombie_team);
	arrayremovevalue(a_zombies, var_6a3758f2);
	a_zombies = arraysortclosest(a_zombies, var_6a3758f2 getcentroid(), 10, 0, 256);
	foreach(zombie in a_zombies)
	{
		zombie clientfield::set("zm_aat_kill_o_watt" + "_zap", 1);
		zombie ai::stun();
	}
	wait(0.5);
	var_bf7a56c5 = int(ceil(a_zombies.size / 3));
	for(i = 0; i < a_zombies.size; i++)
	{
		if((i % var_bf7a56c5) == 0)
		{
			wait(1.5 / 3);
		}
		if(isdefined(a_zombies[i]))
		{
			a_zombies[i] function_4764da22(e_source, meansofdeath, weapon, undefined);
		}
	}
}

/*
	Name: function_4764da22
	Namespace: namespace_2cbb6c62
	Checksum: 0x22E3AB25
	Offset: 0xB10
	Size: 0x8C
	Parameters: 4
	Flags: Linked
*/
function function_4764da22(e_source, meansofdeath, weapon, shitloc)
{
	if(isdefined(self))
	{
		self dodamage(self.maxhealth + 666, self.origin, e_source, undefined, shitloc, meansofdeath, 0, weapon);
		if(self.no_gib !== 1)
		{
			gibserverutils::annihilate(self);
		}
	}
}

/*
	Name: function_487ae8a7
	Namespace: namespace_2cbb6c62
	Checksum: 0xE1CF433F
	Offset: 0xBA8
	Size: 0x8C
	Parameters: 4
	Flags: Linked
*/
function function_487ae8a7(e_source, meansofdeath, weapon, shitloc)
{
	self endon(#"death");
	level endon(#"end_game");
	wait(randomfloatrange(3.5, 4));
	if(isdefined(self))
	{
		self function_4764da22(e_source, meansofdeath, weapon, shitloc);
	}
}

/*
	Name: function_b7a6f208
	Namespace: namespace_2cbb6c62
	Checksum: 0x56814CAD
	Offset: 0xC40
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_b7a6f208(w_weapon)
{
	return isdefined(w_weapon) && (w_weapon == level.var_25c1f211 || w_weapon == level.var_77b3abb1);
}

/*
	Name: function_9f86f360
	Namespace: namespace_2cbb6c62
	Checksum: 0x15667E71
	Offset: 0xC88
	Size: 0x140
	Parameters: 3
	Flags: Linked
*/
function function_9f86f360(e_player, var_3e8e91cb, n_range)
{
	if(isdefined(self.spawn_time) && gettime() == self.spawn_time)
	{
		waitframe(1);
	}
	if(isdefined(self))
	{
		self clientfield::increment("zm_aat_kill_o_watt" + "_explosion", 1);
	}
	a_zombies = getaiteamarray(level.zombie_team);
	a_zombies = arraysortclosest(a_zombies, self getcentroid(), var_3e8e91cb, 0, n_range);
	foreach(e_zombie in a_zombies)
	{
		e_zombie function_bd5b7309(e_player, self);
	}
}

/*
	Name: function_bd5b7309
	Namespace: namespace_2cbb6c62
	Checksum: 0xB496DC1
	Offset: 0xDD0
	Size: 0x154
	Parameters: 2
	Flags: Linked
*/
function function_bd5b7309(player, var_fb0999c0)
{
	if(!isalive(self))
	{
		return;
	}
	if(isdefined(level.aat[#"zm_aat_kill_o_watt"].immune_result_indirect[self.archetype]) && level.aat[#"zm_aat_kill_o_watt"].immune_result_indirect[self.archetype])
	{
		return;
	}
	if(self == var_fb0999c0 && (isdefined(level.aat[#"zm_aat_kill_o_watt"].immune_result_direct[self.archetype]) && level.aat[#"zm_aat_kill_o_watt"].immune_result_direct[self.archetype]))
	{
		return;
	}
	if(self ai::is_stunned() || (isdefined(self.var_81879441) && self.var_81879441))
	{
		return;
	}
	self.var_81879441 = 1;
	self thread function_5253f1fb(player);
}

/*
	Name: function_5253f1fb
	Namespace: namespace_2cbb6c62
	Checksum: 0xCBFA9544
	Offset: 0xF30
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_5253f1fb(player)
{
	self endon(#"death");
	self clientfield::set("zm_aat_kill_o_watt" + "_zap", 1);
	self lightning_chain::arc_damage_ent(player, 2, level.var_79959866.base.var_38cd3d0e);
	wait(randomfloatrange(3.5, 4));
	self thread function_80fa8760();
}

/*
	Name: function_80fa8760
	Namespace: namespace_2cbb6c62
	Checksum: 0x9E531DC7
	Offset: 0xFF8
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function function_80fa8760()
{
	if(isdefined(self.var_81879441) && self.var_81879441)
	{
		self.var_81879441 = undefined;
		self clientfield::set("zm_aat_kill_o_watt" + "_zap", 0);
		self notify(#"hash_1003dc8cc0b680f2");
	}
}

