// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_24c32478acf44108;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_aat_frostbite;

/*
	Name: function_89f2df9
	Namespace: zm_aat_frostbite
	Checksum: 0x97075212
	Offset: 0x188
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register("zm_aat_frostbite", &__init__, undefined, #"aat");
}

/*
	Name: __init__
	Namespace: zm_aat_frostbite
	Checksum: 0x4346A532
	Offset: 0x1D0
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.aat_in_use) && level.aat_in_use))
	{
		return;
	}
	aat::register("zm_aat_frostbite", 0.75, 0, 0, 0, 1, &result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr", undefined, 4);
	clientfield::register("actor", "zm_aat_frostbite_trail_clientfield", 1, 1, "int");
	clientfield::register("vehicle", "zm_aat_frostbite_trail_clientfield", 1, 1, "int");
	clientfield::register("actor", "zm_aat_frostbite_explosion_clientfield", 1, 1, "counter");
	clientfield::register("vehicle", "zm_aat_frostbite_explosion_clientfield", 1, 1, "counter");
	namespace_9ff9f642::register_slowdown(#"hash_7cb479d48ba9bbd6", 0.1, 3);
}

/*
	Name: result
	Namespace: zm_aat_frostbite
	Checksum: 0x1111D934
	Offset: 0x340
	Size: 0x104
	Parameters: 4
	Flags: Linked
*/
function result(death, attacker, mod, weapon)
{
	self notify(#"hash_3c2776b4262d3359");
	self endon(#"hash_3c2776b4262d3359");
	if(!isactor(self) && !isvehicle(self))
	{
		return;
	}
	if(isdefined(self.aat_turned) && self.aat_turned)
	{
		return;
	}
	if(death && function_a2e05e6(attacker))
	{
		level thread frostbite_explosion(self, self.origin, attacker, mod, weapon);
	}
	else
	{
		self thread function_158a3a18(attacker, mod, weapon);
	}
}

/*
	Name: function_a2e05e6
	Namespace: zm_aat_frostbite
	Checksum: 0x50C0D48
	Offset: 0x450
	Size: 0xCE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a2e05e6(e_attacker)
{
	n_current_time = float(gettime()) / 1000;
	if(isplayer(e_attacker))
	{
		if(!isdefined(e_attacker.aat_cooldown_start[#"zm_aat_frostbite_explosion"]))
		{
			return 1;
		}
		if(isdefined(e_attacker.aat_cooldown_start[#"zm_aat_frostbite_explosion"]) && n_current_time >= (e_attacker.aat_cooldown_start[#"zm_aat_frostbite_explosion"] + 30))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_158a3a18
	Namespace: zm_aat_frostbite
	Checksum: 0xE2E5B37E
	Offset: 0x528
	Size: 0x1C4
	Parameters: 4
	Flags: Linked
*/
function function_158a3a18(attacker, mod, weapon, var_e1ec1eee = 0)
{
	self endon(#"death");
	if(!isdefined(self.var_cbf4894c))
	{
		self.var_cbf4894c = 1;
	}
	else if(self.var_cbf4894c <= 0.4)
	{
		return;
	}
	if(!isdefined(weapon) || !isdefined(attacker) || !isplayer(attacker))
	{
		return;
	}
	if(var_e1ec1eee)
	{
		self.var_cbf4894c = 0.4;
	}
	else
	{
		var_1b767d36 = zm_weapons::get_base_weapon(weapon);
		var_fa87e189 = var_1b767d36.firetime;
		self.var_cbf4894c = self.var_cbf4894c - (var_fa87e189 * 1.5);
		if(self.var_cbf4894c <= 0.4)
		{
			self.var_cbf4894c = 0.4;
		}
	}
	self clientfield::set("zm_aat_frostbite_trail_clientfield", 1);
	self thread namespace_9ff9f642::slowdown(#"hash_7cb479d48ba9bbd6", self.var_cbf4894c);
	self thread function_dab102b8(attacker, weapon);
	self thread function_35d3ac3b();
}

/*
	Name: function_dab102b8
	Namespace: zm_aat_frostbite
	Checksum: 0xB83D35B2
	Offset: 0x6F8
	Size: 0x116
	Parameters: 2
	Flags: Linked
*/
function function_dab102b8(e_attacker, weapon)
{
	self notify(#"hash_6f92e6943e40092b");
	self endon(#"hash_6f92e6943e40092b", #"death");
	for(i = 0; i < 8; i++)
	{
		wait(0.375);
		self.var_cbf4894c = self.var_cbf4894c + 0.125;
		if(self.var_cbf4894c >= 1)
		{
			break;
			continue;
		}
		self thread namespace_9ff9f642::slowdown(#"hash_7cb479d48ba9bbd6", self.var_cbf4894c);
	}
	self clientfield::set("zm_aat_frostbite_trail_clientfield", 0);
	self.var_cbf4894c = 1;
	self notify(#"hash_652c15c8a7e2949");
}

/*
	Name: function_35d3ac3b
	Namespace: zm_aat_frostbite
	Checksum: 0x421E6B02
	Offset: 0x818
	Size: 0xEC
	Parameters: 3
	Flags: Linked
*/
function function_35d3ac3b(attacker, mod, weapon)
{
	self notify(#"hash_b04750a529cb350");
	self endon(#"hash_b04750a529cb350", #"hash_652c15c8a7e2949");
	self waittill(#"death");
	if(isdefined(self))
	{
		if(self.var_cbf4894c <= 0.6 && function_a2e05e6(attacker))
		{
			level thread frostbite_explosion(self, self.origin, attacker, mod, weapon);
		}
		else
		{
			self namespace_9ff9f642::function_520f4da5(#"hash_7cb479d48ba9bbd6");
		}
	}
}

/*
	Name: frostbite_explosion
	Namespace: zm_aat_frostbite
	Checksum: 0x3E6F324A
	Offset: 0x910
	Size: 0x2A8
	Parameters: 5
	Flags: Linked
*/
function frostbite_explosion(var_4589e270, var_23255fc5, attacker, mod, weapon)
{
	if(randomfloat(100) > 40)
	{
		return;
	}
	var_4589e270 clientfield::increment("zm_aat_frostbite_explosion_clientfield");
	if(isplayer(attacker))
	{
		attacker.aat_cooldown_start[#"zm_aat_frostbite_explosion"] = float(gettime()) / 1000;
		attacker zm_stats::increment_challenge_stat(#"hash_4b615433ed6a8afd");
	}
	a_potential_targets = array::get_all_closest(var_23255fc5, level.ai[#"axis"], undefined, undefined, 128);
	foreach(e_target in a_potential_targets)
	{
		if(!isalive(e_target))
		{
			continue;
		}
		if(isdefined(level.aat[#"zm_aat_frostbite"].immune_result_indirect[e_target.archetype]) && level.aat[#"zm_aat_frostbite"].immune_result_indirect[e_target.archetype])
		{
			return;
		}
		if(!(isdefined(e_target.var_7cc959b1) && e_target.var_7cc959b1))
		{
			continue;
		}
		if(var_4589e270 === e_target)
		{
			continue;
		}
		e_target function_11c85ac6(var_23255fc5, attacker, weapon);
		if(isalive(e_target))
		{
			e_target thread function_158a3a18(attacker, mod, weapon, 1);
		}
		util::wait_network_frame();
	}
}

/*
	Name: function_11c85ac6
	Namespace: zm_aat_frostbite
	Checksum: 0xB329E179
	Offset: 0xBC0
	Size: 0xBC
	Parameters: 3
	Flags: Linked
*/
function function_11c85ac6(var_23255fc5, e_attacker, weapon)
{
	n_damage = 20000;
	self dodamage(n_damage, var_23255fc5, e_attacker, undefined, "none", "MOD_AAT", 0, weapon);
	if(!isalive(self) && isplayer(e_attacker))
	{
		e_attacker zm_stats::increment_challenge_stat(#"hash_4b615433ed6a8afd");
	}
}

